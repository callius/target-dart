import 'package:code_builder/code_builder.dart';
import 'package:target_annotation_processor/src/core/domain/model_property.dart';
import 'package:target_annotation_processor/src/core/domain/model_property_type.dart';
import 'package:target_annotation_processor/src/core/generate_model_spec_base.dart';
import 'package:target_annotation_processor/src/core/type_reference_extensions.dart';

Spec generateParamsSpec({
  required TypeReference failureReference,
  required TypeReference modelReference,
  required List<ModelProperty> properties,
}) {
  return generateModelSpecBase(
    failureReference: failureReference,
    modelReference: modelReference,
    properties: properties,
    toTypeReference: _toTypeReference,
    toValueObjectTypeReference: _toValueObjectTypeReference,
  );
}

TypeReference _toTypeReference(ModelPropertyType type) {
  return type.map(
    valueObject: (it) => it.type,
    modelTemplate: (it) => it.type.appendParams(),
    standard: (it) => (it.type.toBuilder()
          ..types.addAll(it.typeArguments.map(_toTypeReference)))
        .build(),
  );
}

TypeReference _toValueObjectTypeReference(ModelPropertyType type) {
  return type.map(
    valueObject: (it) => it.valueObjectType,
    modelTemplate: (it) => it.type.appendParams(),
    standard: (it) => (it.type.toBuilder()
          ..types.addAll(it.typeArguments.map(_toValueObjectTypeReference)))
        .build(),
  );
}
