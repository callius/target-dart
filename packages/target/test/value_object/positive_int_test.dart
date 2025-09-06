import 'package:target/src/either.dart';
import 'package:target/src/value_object/positive_int.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('PositiveInt.of', () {
    group('returns Left when the input is not positive', () {
      _testInvalidPositiveInt(-42);
      _testInvalidPositiveInt(-1);
      _testInvalidPositiveInt(0);
    });
    group('returns Right when the input is positive', () {
      _testValidPositiveInt(1);
      _testValidPositiveInt(42);
    });
  });
}

void _testInvalidPositiveInt(int input) {
  test(input, () {
    final result = PositiveInt.of(input);

    expect(result.isLeft(), isTrue);
  });
}

void _testValidPositiveInt(int input) {
  test(input, () {
    final result = PositiveInt.of(input);

    expect(result.fold((_) => false, (it) => it.value == input), isTrue);
  });
}
