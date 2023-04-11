import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator/int_min_value_validator.dart';

class NonNegativeIntValidator<T extends ValueObject<int>>
    extends IntMinValueValidator<T> {
  const NonNegativeIntValidator(super.ctor) : super(min: 0);
}
