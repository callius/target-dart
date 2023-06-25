import 'package:target/src/generic_value_object.dart';
import 'package:target/src/value_validator/email_address_validator.dart';

/// A W3C HTML5 email address.
final class EmailAddress extends GenericValueObject<String> {
  static const of = EmailAddressValidator(EmailAddress._);

  const EmailAddress._(super.value);
}
