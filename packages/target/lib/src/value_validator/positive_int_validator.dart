import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator/int_min_value_validator.dart';

/// Validates a positive int.
///
/// Example usage:
/// ```dart
/// final class PositiveInt extends GenericValueObject<int> {
///   static const of = PositiveIntValidator(PositiveInt._);
///
///   static const one = PositiveInt._(1);
///
///   const PositiveInt._(super.value);
/// }
/// ```
class PositiveIntValidator<T extends ValueObject<int>>
    extends IntMinValueValidator<T> {
  const PositiveIntValidator(super.ctor) : super(min: 1);
}
