# Target

Target is a library for Functional Domain Modeling in Dart, the Dart implementation
of [target-kt](https://target-kt.io), inspired by [arrow-kt](https://arrow-kt.io).

Target aims to provide a set of tools for Dart to empower users to quickly write pure, functionally
validated domain models. For this, it includes a set of atomic components: `ValueFailure`, `ValueObject`,
and `ValueValidator`. These components can be used on their own, or in conjunction with the
included `build_runner` annotation processor.

## Getting Started

#### Value Failure

A `ValueFailure` is an interface representing a failure during value validation.

```dart
abstract class ValueFailure<T> {
  abstract final T failedValue;
}
```

#### Value Object

A `ValueObject` is an interface representing a validated value. By convention, value object implementations have a
private primary constructor, so that they are not instantiated outside a `ValueValidator`. A value object implementation
must declare a static implementation of a value validator, `of`, when used in conjunction with the annotation
processor package.

```dart
abstract class ValueObject<T> {
  abstract final T value;
}
```

#### Value Validator

A `ValueValidator` is an interface defining value validation functions. The primary validation function, `of`, takes an
input and returns either a `ValueFailure` or a `ValueObject`. The value validator is also callable, delegating to `of`.
By convention, the value object's private constructor is often passed to its primary constructor as a reference.

```dart
abstract class ValueValidator<I extends Object, F extends ValueFailure<I>, T extends ValueObject<I>> {
  const ValueValidator();

  Either<F, T> of(I input);

// ...
}
```

### Examples

The included `StringInRegexValidator` class is an example of a `ValueValidator` implementation.

```dart
class StringRegexValidator<T extends ValueObject<String>>
    extends ValueValidator<String, GenericValueFailure<String>, T> {
  final T Function(String input) _ctor;
  final RegExp regExp;

  const StringRegexValidator(this._ctor, {required this.regExp});

  @override
  Either<GenericValueFailure<String>, T> of(String input) {
    if (regExp.hasMatch(input)) {
      return Right(_ctor(input));
    } else {
      return Left(GenericValueFailure(input));
    }
  }
}
```

The included `EmailAddress` class is an example of an annotation processor compatible `ValueObject` implementation.

```dart
/// A W3C HTML5 email address.
class EmailAddress extends GenericValueObject<String> {
  static const of = EmailAddressValidator(EmailAddress._);

  const EmailAddress._(super.value);
}
```

This value object can then be used to validate an email address like so:

```dart
Either<UserCreateFailure, User> createUser(UserParamsDto params) {
  return EmailAddress.of(params.emailAddress)
      .leftMap(UserCreateFailure.invalidEmailAddress)
      .flatMap(
        (emailAddress) =>
    // ... validating other params ...
    repositoryCreate(
      UserParams(
        emailAddress: emailAddress,
        // ... passing other validated params ...
      ),
    ),
  );
}
```
