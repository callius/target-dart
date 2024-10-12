import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:target_annotation_processor/src/core/references.dart';

sealed class ModelPropertyType extends Equatable {
  const ModelPropertyType();

  const factory ModelPropertyType.valueObject({
    required TypeReference type,
    required TypeReference valueObjectValueType,
    required TypeReference valueFailureType,
    required TypeReference fieldFailureType,
  }) = ValueObjectModelPropertyType;

  const factory ModelPropertyType.valueObjectOption({
    required TypeReference type,
    required TypeReference valueObjectType,
    required TypeReference valueObjectValueType,
    required TypeReference valueFailureType,
    required TypeReference fieldFailureType,
  }) = ValueObjectOptionModelPropertyType;

  const factory ModelPropertyType.standard({
    required TypeReference type,
    required List<ModelPropertyType> typeArguments,
  }) = StandardModelPropertyType;

  const factory ModelPropertyType.modelTemplate({
    required TypeReference type,
    required TypeReference parentFieldFailureType,
    required TypeReference fieldFailureType,
  }) = ModelTemplateModelPropertyType;

  const factory ModelPropertyType.modelTemplateOption({
    required TypeReference type,
    required TypeReference modelType,
    required TypeReference parentFieldFailureType,
    required TypeReference fieldFailureType,
  }) = ModelTemplateOptionModelPropertyType;

  abstract final TypeReference type;
}

sealed class ValidatableModelPropertyType {
  TypeReference getLeftType();

  TypeReference getRightType();

  TypeReference getFieldFailureType();
}

final class ValueObjectModelPropertyType extends ModelPropertyType
    implements ValidatableModelPropertyType {
  @override
  final TypeReference type;
  final TypeReference valueObjectValueType;
  final TypeReference valueFailureType;
  final TypeReference fieldFailureType;

  const ValueObjectModelPropertyType({
    required this.type,
    required this.valueObjectValueType,
    required this.valueFailureType,
    required this.fieldFailureType,
  });

  @override
  List<Object> get props => [
        type,
        valueObjectValueType,
        valueFailureType,
        fieldFailureType,
      ];

  @override
  TypeReference getFieldFailureType() => fieldFailureType;

  @override
  TypeReference getLeftType() => valueFailureType;

  @override
  TypeReference getRightType() => type;
}

final class ValueObjectOptionModelPropertyType extends ModelPropertyType
    implements ValidatableModelPropertyType {
  @override
  final TypeReference type;
  final TypeReference valueObjectType;
  final TypeReference valueObjectValueType;
  final TypeReference valueFailureType;
  final TypeReference fieldFailureType;

  const ValueObjectOptionModelPropertyType({
    required this.type,
    required this.valueObjectType,
    required this.valueObjectValueType,
    required this.valueFailureType,
    required this.fieldFailureType,
  });

  @override
  List<Object> get props => [
        type,
        valueObjectType,
        valueObjectValueType,
        valueFailureType,
        fieldFailureType,
      ];

  @override
  TypeReference getFieldFailureType() => fieldFailureType;

  @override
  TypeReference getLeftType() => valueFailureType;

  @override
  TypeReference getRightType() => optionRef(valueObjectType);
}

final class StandardModelPropertyType extends ModelPropertyType {
  @override
  final TypeReference type;
  final List<ModelPropertyType> typeArguments;

  const StandardModelPropertyType({
    required this.type,
    required this.typeArguments,
  });

  @override
  List<Object> get props => [type, typeArguments];
}

final class ModelTemplateModelPropertyType extends ModelPropertyType
    implements ValidatableModelPropertyType {
  @override
  final TypeReference type;
  final TypeReference parentFieldFailureType;
  final TypeReference fieldFailureType;

  const ModelTemplateModelPropertyType({
    required this.type,
    required this.parentFieldFailureType,
    required this.fieldFailureType,
  });

  @override
  List<Object> get props => [type, parentFieldFailureType, fieldFailureType];

  @override
  TypeReference getFieldFailureType() => fieldFailureType;

  @override
  TypeReference getLeftType() => nelRef(parentFieldFailureType);

  @override
  TypeReference getRightType() => type;
}

final class ModelTemplateOptionModelPropertyType extends ModelPropertyType
    implements ValidatableModelPropertyType {
  @override
  final TypeReference type;
  final TypeReference modelType;
  final TypeReference parentFieldFailureType;
  final TypeReference fieldFailureType;

  const ModelTemplateOptionModelPropertyType({
    required this.type,
    required this.modelType,
    required this.parentFieldFailureType,
    required this.fieldFailureType,
  });

  @override
  List<Object> get props => [
        type,
        modelType,
        parentFieldFailureType,
        fieldFailureType,
      ];

  @override
  TypeReference getFieldFailureType() => fieldFailureType;

  @override
  TypeReference getLeftType() => nelRef(parentFieldFailureType);

  @override
  TypeReference getRightType() => optionRef(modelType);
}
