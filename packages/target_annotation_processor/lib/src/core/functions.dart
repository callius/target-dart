import 'package:code_builder/code_builder.dart';
import 'package:target_annotation_processor/src/core/domain/model_property.dart';
import 'package:target_annotation_processor/src/core/domain/model_property_type.dart';
import 'package:target_annotation_processor/src/core/references.dart';
import 'package:target_annotation_processor/src/core/type_reference_extensions.dart';
import 'package:target_extension/target_extension.dart';

Expression ofAndZipConstructor(
  List<ModelProperty> properties,
  Reference failure,
  Reference model,
) {
  if (properties.isEmpty) {
    return InvokeExpression.constOf(
      kRightRef,
      [constructorCall(model, const [])],
    );
  } else {
    return ofAndZip(
      properties.where((prop) => prop.type.isValueObject()).toList(),
      failure,
      constructorCall(model, properties),
    );
  }
}

Expression ofAndZip(
  List<ModelProperty> properties,
  Reference failure,
  Expression next,
) {
  if (properties.isEmpty) {
    return kRightRef.call([next]);
  } else if (properties.length == 1) {
    return ofAndMap(properties.first, next);
  } else {
    return ofAndFlatMapList(
      List.of(properties)..removeLast(),
      ofAndMap(properties.last, next),
    );
  }
}

Expression constructorCall(
  Reference model,
  List<ModelProperty> properties, {
  bool checkVName = true,
  bool isConst = false,
}) {
  if (isConst) {
    return InvokeExpression.constOf(model, []);
  } else {
    return model.call(
      [],
      {
        if (checkVName)
          for (final prop in properties)
            prop.name: Reference(
              prop.type.isValueObject() ? prop.vName : prop.name,
            )
        else
          for (final prop in properties) prop.name: Reference(prop.name),
      },
    );
  }
}

Expression ofAndMap(ModelProperty property, Expression next) {
  return of(property).callMap(singleParameterLambda(property.vName, next));
}

Expression ofAndFlatMapList(List<ModelProperty> properties, Expression next) {
  if (properties.isEmpty) {
    return next;
  } else {
    return ofAndFlatMapList(
      List.of(properties)..removeLast(),
      ofAndFlatMap(properties.last, next),
    );
  }
}

Expression ofAndFlatMap(ModelProperty property, Expression next) {
  return of(property).callFold(
    kLeftRef.property('new'),
    singleParameterLambda(property.vName, next),
  );
}

Expression of(ModelProperty property) {
  final isOption = property.type.type.symbol == kOptionRef.symbol;
  if (isOption) {
    final valueObjectType =
        (property.type as StandardModelPropertyType).typeArguments.first.type;

    if (valueObjectType.isNullable ?? false) {
      final nonNullableType =
          (valueObjectType.toBuilder()..isNullable = false).build();

      return nonNullableType
          .property('of')
          .property('nullableOption')
          .call([Reference(property.name)]);
    } else {
      return valueObjectType
          .property('of')
          .property('option')
          .call([Reference(property.name)]);
    }
  } else {
    final valueObjectType = property.type.type;

    if (valueObjectType.isNullable ?? false) {
      final nonNullableType =
          (valueObjectType.toBuilder()..isNullable = false).build();

      return nonNullableType
          .property('of')
          .property('nullable')
          .call([Reference(property.name)]);
    } else {
      return valueObjectType.property('of').call([Reference(property.name)]);
    }
  }
}

Expression zipOptionProperties(
  List<ModelProperty> properties,
  Expression next,
) {
  if (properties.isEmpty) {
    return InvokeExpression.constOf(kSomeRef, [next]);
  } else {
    final prop = properties.first;
    final receiver = getOptionPropertyReceiver(prop);
    if (properties.length == 1) {
      return receiver.callMap(singleParameterLambda(prop.vName, next));
    } else {
      return receiver.callFlatMap(
        singleParameterLambda(
          prop.vName,
          zipOptionProperties(
            List.of(properties)..removeAt(0),
            next,
          ),
        ),
      );
    }
  }
}

Expression getOptionPropertyReceiver(ModelProperty property) {
  return switch (
      (property.type as StandardModelPropertyType).typeArguments.first) {
    final ValueObjectModelPropertyType _ => Reference(property.name),
    final StandardModelPropertyType _ => Reference(property.name),
    final ModelTemplateModelPropertyType type =>
      Reference(property.name).callFlatMap(
        singleParameterLambda(
          property.vName,
          callBuild(Reference(property.vName), type.type.isNullable ?? false),
        ),
        type.type.appendParams(),
      ),
  };
}

Expression vNameConstructorCall(
  Reference model,
  List<ModelProperty> properties,
) {
  return model.call(
    [],
    {
      for (final prop in properties) prop.name: Reference(prop.vName),
    },
  );
}

// ignore: avoid_positional_boolean_parameters
Expression callBuild(Reference receiver, bool isReceiverNullable) {
  if (isReceiverNullable) {
    return CodeExpression(
      Block.of([
        const Code('if ('),
        receiver.equalTo(literalNull).code,
        const Code(') {'),
        kSomeRef.constInstance([literalNull]).returned.statement,
        const Code('} else {'),
        receiver.property('build').call([]).returned.statement,
        const Code('}'),
      ]),
    );
  } else {
    return receiver.property('build').call([]);
  }
}

extension on Expression {
  Expression callMap(Expression next) {
    return property('map').call([next]);
  }

  Expression callFlatMap(Expression next, [Reference? typeArgument]) {
    return property('flatMap').call(
      [next],
      const {},
      typeArgument?.let((it) => [it]) ?? const [],
    );
  }

  Expression callFold(Expression whenLeft, Expression whenRight) {
    return property('fold').call([whenLeft, whenRight]);
  }
}

Expression singleParameterLambda(String parameterName, Expression next) {
  return Method(
    (method) => method
      ..requiredParameters.add(
        Parameter(
          (param) => param..name = parameterName,
        ),
      )
      ..body = next.code,
  ).closure;
}
