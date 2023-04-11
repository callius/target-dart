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
import 'package:target_annotation_processor/src/core/domain/annotation/add_field_annotation.dart';
import 'package:target_annotation_processor/src/core/domain/annotation/model_template_annotation.dart';
import 'package:target_annotation_processor/src/core/domain/model_property.dart';
import 'package:target_annotation_processor/src/core/domain/model_property_type.dart';
import 'package:target_annotation_processor/src/core/generate_builder_spec.dart';
import 'package:target_annotation_processor/src/core/generate_model_spec.dart';
import 'package:target_annotation_processor/src/core/generate_params_spec.dart';
import 'package:target_annotation_processor/src/core/type_reference_extensions.dart';
import 'package:target_extension/target_extension.dart';

final _emitter = DartEmitter(
  orderDirectives: true,
  useNullSafetySyntax: true,
);

class ModelGenerator extends GeneratorForAnnotation<ModelTemplate> {
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
        'Generator cannot target `$elementName`, as it is not an abstract class.',
        todo: 'Remove the [ModelTemplate] annotation from `$elementName`.',
      );
    }

    // Checking for an abstract class.
    if (!element.isAbstract) {
      final friendlyName = element.displayName;
      throw InvalidGenerationSourceError(
        'Generator cannot target `$friendlyName`, as it is not an abstract class.',
        todo: 'Make `$friendlyName` abstract.',
      );
    }

    // Finding all getters.
    final properties = element.accessors.where((it) => it.isGetter).toList();

    // Checking for at least one getter.
    if (properties.isEmpty) {
      final friendlyName = element.displayName;
      throw InvalidGenerationSourceError(
        '`$friendlyName` must declare at least one getter.',
        todo: 'Add one or more getters to `$friendlyName`.',
      );
    }

    // Parsing model template annotation.
    final modelTemplate = ModelTemplateAnnotation.ofReader(annotation);

    // Creating model properties.
    final modelProperties = _generateModelProperties(
      properties,
      modelTemplate.customId ? null : modelTemplate.idField,
    );

    // Creating type references.
    final failureReference = modelTemplate.failure.toTypeReference();
    final modelReference = TypeReference(
      (it) => it..symbol = modelTemplate.name,
    );

    // Creating params and builder properties.
    final paramsProperties =
        modelProperties.where((it) => it.isNotExternal).toList();

    // Creating params class type reference.
    final paramsReference = modelReference.appendParams();

    // Creating builder class type reference.
    final builderReference = modelReference.appendBuilder();

    // Generating model.
    return Library(
      (it) => it
        ..comments.add('Generated code. Do not modify by hand.')
        ..ignoreForFile
            .addAll(const ['unused_element', 'require_trailing_commas'])
        ..body.addAll([
          generateModelSpec(
            failureReference: failureReference,
            modelReference: modelReference,
            properties: modelProperties,
          ),
          generateParamsSpec(
            failureReference: failureReference,
            modelReference: paramsReference,
            properties: paramsProperties,
          ),
          generateBuilderSpec(
            failureReference: failureReference,
            builderReference: builderReference,
            paramsReference: paramsReference,
            paramsProperties: paramsProperties,
          ),
        ]),
    ).accept(_emitter).toString();
  }

  List<ModelProperty> _generateModelProperties(
    List<PropertyAccessorElement> properties,
    AddFieldAnnotation? addFieldId,
  ) {
    return [
      if (addFieldId != null)
        ModelProperty(
          name: addFieldId.name,
          type: _resolveModelPropertyType(addFieldId.type),
          isExternal: addFieldId.ignore,
        ),
      ...properties.map(
        (it) => ModelProperty(
          name: it.name,
          type: _resolveModelPropertyType(it.variable.type),
          isExternal: it.metadata.any(
            (annotation) => kExternalTypeChecker.isExactlyType(
              annotation.computeConstantValue()!.type!,
            ),
          ),
        ),
      ),
    ];
  }

  ModelPropertyType _resolveModelPropertyType(DartType type) {
    final modelTemplate = type.element?.metadata.firstWhereOrNull(
      (it) =>
          it
              .computeConstantValue()
              ?.type
              ?.let(kModelTemplateChecker.isExactlyType) ??
          false,
    );

    if (modelTemplate == null) {
      final typeElement = type.element;
      if (typeElement is! ClassElement) {
        return _standardModelPropertyType(type, typeElement);
      } else {
        final valueObjectInterface = typeElement.allSupertypes.firstWhereOrNull(
          (it) => kValueObjectChecker.isExactly(it.element),
        );

        if (valueObjectInterface == null) {
          return _standardModelPropertyType(type, typeElement);
        } else {
          final typeArgument = valueObjectInterface.typeArguments.first;
          return ModelPropertyType.valueObject(
            type: type.toTypeReference(),
            valueObjectType: typeArgument.toTypeReference(
              isNullable: type.nullabilitySuffix == NullabilitySuffix.question,
            ),
          );
        }
      }
    } else {
      return ModelPropertyType.modelTemplate(
        type: TypeReference(
          (it) => it
            ..symbol = ModelTemplateAnnotation.ofObject(
              modelTemplate.computeConstantValue()!,
            ).name
            ..isNullable = type.nullabilitySuffix == NullabilitySuffix.question
            ..url = type.element!.declaration!.source!.uri.toString(),
        ),
      );
    }
  }

  ModelPropertyType _standardModelPropertyType(
    DartType type,
    Element? element,
  ) {
    if (element is! TypeParameterizedElement) {
      return ModelPropertyType.standard(
        type: type.toTypeReference(),
        typeArguments: [],
      );
    } else {
      return ModelPropertyType.standard(
        type: type.toTypeReference(),
        typeArguments: element.typeParameters
            .map((param) => _resolveModelPropertyType(param.bound!))
            .toList(),
      );
    }
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
        ..symbol = getDisplayString(withNullability: false)
        ..isNullable =
            isNullable ?? nullabilitySuffix == NullabilitySuffix.question
        ..url = _nullWhenDartUrl(element?.source?.uri.toString()),
    );
  }
}
