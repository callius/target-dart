import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:target/target.dart';
import 'package:target_annotation/target_annotation.dart';
import 'package:target_annotation_processor/src/core/checker.dart';
import 'package:target_annotation_processor/src/core/domain/model_property.dart';
import 'package:target_annotation_processor/src/core/domain/model_property_type.dart';
import 'package:target_annotation_processor/src/core/generate_field_failure_specs.dart';
import 'package:target_annotation_processor/src/core/generate_of_spec.dart';
import 'package:target_annotation_processor/src/core/references.dart';

final _emitter = DartEmitter(orderDirectives: true, useNullSafetySyntax: true);

class ModelGenerator extends GeneratorForAnnotation<Validatable> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    // Checking for a class.
    if (element is! ClassElement) {
      final elementName = element.displayName;
      throw InvalidGenerationSourceError(
        'Generator cannot target `$elementName`, as it is not an abstract '
        'class.',
        todo: 'Remove the [Validatable] annotation from `$elementName`.',
      );
    }

    final fragment = element.firstFragment;

    // Checking for an unnamed constructor.
    final ctor = fragment.constructors.firstWhereOrNull(
      (it) => it.name == 'new',
    );
    if (ctor == null) {
      final friendlyName = element.displayName;
      final ctorNames = fragment.constructors.map((it) => it.name);
      throw InvalidGenerationSourceError(
        'Generator cannot target `$friendlyName`, as it does not define an '
        'unnamed constructor. Constructors found: $ctorNames',
        todo: 'Define an unnamed constructor for `$friendlyName`.',
      );
    }

    // Finding all constructor parameters.
    final parameters = ctor.formalParameters;

    // Checking for at least one parameter.
    if (parameters.isEmpty) {
      final friendlyName = element.displayName;
      throw InvalidGenerationSourceError(
        '`$friendlyName` must declare at least one parameter in its '
        'constructor.',
        todo: 'Add one or more parameters to `$friendlyName`().',
      );
    }

    // Creating type references.
    final failureReference = TypeReference(
      (it) => it..symbol = '${fragment.name}FieldFailure',
    );
    final modelReference = Reference(fragment.name);

    // Creating model properties.
    final modelProperties = _generateModelProperties(
      failureReference: failureReference,
      parameters: parameters,
    );

    // Generating model.
    return Library(
      (it) =>
          it
            ..comments.add('Generated code. Do not modify by hand.')
            ..ignoreForFile.addAll(const [
              'require_trailing_commas',
              'unused_element',
            ])
            ..body.addAll([
              generateOfSpec(
                modelReference: modelReference,
                fieldFailureReference: failureReference,
                modelProperties: modelProperties,
              ),
              ...generateFieldFailureSpecs(
                fieldFailureReference: failureReference,
                modelProperties: modelProperties,
              ),
            ]),
    ).accept(_emitter).toString();
  }

  List<ModelProperty> _generateModelProperties({
    required Reference failureReference,
    required Iterable<FormalParameterFragment> parameters,
  }) {
    return parameters
        .map(
          (it) => ModelProperty(
            name: it.name!,
            type: _resolveModelPropertyType(failureReference, it),
          ),
        )
        .toList();
  }

  ModelPropertyType _resolveModelPropertyType(
    Reference failureReference,
    FormalParameterFragment parameter,
  ) {
    final parameterElement = parameter.element;

    final type = parameterElement.type;
    if (type is! InterfaceType) {
      return _standardModelPropertyType(type);
    }

    // Finding option parameters.
    final typeElement = type.element;
    if (typeElement.firstFragment.name == kOptionRef.symbol) {
      final optionValueType = type.typeArguments.first;
      if (optionValueType is InterfaceType) {
        final optionValueTypeElement = optionValueType.element;
        // Finding model template option.
        if (optionValueType.element.metadata.annotations
            .containsValidatable()) {
          return _resolveValidatableProperties(
            failureReference: failureReference,
            parameter: parameter,
            modelType: optionValueType,
            resolve:
                (
                  modelTypeReference,
                  parentFieldFailureType,
                  fieldFailureType,
                ) => ModelPropertyType.modelTemplateOption(
                  type: type.toTypeReference(),
                  modelType: modelTypeReference,
                  parentFieldFailureType: parentFieldFailureType,
                  fieldFailureType: fieldFailureType,
                ),
          );
        }

        // Finding value object type option.
        final valueObjectInterfaceType =
            optionValueTypeElement.allSupertypes.findValueObject();
        if (valueObjectInterfaceType != null) {
          return _resolveValueObjectProperties(
            failureReference: failureReference,
            parameter: parameter,
            valueObjectType: optionValueType,
            valueObjectElement: optionValueTypeElement,
            valueObjectInterfaceType: valueObjectInterfaceType,
            resolve:
                (
                  valueObjectType,
                  valueObjectValueType,
                  valueFailureType,
                  fieldFailureType,
                ) => ModelPropertyType.valueObjectOption(
                  type: type.toTypeReference(),
                  valueObjectType: valueObjectType,
                  valueObjectValueType: valueObjectValueType,
                  valueFailureType: valueFailureType,
                  fieldFailureType: fieldFailureType,
                ),
          );
        }
      }
    }

    final isValidatable =
        typeElement.metadata.annotations.containsValidatable();
    if (isValidatable) {
      return _resolveValidatableProperties(
        failureReference: failureReference,
        parameter: parameter,
        modelType: type,
        resolve:
            (modelTypeReference, parentFieldFailureType, fieldFailureType) =>
                ModelPropertyType.modelTemplate(
                  type: modelTypeReference,
                  parentFieldFailureType: parentFieldFailureType,
                  fieldFailureType: fieldFailureType,
                ),
      );
    }

    // Finding the value object interface.
    final valueObjectInterfaceType =
        typeElement.allSupertypes.findValueObject();
    if (valueObjectInterfaceType != null) {
      return _resolveValueObjectProperties(
        failureReference: failureReference,
        parameter: parameter,
        valueObjectType: type,
        valueObjectElement: typeElement,
        valueObjectInterfaceType: valueObjectInterfaceType,
        resolve:
            (
              valueObjectType,
              valueObjectValueType,
              valueFailureType,
              fieldFailureType,
            ) => ModelPropertyType.valueObject(
              type: valueObjectType,
              valueObjectValueType: valueObjectValueType,
              valueFailureType: valueFailureType,
              fieldFailureType: fieldFailureType,
            ),
      );
    }

    return _standardModelPropertyType(type);
  }

  ModelPropertyType _resolveValidatableProperties({
    required Reference failureReference,
    required FormalParameterFragment parameter,
    required DartType modelType,
    required ModelPropertyType Function(
      TypeReference modelTypeReference,
      TypeReference parentFieldFailureType,
      TypeReference fieldFailureType,
    )
    resolve,
  }) {
    final modelTypeReference = modelType.toTypeReference();
    return resolve(
      modelTypeReference,
      TypeReference(
        (it) =>
            it
              ..symbol =
                  modelType.element!.firstFragment.name!.appendFieldFailure()
              ..url = modelTypeReference.url,
      ),
      _getFieldFailureType(failureReference, parameter),
    );
  }

  ModelPropertyType _resolveValueObjectProperties({
    required Reference failureReference,
    required FormalParameterFragment parameter,
    required DartType valueObjectType,
    required InterfaceElement valueObjectElement,
    required InterfaceType valueObjectInterfaceType,
    required ModelPropertyType Function(
      TypeReference valueObjectType,
      TypeReference valueObjectValueType,
      TypeReference valueFailureType,
      TypeReference fieldFailureType,
    )
    resolve,
  }) {
    // Finding the value validator field.
    final valueValidatorField = valueObjectElement.firstFragment.fields
        .firstWhereOrNull((it) => it.name == 'of' && it.element.isStatic);
    if (valueValidatorField == null) {
      final displayName = valueObjectElement.displayName;
      throw InvalidGenerationSourceError(
        '`$displayName` must declare a value validator in a static field `of`.',
        todo: 'Add a static value validator, named `of`, to `$displayName`.',
      );
    }

    // Finding the value failure type.
    final valueFailureType =
        (valueValidatorField.element.type.element! as InterfaceElement)
            .allSupertypes
            .firstWhere((it) => kValidatorChecker.isExactly(it.element))
            .typeArguments[1]
            .toTypeReference();

    final valueObjectTypeArgument =
        valueObjectInterfaceType.typeArguments.first;
    return resolve(
      valueObjectType.toTypeReference(),
      valueObjectTypeArgument.toTypeReference(
        isNullable:
            valueObjectType.nullabilitySuffix == NullabilitySuffix.question,
      ),
      valueFailureType,
      _getFieldFailureType(failureReference, parameter),
    );
  }

  ModelPropertyType _standardModelPropertyType(DartType type) {
    return ModelPropertyType.standard(type: type.toTypeReference());
  }

  TypeReference _getFieldFailureType(
    Reference parent,
    FormalParameterFragment parameter,
  ) {
    return TypeReference(
      (it) =>
          it..symbol = '${parent.symbol}${parameter.name!.capitalizeFirst()}',
    );
  }
}

