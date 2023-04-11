import 'package:code_builder/code_builder.dart';
import 'package:target_annotation_processor/src/core/domain/model_property.dart';
import 'package:target_annotation_processor/src/core/domain/model_property_type.dart';
import 'package:target_annotation_processor/src/core/functions.dart';
import 'package:target_annotation_processor/src/core/references.dart';

typedef ModelPropertyTypeToTypeReference = TypeReference Function(
  ModelPropertyType type,
);

Spec generateModelSpecBase({
  required Reference failureReference,
  required Reference modelReference,
  required List<ModelProperty> properties,
  required ModelPropertyTypeToTypeReference toTypeReference,
  required ModelPropertyTypeToTypeReference toValueObjectTypeReference,
}) {
  final className = modelReference.symbol;
  return Class(
    (cls) => cls
      ..annotations.add(kFreezedRef)
      ..name = className
      ..mixins.add(Reference('_\$$className'))
      ..constructors.add(
        Constructor(
          (ctor) => ctor
            ..constant = true
            ..factory = true
            ..optionalParameters.addAll(
              properties.map(
                (prop) => Parameter(
                  (it) => it
                    ..required = true
                    ..named = true
                    ..name = prop.name
                    ..type = toTypeReference(prop.type),
                ),
              ),
            )
            ..redirect = Reference('_$className'),
        ),
      )
      ..methods.add(
        Method(
          (method) => method
            ..static = true
            ..returns = eitherRef(failureReference, modelReference)
            ..name = 'of'
            ..optionalParameters.addAll(
              properties.map(
                (prop) => Parameter(
                  (it) => it
                    ..required = true
                    ..named = true
                    ..name = prop.name
                    ..type = toValueObjectTypeReference(prop.type),
                ),
              ),
            )
            ..body = ofAndZipConstructor(
              properties,
              failureReference,
              modelReference,
            ).returned.statement,
        ),
      ),
  );
}
