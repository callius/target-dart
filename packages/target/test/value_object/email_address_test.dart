import 'package:target/src/either.dart';
import 'package:target/src/value_object/email_address.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('EmailAddress.of', () {
    group('returns Left when the input is not a valid email address', () {
      _testInvalidEmailAddress('john');
      _testInvalidEmailAddress('john@');
      _testInvalidEmailAddress('john@example.');
    });
    group('returns Right when the input is a valid email address', () {
      _testValidEmailAddress('john@example.com');
      _testValidEmailAddress('john.doe@example.com');
      _testValidEmailAddress('john.doe+test@example.com');
      _testValidEmailAddress('john.doe@test.example.com');
      _testValidEmailAddress('john.doe+test@test.example.com');
    });
  });
}

void _testInvalidEmailAddress(String input) {
  test(input, () {
    final result = EmailAddress.of(input);

    expect(result.isLeft(), isTrue);
  });
}

void _testValidEmailAddress(String input) {
  test(input, () {
    final result = EmailAddress.of(input);

    expect(result.fold((_) => false, (it) => it.value == input), isTrue);
  });
}
