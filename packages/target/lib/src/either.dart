sealed class Either<L, R> {
  const Either();

  T fold<T>(T Function(L) onLeft, T Function(R) onRight);

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

  R getOrElse(R Function(L) onLeft) => fold(onLeft, (it) => it);

  R? getOrNull() => fold((_) => null, (it) => it);

  Either<R, L> swap() => fold(Right.new, Left.new);

  bool isLeft();

  bool isRight();

  Either<L, R> onLeft(void Function(L) onLeft);

  Either<L, R> onRight(void Function(R) onRight);
}

final class Left<L> extends Either<L, Never> {
  const Left(this.value);

  final L value;

  @override
  T fold<T>(T Function(L) onLeft, T Function(Never) onRight) => onLeft(value);

  @override
  bool isLeft() => true;

  @override
  bool isRight() => false;

  @override
  Either<L, Never> onLeft(void Function(L) onLeft) {
    onLeft(value);
    return this;
  }

  @override
  Either<L, Never> onRight(void Function(Never) onRight) => this;

  @override
  bool operator ==(Object other) {
    return other is Left<L> && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}

final class Right<R> extends Either<Never, R> {
  const Right(this.value);

  final R value;

  @override
  T fold<T>(T Function(Never) onLeft, T Function(R) onRight) => onRight(value);

  @override
  bool isLeft() => false;

  @override
  bool isRight() => true;

  @override
  Either<Never, R> onLeft(void Function(Never p1) onLeft) => this;

  @override
  Either<Never, R> onRight(void Function(R p1) onRight) {
    onRight(value);
    return this;
  }

  @override
  bool operator ==(Object other) {
    return other is Right<R> && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}

class EitherCaseError<L, R> extends StateError {
  EitherCaseError(Either<L, R> parent) : super('invalid case ($parent)');
}
