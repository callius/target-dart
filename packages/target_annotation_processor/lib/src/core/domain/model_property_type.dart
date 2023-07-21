import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';

sealed class ModelPropertyType extends Equatable {
  const ModelPropertyType();

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

  abstract final TypeReference type;

  bool isValueObject() {
    return switch (this) {
      final ValueObjectModelPropertyType _ => true,
      final StandardModelPropertyType it =>
        it.typeArguments.firstOrNull is ValueObjectModelPropertyType,
      final ModelTemplateModelPropertyType _ => false,
    };
  }
}

final class ValueObjectModelPropertyType extends ModelPropertyType {
  @override
  final TypeReference type;
  final TypeReference valueObjectType;

  const ValueObjectModelPropertyType({
    required this.type,
    required this.valueObjectType,
  });

  @override
  List<Object> get props => [type, valueObjectType];
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

final class ModelTemplateModelPropertyType extends ModelPropertyType {
  @override
  final TypeReference type;

  const ModelTemplateModelPropertyType({
    required this.type,
  });

  @override
  List<Object> get props => [type];
}
