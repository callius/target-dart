import 'package:target/src/either.dart';
import 'package:target/src/generic_value_failure.dart';
import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator.dart';

class IntRangeValidator<T extends ValueObject<int>>
    extends ValueValidator<int, GenericValueFailure<int>, T> {
  final T Function(int input) _ctor;
  final int min;
  final int max;

  const IntRangeValidator(this._ctor, {required this.min, required this.max});

  @override
  Either<GenericValueFailure<int>, T> of(int input) {
    if (input < min || input > max) {
      return Left(GenericValueFailure(input));
    } else {
      return Right(_ctor(input));
    }
  }
}
