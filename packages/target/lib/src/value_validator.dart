import 'package:target/src/either.dart';
import 'package:target/src/option.dart';
import 'package:target/src/value_failure.dart';
import 'package:target/src/value_object.dart';

abstract class ValueValidator<
  I extends Object,
  F extends ValueFailure<I>,
  T extends ValueObject<I>
> {
  const ValueValidator();

  /// Validates an input.
  Either<F, T> of(I input);

  /// Validates a nullable input.
  Either<F, T?> nullable(I? input) {
    // NOTE: Not a ternary operator due to failed type inference.
    if (input == null) {
      return const Right(null);
    } else {
      return of(input);
    }
  }

  /// Validates an optional input.
  Either<F, Option<T>> option(Option<I> input) => input.fold(
    () => const Right<None>(None()),
    (it) => of(it).map<Some<T>>(Some.new),
  );

  /// Validates an optional nullable input.
  Either<F, Option<T?>> nullableOption(Option<I?> input) => input.fold(
    () => const Right<None>(None()),
    (it) => nullable(it).map<Some<T?>>(Some.new),
  );

  /// Makes value validators callable like functions, defaults to [of].
  Either<F, T> call(I input) => of(input);
}
