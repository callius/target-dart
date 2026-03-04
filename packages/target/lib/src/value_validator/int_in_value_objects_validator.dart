import 'package:target/src/either.dart';
import 'package:target/src/generic_value_failure.dart';
import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator.dart';

class IntInValueObjectsValidator<T extends ValueObject<int>>
    extends ValueValidator<int, GenericValueFailure<int>, T> {
  final List<T> _all;

  const IntInValueObjectsValidator(this._all);

  @override
  Either<GenericValueFailure<int>, T> of(int input) {
    for (final valueObject in _all) {
      if (valueObject.value == input) {
        return Right(valueObject);
      }
    }
    return Left(GenericValueFailure(input));
  }
}
