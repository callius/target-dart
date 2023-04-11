import 'package:dartz/dartz.dart';
import 'package:target/src/generic_value_failure.dart';
import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator.dart';

class IntMinValueValidator<T extends ValueObject<int>>
    extends ValueValidator<int, GenericValueFailure<int>, T> {
  final T Function(int input) _ctor;
  final int min;

  const IntMinValueValidator(this._ctor, {required this.min});

  @override
  Either<GenericValueFailure<int>, T> of(int input) {
    if (input < min) {
      return Left(GenericValueFailure(input));
    } else {
      return Right(_ctor(input));
    }
  }
}
