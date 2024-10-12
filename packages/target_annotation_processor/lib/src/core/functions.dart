import 'package:code_builder/code_builder.dart';

Code ifElseStatement({
  required Code condition,
  required Code onTrue,
  required Code onFalse,
}) {
  return Block.of([
    const Code('if ('),
    condition,
    const Code(') {'),
    onTrue,
    const Code('} else {'),
    onFalse,
    const Code('}'),
  ]);
}

Expression noParameterLambda(Expression next) {
  return Method(
    (method) => method..body = next.code,
  ).closure;
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
