import 'package:target/src/either.dart';
import 'package:target/src/generic_value_object.dart';
import 'package:target/src/option.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'test_value_validator.dart';

void main() {
  const testResult = Right<_TestValueObject>(_TestValueObject());

  group('ValueValidator.nullable', () {
    test('returns Right(null) when input is null', () {
      const valueValidator = TestValueValidator<int, Never, _TestValueObject>(
        testResult,
      );

      final result = valueValidator.nullable(null);

      expect(result, const Right(null));
    });
  });
  group('ValueValidator.option', () {
    test('returns Right(None()) when the input is None()', () {
      const valueValidator = TestValueValidator<int, Never, _TestValueObject>(
        testResult,
      );

      final result = valueValidator.option(const None());

      expect(result, const Right(None()));
    });
  });
  group('ValueValidator.nullableOption', () {
    test('returns Right(None()) when the input is None()', () {
      const valueValidator = TestValueValidator<int, Never, _TestValueObject>(
        testResult,
      );

      final result = valueValidator.nullableOption(const None());

      expect(result, const Right(None()));
    });
    test('returns Right(Some(null)) when the input is Some(null)', () {
      const valueValidator = TestValueValidator<int, Never, _TestValueObject>(
        testResult,
      );

      final result = valueValidator.nullableOption(const Some(null));

      expect(result, const Right(Some(null)));
    });
  });
}

class _TestValueObject extends GenericValueObject<int> {
  const _TestValueObject() : super(0);
}
