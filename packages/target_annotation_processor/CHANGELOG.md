## 0.8.0

#### Breaking Changes:

- New `target_annotation_processor` paradigm centered around the `Validatable` annotation.
    - Removed dependency on `freezed`.
    - Validation function, named `_$of`, is generated based on unnamed constructor arguments.

Before:

```dart
@ModelTemplate("Some")
abstract class SomeModel {
  // ...fields...
}
```

After:

```dart
@validatable
class Some {
  const Some(/* fields */);
  
  static const of = _$of;
}
```

Freezed data classes still work:

```dart
@freezed
@validatable
class Some with _$Some {
  const factory Some(/* fields */) = _Some;
  
  static const of = _$of;
}
```

## 0.7.1

Fixes:

- Downgrade `analyzer` dependency to 6.2.0.

## 0.7.0

Features:

- Upgrade `analyzer` dependency to 6.3.0.

## 0.6.1

Fixes:

- Typing for `Either.bindTo`.
- Typing for `Future<Either>.thenBind`.

## 0.6.0

Features:

- Upgrade to Dart 3.2.
- Add `Either.bindTo`.
- Add `Future<Either>.thenBind`.

## 0.5.0

Features:

- Add `Either.mapAsync`.
- Add `NonEmptyList.foldWithHead`.
- Rename `Either.orNull` to `Either.getOrNull`.
- Rename `Either.tap` to `Either.onRight`.
- Rename `Either.tapLeft` to `Either.onLeft`.
- Remove `NonEmptyList.fromList`.

## 0.4.4

Fixes:

- Implement `GenericValueFailure` equality.

## 0.4.3

Fixes:

- Downgrade `analyzer` dependency to 5.13.0.

## 0.4.2

Fixes:

- Remove unnecessary parentheses.
- Add `const` where applicable.

## 0.4.1

Fixes:

- Pass `BuilderOptions` to `PartBuilder`.

## 0.4.0

Features:

- Upgrade `analyzer` dependency to `^6.2.0`.

## 0.3.0

Features:

- Add arrow-kt nullable dsl in the form of `nullable()` and `nullableAsync()`.

## 0.2.0

Features:

- Add arrow-kt raise dsl in the form of `either()` and `eitherAsync()`.

Maintenance:

- Upgrade to Dart 3.
- Add `final` and `interface` class modifiers.
- Remove explicit `freezed` dependency from `target_annotation_processor`.

## 0.1.2

Features:

- Add support for enum value objects in `target_annotation_processor`.

## 0.1.0

Initial implementation:

- A basic implementation of functional value objects.
