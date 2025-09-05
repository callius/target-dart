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
}
