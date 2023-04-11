import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator/int_min_value_validator.dart';

class PositiveIntValidator<T extends ValueObject<int>>
    extends IntMinValueValidator<T> {
  const PositiveIntValidator(super.ctor) : super(min: 1);
}
