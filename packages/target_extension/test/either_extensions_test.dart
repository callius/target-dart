import 'package:dartz/dartz.dart';
import 'package:target/target.dart';
import 'package:target_extension/src/target_either_extensions.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Future<Either>.thenBind', () {
    test('returns left when left', () async {
      const testLeft =
          Left<GenericValueFailure<Unit>, Unit>(GenericValueFailure(unit));

      final result = await eitherAsync<ValueFailure<Unit>, Unit>(
        (r) => Future<Either<GenericValueFailure<Unit>, Unit>>.value(testLeft)
            .thenBind(r),
      );

      expect(result, testLeft);
    });

    test('returns right when right', () async {
      const testRight = Right<String, Unit>(unit);

      final result = await eitherAsync<String, Unit>(
        (r) => Future<Either<String, Unit>>.value(testRight).thenBind(r),
      );

      expect(result, testRight);
    });
  });
}
