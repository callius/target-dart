import 'package:dartz/dartz.dart';
import 'package:target/src/raise.dart';
import 'package:test/test.dart';

void main() {
  group('Raise.bind', () {
    test('returns left when left', () {
      const testLeft = Left('failure');

      final result = either<String, Unit>((r) {
        r.bind(testLeft);
        return unit;
      });

      expect(result, testLeft);
    });

    test('returns right when right', () {
      const testRight = Right<String, Unit>(unit);

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

      expect(result, const Left<String, void>(testFailure));
    });
  });

  group('Raise.ensure', () {
    test('returns left when false', () {
      const testFailure = 'failure';

      final result = either<String, void>((r) {
        r.ensure(false, () => testFailure);
      });

      expect(result, const Left<String, void>(testFailure));
    });

    test('returns right when true', () {
      const testFailure = 'failure';

      final result = either<String, Unit>((r) {
        r.ensure(true, () => testFailure);
        return unit;
      });

      expect(result, const Right<String, Unit>(unit));
    });
  });

  group('Raise.ensureNotNull', () {
    test('returns left when null', () {
      const testFailure = 'failure';

      final result = either<String, Unit>((r) {
        const Unit? maybeUnit = null;
        return r.ensureNotNull(maybeUnit, () => testFailure);
      });

      expect(result, const Left<String, Unit>(testFailure));
    });

    test('returns value when not null', () {
      const testFailure = 'failure';

      final result = either<String, Unit>((r) {
        // ignore: unnecessary_nullable_for_final_variable_declarations
        const Unit? maybeUnit = unit;
        return r.ensureNotNull(maybeUnit, () => testFailure);
      });

      expect(result, const Right<String, Unit>(unit));
    });
  });
}
