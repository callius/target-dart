import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator/int_min_value_validator.dart';

/// Validates a non-negative int.
///
/// Example usage:
/// ```dart
/// final class NonNegativeInt extends GenericValueObject<int> {
///   static const of = NonNegativeIntValidator(NonNegativeInt._);
///
///   const NonNegativeInt._(super.value);
/// }
/// ```
class NonNegativeIntValidator<T extends ValueObject<int>>
    extends IntMinValueValidator<T> {
  const NonNegativeIntValidator(super.ctor) : super(min: 0);
}
