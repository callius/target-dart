# Agents

This file provides guidance to agents when working with code in this repository.

## Build Commands

This is a Dart monorepo with three packages in `packages/`:

- `target` - Core library with FP types (Either, Option, Raise) and value validation
- `target_annotation` - `@validatable` annotation for code generation
- `target_annotation_processor` - build_runner generator that processes `@validatable`

```bash
# Get dependencies (run in each package directory)
dart pub get

# Run tests
dart test                                    # in any package directory
dart test test/source_gen_test.dart          # single test file

# Run code generation (in target_annotation_processor or consumer projects)
dart run build_runner build

# Analyze code
dart analyze
```

## Architecture

**Core FP Types (target package)**

- `Either<L, R>` - Sealed class with `Left`/`Right` subclasses for error handling
- `Option<T>` - Sealed class with `Some`/`None` for optional values
- `Raise<E>` - Interface implementing arrow-kt's raise DSL for typed error short-circuiting
- Extensions provide `fold`, `map`, `flatMap`, `getOrElse`, `bind` operations

**Value Validation Pattern**

- `ValueFailure<T>` - Interface for validation failures with `failedValue`
- `ValueObject<T>` - Interface for validated values with `value`
- `ValueValidator<I, F, T>` - Abstract class that validates input, returns `Either<F, T>`
- Convention: Value objects have private constructors, expose `static const of = SomeValidator(ClassName._);`

**Code Generation (target_annotation_processor)**

- `@validatable` on a class generates `_$of` function and `*FieldFailure` sealed classes
- Generator detects fields that are `ValueObject` subtypes or nested `@validatable` models
- Supports `Option<ValueObject>` fields for optional validated values
- Generated files have `.core.dart` extension
- Uses `source_gen` with `PartBuilder` pattern

**Testing the Generator**

- Uses `source_gen_test` for golden-file style testing
- Test files in `test/source_gen_src/` contain annotated classes with expected output in comments
- `testAnnotatedElements` compares generated output against expected comments
