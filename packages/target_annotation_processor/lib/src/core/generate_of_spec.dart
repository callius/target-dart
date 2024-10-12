import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:target/target.dart';
import 'package:target_annotation_processor/src/core/domain/model_property.dart';
import 'package:target_annotation_processor/src/core/domain/model_property_type.dart';
import 'package:target_annotation_processor/src/core/functions.dart';
import 'package:target_annotation_processor/src/core/references.dart';
import 'package:target_extension/target_extension.dart';

Spec generateOfSpec({
  required Reference modelReference,
  required Reference fieldFailureReference,
  required List<ModelProperty> modelProperties,
}) {
  return Method(
    (fun) => fun
      ..returns = eitherRef(
        nelRef(fieldFailureReference),
        modelReference,
      )
      ..name = r'_$of'
      ..optionalParameters.addAll(
        modelProperties.map(
          (prop) => Parameter(
            (param) => param
              ..required = true
              ..named = true
              ..name = prop.name
              ..type = _toValueObjectTypeReference(prop.type),
          ),
        ),
      )
      ..body = _validateModelProperties(
        modelReference: modelReference,
        modelProperties: modelProperties,
      ),
  );
}

Code _validateModelProperties({
  required Reference modelReference,
  required List<ModelProperty> modelProperties,
}) {
  final List<(ModelProperty, ValidatableModelPropertyType, String)>
      validatedProperties = [];
  final List<Code> statements = buildList((list) {
    // Validating model properties.
    for (final property in modelProperties) {
      final propertyType = property.type;
      switch (propertyType) {
        case ValueObjectModelPropertyType():
          // Validating value object property.
          if (propertyType.type.isNullable == true) {
            list.add(
              declareFinal(property.vName)
                  .assign(
                    propertyType.type
                        .property('of')
                        .property('nullable')
                        .call([Reference(property.name)]),
                  )
                  .statement,
            );
          } else {
            list.add(
              declareFinal(property.vName)
                  .assign(
                    propertyType.type
                        .property('of')
                        .call([Reference(property.name)]),
                  )
                  .statement,
            );
          }
          validatedProperties.add((property, propertyType, property.vName));
        case ValueObjectOptionModelPropertyType():
          // Validating value object property.
          if (propertyType.valueObjectType.isNullable == true) {
            list.add(
              declareFinal(property.vName)
                  .assign(
                    propertyType.type
                        .property('of')
                        .property('nullableOption')
                        .call([Reference(property.name)]),
                  )
                  .statement,
            );
          } else {
            list.add(
              declareFinal(property.vName)
                  .assign(
                    propertyType.type
                        .property('of')
                        .property('option')
                        .call([Reference(property.name)]),
                  )
                  .statement,
            );
          }
          validatedProperties.add((property, propertyType, property.vName));
        case StandardModelPropertyType():
          break;
        case ModelTemplateModelPropertyType():
          // Validating nullable model property.
          if (propertyType.type.isNullable == true) {
            list.add(
              declareFinal(property.vName)
                  .assign(
                    Reference(property.name).ifNullThen(
                      const InvokeExpression.constOf(
                        kRightRef,
                        [literalNull],
                      ),
                    ),
                  )
                  .statement,
            );
            validatedProperties.add((property, propertyType, property.vName));
          } else {
            validatedProperties.add((property, propertyType, property.name));
          }
        case ModelTemplateOptionModelPropertyType():
          // Validating optional model property.
          if (propertyType.modelType.isNullable == true) {
            list.add(
              declareFinal(property.vName)
                  .assign(
                    Reference(property.name).property('fold').call([
                      noParameterLambda(
                        InvokeExpression.constOf(
                          kRightRef,
                          [kNoneRef.call([])],
                        ),
                      ),
                      singleParameterLambda(
                        '_r',
                        const Reference('_r')
                            .nullSafeProperty('map')
                            .call([kSomeRef.property('new')]).ifNullThen(
                          InvokeExpression.constOf(
                            kRightRef,
                            [
                              kSomeRef.call([literalNull]),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  )
                  .statement,
            );
          } else {
            list.add(
              declareFinal(property.vName)
                  .assign(
                    Reference(property.name).property('fold').call([
                      noParameterLambda(
                        InvokeExpression.constOf(
                          kRightRef,
                          [kNoneRef.call([])],
                        ),
                      ),
                      singleParameterLambda(
                        '_r',
                        const Reference('_r')
                            .property('map')
                            .call([kSomeRef.property('new')]),
                      ),
                    ]),
                  )
                  .statement,
            );
          }
          validatedProperties.add((property, propertyType, property.vName));
      }
    }

    // Checking results.
    final vValidatedProperties = validatedProperties.toNonEmptyListOrNull();
    if (vValidatedProperties == null) {
      list.add(
        kRightRef
            .call([
              modelReference.call([], {
                for (final property in modelProperties)
                  property.name: Reference(property.name),
              }),
            ])
            .returned
            .statement,
      );
    } else {
      list.add(
        ifElseStatement(
          condition: vValidatedProperties
              .foldWithHead<Expression>(
                (it) => Reference(it.$3)
                    .isA(rightRef(it.$2.getLeftType(), it.$2.getRightType())),
                (acc, it) => acc.and(
                  Reference(it.$3)
                      .isA(rightRef(it.$2.getLeftType(), it.$2.getRightType())),
                ),
              )
              .code,
          onTrue: kRightRef
              .call([
                modelReference.call([], {
                  for (final property in modelProperties)
                    property.name: vValidatedProperties
                            .firstWhereOrNull((it) => it.$1 == property)
                            ?.let((it) => Reference(it.$3).property('value')) ??
                        Reference(property.name),
                }),
              ])
              .returned
              .statement,
          onFalse: kLeftRef
              .call([
                kNelRef.property('fromListUnsafe').call([
                  CodeExpression(
                    Block.of([
                      const Code('['),
                      for (final (_, propertyType, vName)
                          in vValidatedProperties)
                        Block.of([
                          const Code('if ('),
                          Reference(vName)
                              .isA(
                                leftRef(
                                  propertyType.getLeftType(),
                                  propertyType.getRightType(),
                                ),
                              )
                              .code,
                          const Code(')'),
                          propertyType.getFieldFailureType().call([
                            Reference(vName).property('value'),
                          ]).code,
                          const Code(','),
                        ]),
                      const Code(']'),
                    ]),
                  ),
                ]),
              ])
              .returned
              .statement,
        ),
      );
    }
  });
  return Block.of(statements);
}

TypeReference _toValueObjectTypeReference(ModelPropertyType type) {
  return switch (type) {
    ValueObjectModelPropertyType() => type.valueObjectValueType,
    ValueObjectOptionModelPropertyType() =>
      optionRef(type.valueObjectValueType),
    ModelTemplateModelPropertyType() => eitherRef(
        nelRef(type.parentFieldFailureType),
        type.type.toNonNull(),
      ).withNullability(type.type.isNullable),
    ModelTemplateOptionModelPropertyType() => optionRef(
        eitherRef(
          nelRef(type.parentFieldFailureType),
          type.modelType.toNonNull(),
        ).withNullability(type.modelType.isNullable),
      ),
    StandardModelPropertyType() => (type.type.toBuilder()
          ..types.addAll(type.typeArguments.map(_toValueObjectTypeReference)))
        .build(),
  };
}

extension on TypeReference {
  TypeReference withNullability(bool? isNullable) {
    return (toBuilder()..isNullable = isNullable).build();
  }

  TypeReference toNonNull() {
    return (toBuilder()..isNullable = false).build();
  }
}
