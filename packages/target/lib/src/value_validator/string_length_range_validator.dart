import 'package:target/src/either.dart';
import 'package:target/src/generic_value_failure.dart';
import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator.dart';

class StringLengthRangeValidator<T extends ValueObject<String>>
    extends ValueValidator<String, GenericValueFailure<String>, T> {
  final T Function(String input) _ctor;
  final int minLength;
  final int maxLength;

  const StringLengthRangeValidator(
    this._ctor, {
    required this.minLength,
    required this.maxLength,
  });

  @override
  Either<GenericValueFailure<String>, T> of(String input) {
    if (input.length < minLength || input.length > maxLength) {
      return Left(GenericValueFailure(input));
    } else {
      return Right(_ctor(input));
    }
  }
}
