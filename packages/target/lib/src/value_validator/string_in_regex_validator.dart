import 'package:target/src/either.dart';
import 'package:target/src/generic_value_failure.dart';
import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator.dart';

class StringRegexValidator<T extends ValueObject<String>>
    extends ValueValidator<String, GenericValueFailure<String>, T> {
  final T Function(String input) _ctor;
  final RegExp regExp;

  const StringRegexValidator(this._ctor, {required this.regExp});

  @override
  Either<GenericValueFailure<String>, T> of(String input) {
    if (regExp.hasMatch(input)) {
      return Right(_ctor(input));
    } else {
      return Left(GenericValueFailure(input));
    }
  }
}
