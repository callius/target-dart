import 'package:target/target.dart';
import 'package:target_extension/src/target_either_extensions.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Either.toOption', () {
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
