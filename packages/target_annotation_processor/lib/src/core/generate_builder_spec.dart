import 'package:code_builder/code_builder.dart';
import 'package:target_annotation_processor/src/core/domain/model_property.dart';
import 'package:target_annotation_processor/src/core/domain/model_property_type.dart';
import 'package:target_annotation_processor/src/core/functions.dart';
import 'package:target_annotation_processor/src/core/references.dart';
import 'package:target_annotation_processor/src/core/type_reference_extensions.dart';

Spec generateBuilderSpec({
  required Reference failureReference,
  required Reference builderReference,
  required Reference paramsReference,
  required List<ModelProperty> paramsProperties,
}) {
  final optionParams = paramsProperties
      .map(
        (it) => it.copyWith(
          type: ModelPropertyType.standard(
            type: kOptionRef,
            typeArguments: [it.type],
          ),
        ),
      )
      .toList();

  final className = builderReference.symbol;

  return Class(
    (cls) => cls
      ..annotations.add(kFreezedRef)
      ..name = className
      ..mixins.add(Reference('_\$$className'))
      ..implements.add(buildableRef(paramsReference))
      ..constructors.addAll([
        Constructor(
          (ctor) => ctor
            ..constant = true
            ..factory = true
            ..optionalParameters.addAll(
              optionParams.map(
                (param) => Parameter(
                  (it) => it
                    ..required = true
                    ..named = true
                    ..name = param.name
                    ..type = _toTypeReference(param.type),
                ),
              ),
            )
            ..redirect = Reference('_$className'),
        ),
        Constructor(
          (ctor) => ctor
            ..factory = true
            ..name = 'only'
            ..optionalParameters.addAll(
              optionParams.map(
                (param) => Parameter(
                  (it) => it
                    ..named = true
                    ..name = param.name
                    ..type = _toTypeReference(param.type)
                    ..defaultTo = kNoneRef.constInstance([]).code,
                ),
              ),
            )
            ..body = constructorCall(
              builderReference,
              paramsProperties,
              checkVName: false,
            ).returned.statement,
        ),
        Constructor(
          (ctor) => ctor
            ..constant = true
            ..name = '_',
        ),
      ])
      ..methods.addAll([
        Method(
          (method) => method
            ..static = true
            ..returns = eitherRef(failureReference, builderReference)
            ..name = 'of'
            ..optionalParameters.addAll(
              optionParams.map(
                (param) => Parameter(
                  (it) => it
                    ..required = true
                    ..named = true
                    ..name = param.name
                    ..type = _toValueObjectTypeReference(param.type),
                ),
              ),
            )
            ..body = ofAndZipConstructor(
              optionParams,
              failureReference,
              builderReference,
            ).returned.statement,
        ),
        Method(
          (method) => method
            ..annotations.add(kOverrideRef)
            ..returns = optionRef(paramsReference)
            ..name = 'build'
            ..body = zipOptionProperties(
              optionParams,
              vNameConstructorCall(paramsReference, optionParams),
            ).returned.statement,
        ),
      ]),
  );
}

TypeReference _toTypeReference(ModelPropertyType type) {
  return switch (type) {
    final ValueObjectModelPropertyType type => type.type,
    final ModelTemplateModelPropertyType type => type.type.appendBuilder(),
    final StandardModelPropertyType type => (type.type.toBuilder()
          ..types.addAll(type.typeArguments.map(_toTypeReference)))
        .build(),
  };
}

TypeReference _toValueObjectTypeReference(ModelPropertyType type) {
  return switch (type) {
    final ValueObjectModelPropertyType type => type.valueObjectType,
    final ModelTemplateModelPropertyType type => type.type.appendBuilder(),
    final StandardModelPropertyType type => (type.type.toBuilder()
          ..types.addAll(type.typeArguments.map(_toValueObjectTypeReference)))
        .build(),
  };
}
