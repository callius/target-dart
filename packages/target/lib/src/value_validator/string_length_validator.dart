import 'package:dartz/dartz.dart';
import 'package:target/src/generic_value_failure.dart';
import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator.dart';

class StringLengthValidator<T extends ValueObject<String>>
    extends ValueValidator<String, GenericValueFailure<String>, T> {
  final T Function(String input) _ctor;
  final int length;

  const StringLengthValidator(this._ctor, {required this.length});

  @override
  Either<GenericValueFailure<String>, T> of(String input) {
    if (input.length == length) {
      return Right(_ctor(input));
    } else {
      return Left(GenericValueFailure(input));
    }
  }
}
