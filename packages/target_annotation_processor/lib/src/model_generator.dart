import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:target_annotation/target_annotation.dart';
import 'package:target_annotation_processor/src/core/checker.dart';
import 'package:target_annotation_processor/src/core/domain/model_property.dart';
import 'package:target_annotation_processor/src/core/domain/model_property_type.dart';
import 'package:target_annotation_processor/src/core/generate_field_failure_specs.dart';
import 'package:target_annotation_processor/src/core/generate_of_spec.dart';
import 'package:target_extension/target_extension.dart';

final _emitter = DartEmitter(
  orderDirectives: true,
  useNullSafetySyntax: true,
);

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

    // Checking for an unnamed constructor.
    final ctor = element.constructors.firstWhereOrNull((it) => it.name.isEmpty);
    if (ctor == null) {
      final friendlyName = element.displayName;
      throw InvalidGenerationSourceError(
        'Generator cannot target `$friendlyName`, as it does not define an '
        'unnamed constructor.',
        todo: 'Define an unnamed constructor for `$friendlyName`.',
      );
    }

    // Finding all constructor parameters.
    final parameters = ctor.parameters;

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
      (it) => it..symbol = '${element.name}FieldFailure',
    );
    final modelReference = Reference(element.name);

    // Creating model properties.
    final modelProperties = _generateModelProperties(
      failureReference: failureReference,
      parameters: parameters,
    );

    // Generating model.
    return Library(
      (it) => it
        ..comments.add('Generated code. Do not modify by hand.')
        ..ignoreForFile
            .addAll(const ['require_trailing_commas', 'unused_element'])
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
    required Iterable<ParameterElement> parameters,
  }) {
    return parameters
        .map(
          (it) => ModelProperty(
            name: it.name,
            type: _resolveModelPropertyType(failureReference, it),
          ),
        )
        .toList();
  }

  ModelPropertyType _resolveModelPropertyType(
    Reference failureReference,
    ParameterElement parameter,
  ) {
    final type = parameter.type;
    final modelTemplate = type.element?.metadata.firstWhereOrNull(
      (it) =>
          it
              .computeConstantValue()
              ?.type
              ?.let(kValidatableChecker.isExactlyType) ==
          true,
    );
    if (modelTemplate != null) {
      final typeReference = type.toTypeReference();
      return ModelPropertyType.modelTemplate(
        type: typeReference,
        parentFieldFailureType: TypeReference(
          (it) => it
            ..symbol = type.element!.name!.appendFieldFailure()
            ..url = typeReference.url,
        ),
        fieldFailureType: _getFieldFailureType(failureReference, parameter),
      );
    }

    final typeElement = type.element;
    if (typeElement is! InterfaceElement) {
      return _standardModelPropertyType(type);
    }

    // Finding the value object interface.
    final valueObjectInterface = typeElement.allSupertypes.firstWhereOrNull(
      (it) => kValueObjectChecker.isExactly(it.element),
    );
    if (valueObjectInterface == null) {
      return _standardModelPropertyType(type);
    }

    // Finding the value validator field.
    final valueValidatorField = typeElement.children.firstWhereOrNull(
      (it) => it.name == 'of' && it is FieldElement && it.isStatic,
    ) as FieldElement?;
    if (valueValidatorField == null) {
      final displayName = typeElement.displayName;
      throw InvalidGenerationSourceError(
        '`$displayName` must declare a value validator in a static field `of`.',
        todo: 'Add a static value validator, named `of`, to `$displayName`.',
      );
    }

    // Finding the value failure type.
    final valueFailureType =
        (valueValidatorField.type.element! as InterfaceElement)
            .allSupertypes
            .firstWhere((it) => kValidatorChecker.isExactly(it.element))
            .typeArguments[1]
            .toTypeReference();

    final valueObjectTypeArgument = valueObjectInterface.typeArguments.first;
    return ModelPropertyType.valueObject(
      type: type.toTypeReference(),
      valueObjectValueType: valueObjectTypeArgument.toTypeReference(
        isNullable: type.nullabilitySuffix == NullabilitySuffix.question,
      ),
      valueFailureType: valueFailureType,
      fieldFailureType: _getFieldFailureType(failureReference, parameter),
    );
  }

  ModelPropertyType _standardModelPropertyType(DartType type) {
    final element = type.element;
    if (element is! TypeParameterizedElement) {
      return ModelPropertyType.standard(
        type: type.toTypeReference(),
        typeArguments: const [],
      );
    } else {
      return ModelPropertyType.standard(
        type: type.toTypeReference(),
        typeArguments: element.typeParameters
            .map((param) => _standardModelPropertyType(param.bound!))
            .toList(),
      );
    }
  }

  TypeReference _getFieldFailureType(
    Reference parent,
    ParameterElement parameter,
  ) {
    return TypeReference(
      (it) =>
          it..symbol = '${parent.symbol}${parameter.name.capitalizeFirst()}',
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
      (it) => it
        ..symbol = getDisplayString().withoutTrailingQuestionMark()
        ..isNullable =
            isNullable ?? nullabilitySuffix == NullabilitySuffix.question
        ..url = _nullWhenDartUrl(element?.source?.uri.toString()),
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
