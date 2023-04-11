import 'package:dartz/dartz.dart';
import 'package:target/target.dart';

/// Test value validator returning the given [result].
class TestValueValidator<I extends Object, F extends ValueFailure<I>,
    T extends ValueObject<I>> extends ValueValidator<I, F, T> {
  final Either<F, T> result;

  const TestValueValidator(this.result);

  @override
  Either<F, T> of(I input) => result;
}
