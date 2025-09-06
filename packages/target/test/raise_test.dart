import 'package:target/target.dart';
import 'package:test/test.dart';

void main() {
  group('Raise.bind', () {
    test('returns left when left', () {
      const testLeft = Left('failure');

      final result = either<String, Unit>((r) {
        r.bind(testLeft);
      });

      expect(result, testLeft);
    });

    test('returns right when right', () {
      const testRight = Right<Unit>(unit);

      final result = either<String, Unit>((r) {
        return r.bind(testRight);
      });

      expect(result, testRight);
    });
  });

  group('Raise.raise', () {
    test('returns left', () {
      const testFailure = 'failure';

      final result = either<String, void>((r) {
        if (testFailure.startsWith('f')) {
          r.raise(testFailure);
        }
      });

      expect(result, const Left<String>(testFailure));
    });
  });

  group('Raise.ensure', () {
    test('returns left when false', () {
      const testFailure = 'failure';

      final result = either<String, void>((r) {
        r.ensure(false, () => testFailure);
      });

      expect(result, const Left<String>(testFailure));
    });

    test('returns right when true', () {
      const testFailure = 'failure';

      final result = either<String, Unit>((r) {
        r.ensure(true, () => testFailure);
        return unit;
      });

      expect(result, const Right<Unit>(unit));
    });
  });

  group('NullableRaise.bind', () {
    test('returns null when Left', () {
      const testEither = Left('failure');

      final result = nullable((r) {
        return r.bind(testEither);
      });

      expect(result, isNull);
    });

    test('returns the value when Some', () {
      const testEither = Right(unit);

      final result = nullable((r) {
        return r.bind(testEither);
      });

      expect(result, unit);
    });
  });

  group('NullableRaise.bindOption', () {
    test('returns null when None', () {
      const testOption = None();

      final result = nullable((r) {
        return r.bindOption(testOption);
      });

      expect(result, isNull);
    });

    test('returns the value when Some', () {
      const testOption = Some(unit);

      final result = nullable((r) {
        return r.bindOption(testOption);
      });

      expect(result, unit);
    });
  });

  group('NullableRaise.ensure', () {
    test('returns null when false', () {
      final result = nullable((r) {
        r.ensure(false);
        return unit;
      });

      expect(result, isNull);
    });

    test('returns passes when true', () {
      final result = nullable((r) {
        r.ensure(true);
        return unit;
      });

      expect(result, unit);
    });
  });
}
