import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_property_type.freezed.dart';

@freezed
class ModelPropertyType with _$ModelPropertyType {
  const factory ModelPropertyType.valueObject({
    required TypeReference type,
    required TypeReference valueObjectType,
  }) = ValueObjectModelPropertyType;

  const factory ModelPropertyType.standard({
    required TypeReference type,
    required List<ModelPropertyType> typeArguments,
  }) = StandardModelPropertyType;

  const factory ModelPropertyType.modelTemplate({
    required TypeReference type,
  }) = ModelTemplateModelPropertyType;

  const ModelPropertyType._();

  bool isValueObject() {
    return map(
      valueObject: (_) => true,
      standard: (it) =>
          it.typeArguments.firstOrNull is ValueObjectModelPropertyType,
      modelTemplate: (_) => false,
    );
  }
}
