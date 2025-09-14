import 'package:target/src/either.dart';
import 'package:target/src/generic_value_failure.dart';
import 'package:target/src/generic_value_object.dart';
import 'package:target/src/option.dart';
import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('ValueValidator.nullable()', () {
    test('returns Right(null) when input is null', () {
      final result = _TestValueObject.of.nullable(null);

      expect(result, const Right(null));
    });
  });
  group('ValueValidator.option()', () {
    test('returns Right(None()) when the input is None()', () {
      final result = _TestValueObject.of.option(const None());

      expect(result, const Right(None()));
    });
  });
  group('ValueValidator.nullableOption()', () {
    test('returns Right(None()) when the input is None()', () {
      final result = _TestValueObject.of.nullableOption(const None());

      expect(result, const Right(None()));
    });
    test('returns Right(Some(null)) when the input is Some(null)', () {
      final result = _TestValueObject.of.nullableOption(const Some(null));

      expect(result, const Right(Some<_TestValueObject?>(null)));
    });
  });
}

class _TestValueObject extends GenericValueObject<int> {
  static const of = _TestValueValidator(_TestValueObject._);

  const _TestValueObject._(super.value);
}

class _TestValueValidator<T extends ValueObject<int>>
    extends ValueValidator<int, GenericValueFailure<int>, T> {
  const _TestValueValidator(this._ctor);

  final T Function(int) _ctor;

  @override
  Either<GenericValueFailure<int>, T> of(int input) {
    if (input == 0) {
      return Right(_ctor(0));
    } else {
      return Left(GenericValueFailure(input));
    }
  }
}
