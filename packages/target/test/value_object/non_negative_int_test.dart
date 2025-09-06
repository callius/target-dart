import 'package:target/src/either.dart';
import 'package:target/src/value_object/non_negative_int.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('NonNegativeInt.of', () {
    group('returns Left when the input is negative', () {
      _testInvalidNonNegativeInt(-42);
      _testInvalidNonNegativeInt(-1);
    });
    group('returns Right when the input is non-negative', () {
      _testValidNonNegativeInt(0);
      _testValidNonNegativeInt(1);
      _testValidNonNegativeInt(42);
    });
  });
}

void _testInvalidNonNegativeInt(int input) {
  test(input, () {
    final result = NonNegativeInt.of(input);

    expect(result.isLeft(), isTrue);
  });
}

void _testValidNonNegativeInt(int input) {
  test(input, () {
    final result = NonNegativeInt.of(input);

    expect(result.fold((_) => false, (it) => it.value == input), isTrue);
  });
}
