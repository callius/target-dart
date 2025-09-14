import 'package:code_builder/code_builder.dart';
import 'package:target/target.dart';
import 'package:target_annotation_processor/src/core/domain/model_property.dart';
import 'package:target_annotation_processor/src/core/domain/model_property_type.dart';
import 'package:target_annotation_processor/src/core/references.dart';

List<Spec> generateFieldFailureSpecs({
  required TypeReference fieldFailureReference,
  required List<ModelProperty> modelProperties,
}) {
  return buildList((list) {
    list.add(
      Class(
        (cls) => cls
          ..sealed = true
          ..name = fieldFailureReference.symbol
          ..types.add(const Reference('T'))
          ..extend = kEquatableRef
          ..constructors.add(
            Constructor(
              (ctor) => ctor
                ..constant = true
                ..requiredParameters.add(
                  Parameter(
                    (param) => param
                      ..toThis = true
                      ..name = 'parent',
                  ),
                ),
            ),
          )
          ..fields.add(
            Field(
              (field) => field
                ..modifier = FieldModifier.final$
                ..type = const Reference('T')
                ..name = 'parent',
            ),
          )
          ..methods.add(
            Method(
              (method) => method
                ..annotations.add(kOverrideRef)
                ..returns = listRef(
                  (kObjectRef.toBuilder()..isNullable = true).build(),
                )
                ..type = MethodType.getter
                ..name = 'props'
                ..lambda = true
                ..body = Block.of([
                  const Code('['),
                  const Reference('parent').code,
                  const Code(']'),
                ]),
            ),
          ),
      ),
    );

    for (final property in modelProperties) {
      if (property.type is ValidatableModelPropertyType) {
        final propertyType = property.type as ValidatableModelPropertyType;
        list.add(
          Class(
            (cls) => cls
              ..modifier = ClassModifier.final$
              ..name = propertyType.getFieldFailureType().symbol
              ..extend = fieldFailureReference
                  .rebuild((it) => it.types.add(propertyType.getLeftType()))
              ..constructors.add(
                Constructor(
                  (ctor) => ctor
                    ..constant = true
                    ..requiredParameters.add(
                      Parameter(
                        (param) => param
                          ..toSuper = true
                          ..name = 'parent',
                      ),
                    ),
                ),
              ),
          ),
        );
      }
    }
  });
}
