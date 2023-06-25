import 'package:target/src/generic_value_object.dart';
import 'package:target/src/value_object/positive_int.dart';
import 'package:target/src/value_validator/non_negative_int_validator.dart';

final class NonNegativeInt extends GenericValueObject<int> {
  static const of = NonNegativeIntValidator(NonNegativeInt._);

  const NonNegativeInt._(super.value);
}

extension PositiveIntToNonNegativeIntX on PositiveInt {
  NonNegativeInt toNonNegativeInt() => NonNegativeInt._(value);
}
