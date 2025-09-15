import 'package:target/target.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Either.map()', () {
    test('returns left when left', () {
      const testLeft = Left('failure');

      final result = testLeft.map((_) => unit);

      expect(result, testLeft);
    });

    test('returns mapped value when right', () {
      const testRight = Right('value');

      final result = testRight.map((_) => unit);

      expect(result, const Right(unit));
    });
  });
  group('Either.getOrElse()', () {
    test('returns mapped value when left', () {
      const Either<String, Unit> testLeft = Left('failure');

      final result = testLeft.getOrElse((_) => unit);

      expect(result, unit);
    });

    test('returns value when right', () {
      const testRight = Right('value');

      final result = testRight.getOrElse((_) => '');

      expect(result, 'value');
    });
  });
  group('Either.fold()', () {
    test('returns mapped value when left', () {
      const testLeft = Left('failure');

      final result = testLeft.fold((_) => unit, (_) => unit);

      expect(result, unit);
    });

    test('returns mapped value when right', () {
      const testRight = Right('value');

      final result = testRight.fold((_) => unit, (_) => unit);

      expect(result, unit);
    });
  });
  group('Either.toOption()', () {
    test('returns none when left', () {
      const testLeft = Left<GenericValueFailure<Unit>>(
        GenericValueFailure(unit),
      );

      final result = testLeft.toOption();

      expect(result, const None());
    });

    test('returns some when right', () {
      const testRight = Right<Unit>(unit);

      final result = testRight.toOption();

      expect(result, const Some(unit));
    });
  });
}
