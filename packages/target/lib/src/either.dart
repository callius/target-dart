import 'package:target/src/option.dart';

sealed class Either<L, R> {
  const Either();

  R? getOrNull();

  bool isLeft();

  bool isRight();
}

final class Left<L> extends Either<L, Never> {
  const Left(this.value);

  final L value;

  @override
  Null getOrNull() => null;

  @override
  bool isLeft() => true;

  @override
  bool isRight() => false;

  @override
  bool operator ==(Object other) => other is Left<L> && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

final class Right<R> extends Either<Never, R> {
  const Right(this.value);

  final R value;

  @override
  R getOrNull() => value;

  @override
  bool isLeft() => false;

  @override
  bool isRight() => true;

  @override
  bool operator ==(Object other) => other is Right<R> && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class EitherCaseError<L, R> extends StateError {
  EitherCaseError(Either<L, R> parent) : super('invalid case ($parent)');
}

extension TargetEitherExtensions<L, R> on Either<L, R> {
  T fold<T>(T Function(L) onLeft, T Function(R) onRight) => switch (this) {
    Left(value: final value) => onLeft(value),
    Right(value: final value) => onRight(value),
    _ => throw EitherCaseError(this),
  };

  Either<L, R2> map<R2>(R2 Function(R) map) => switch (this) {
    Left() => this as Left<L>,
    Right(value: final value) => Right(map(value)),
    _ => throw EitherCaseError(this),
  };

  Either<L2, R> mapLeft<L2>(L2 Function(L) map) => switch (this) {
    Left(value: final value) => Left(map(value)),
    Right() => this as Right<R>,
    _ => throw EitherCaseError(this),
  };

  Either<L, R2> flatMap<R2>(Either<L, R2> Function(R) map) => switch (this) {
    Left() => this as Left<L>,
    Right(value: final value) => map(value),
    _ => throw EitherCaseError(this),
  };

  R getOrElse(R Function(L) onLeft) => switch (this) {
    Left(value: final value) => onLeft(value),
    Right(value: final value) => value,
    _ => throw EitherCaseError(this),
  };

  /// Applies the given function f if this is a Left, otherwise returns this if
  /// this is a Right. This is like flatMap for the exception.
  ///
  /// Based on the arrow-kt implementation in Kotlin.
  Either<C, R> handleErrorWith<C>(Either<C, R> Function(L it) f) =>
      switch (this) {
        Left(value: final value) => f(value),
        Right() => this as Right<R>,
        _ => throw EitherCaseError(this),
      };

  Either<L, R> onLeft(void Function(L) onLeft) {
    if (this is Left<L>) {
      onLeft((this as Left<L>).value);
    }
    return this;
  }

  Either<L, R> onRight(void Function(R) onRight) {
    if (this is Right<R>) {
      onRight((this as Right<R>).value);
    }
    return this;
  }

  Either<R, L> swap() => switch (this) {
    Left(value: final value) => Right(value),
    Right(value: final value) => Left(value),
    _ => throw EitherCaseError(this),
  };

  Option<R> toOption() => fold((_) => const None(), Some.new);
}

extension TargetEitherNullableExtensions<L, R> on Either<L, R>? {
  /// Returns [Left] when this is null.
  Either<L?, R> leftIfNull() {
    if (this == null) {
      return const Left(null);
    } else {
      return this!;
    }
  }

  /// Returns [Right] when this is null.
  Either<L, R?> rightIfNull() {
    if (this == null) {
      return const Right(null);
    } else {
      return this!;
    }
  }
}
