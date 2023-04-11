import 'package:target/src/generic_value_object.dart';
import 'package:target/src/value_object/non_negative_int.dart';
import 'package:target/src/value_validator/positive_int_validator.dart';

class PositiveInt extends GenericValueObject<int> {
  static const of = PositiveIntValidator(PositiveInt._);

  static const one = PositiveInt._(1);

  const PositiveInt._(super.value);

  /// Returns a new instance containing the value of [other] added to the
  /// [value] of this.
  PositiveInt operator +(PositiveInt other) {
    return PositiveInt._(value + other.value);
  }

  /// Returns a new instance containing the value of [other] added to the
  /// [value] of this.
  PositiveInt plusNonNegativeInt(NonNegativeInt other) {
    return PositiveInt._(value + other.value);
  }
}