extension on DartType {
  String? _nullWhenDartUrl(String? url) {
    if (url == null || url.startsWith('d')) {
      return null;
    } else {
      return url;
    }
  }

  TypeReference toTypeReference({bool? isNullable}) {
    return TypeReference(
      (it) =>
          it
            ..symbol = getDisplayString().withoutTrailingQuestionMark()
            ..isNullable =
                isNullable ?? nullabilitySuffix == NullabilitySuffix.question
            ..url = _nullWhenDartUrl(
              element?.firstFragment.libraryFragment?.source.uri.toString(),
            ),
    );
  }
}

extension on String {
  String capitalizeFirst() {
    return this[0].toUpperCase() + substring(1);
  }

  String appendFieldFailure() {
    return '${this}FieldFailure';
  }

  String withoutTrailingQuestionMark() {
    if (this[length - 1] == '?') {
      return substring(0, length - 1);
    } else {
      return this;
    }
  }
}

extension on List<ElementAnnotation> {
  bool containsValidatable() {
    return any(
      (it) =>
          it.computeConstantValue()?.type?.let(
            kValidatableChecker.isExactlyType,
          ) ==
          true,
    );
  }
}

extension on List<InterfaceType> {
  InterfaceType? findValueObject() {
    return firstWhereOrNull((it) => kValueObjectChecker.isExactly(it.element));
  }
}
