import 'package:target/src/either.dart';
import 'package:target/src/generic_value_failure.dart';
import 'package:target/src/value_object.dart';
import 'package:target/src/value_validator.dart';

class EmailAddressValidator<T extends ValueObject<String>>
    extends ValueValidator<String, GenericValueFailure<String>, T> {
  /// Email regex from the [HTML spec](https://html.spec.whatwg.org/multipage/input.html#e-mail-state-%28type=email%29).
  static const String _emailRegex =
      r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";

  static final _regex = RegExp(_emailRegex);

  final T Function(String input) _ctor;

  const EmailAddressValidator(this._ctor);

  @override
  Either<GenericValueFailure<String>, T> of(String input) {
    if (_regex.hasMatch(input)) {
      return Right(_ctor(input));
    } else {
      return Left(GenericValueFailure(input));
    }
  }
}
