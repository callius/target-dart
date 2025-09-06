import 'package:target/src/either.dart';
import 'package:target/src/generic_value_failure.dart';
import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator.dart';

class StringInValueObjectsValidator<T extends ValueObject<String>>
    extends ValueValidator<String, GenericValueFailure<String>, T> {
  final List<T> _all;

  const StringInValueObjectsValidator(this._all);

  @override
  Either<GenericValueFailure<String>, T> of(String input) {
    for (final valueObject in _all) {
      if (valueObject.value == input) {
        return Right(valueObject);
      }
    }
    return Left(GenericValueFailure(input));
  }
}
