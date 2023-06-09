import 'package:target/target.dart';

void main() {
  // Validating an email address.
  EmailAddress.of('john.doe@example.com').fold(
    (it) => print('Email address is not valid: $it'),
    (it) => print('Email address is valid: $it'),
  );
  // Prints: Email address is valid: EmailAddress(john.doe@example.com)
}
