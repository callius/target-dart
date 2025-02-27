import 'package:dartz/dartz.dart';
import 'package:target/target.dart' hide fold;
import 'package:target_extension/src/target_effects.dart';

extension TargetEitherX<L, R> on Either<L, R> {
  /// Async [map] variant.
  Future<Either<L, R2>> mapAsync<R2>(Future<R2> Function(R) f) {
    return fold(
      (it) => Future.value(Left(it)),
      (it) => f(it).then(Right.new),
    );
  }

  /// Async [flatMap] variant.
  Future<Either<L, T>> flatMapAsync<T>(Future<Either<L, T>> Function(R) f) {
    return fold((l) => Future.value(Left(l)), f);
  }

  /// Performs the given side-[effect] if this is [Right] and returns this.
  Either<L, R> onRight(DartzEffect<R> effect) {
    ifRight(effect);
    return this;
  }

  /// Performs the given side-[effect] if this is [Right].
  void ifRight(DartzEffect<R> effect) {
    if (this is Right<L, R>) {
      effect((this as Right<L, R>).value);
    }
  }

  /// Performs the given side-[effect] if this is [Left] and returns this.
  Either<L, R> onLeft(DartzEffect<L> effect) {
    ifLeft(effect);
    return this;
  }

  /// Performs the given side-[effect] if this is [Left].
  void ifLeft(DartzEffect<L> effect) {
    if (this is Left<L, R>) {
      effect((this as Left<L, R>).value);
    }
  }

  /// Returns the unwrapped value [R] of [Right] or `null` if it is [Left].
  R? getOrNull() => fold((_) => null, id);

  /// Applies the given function f if this is a Left, otherwise returns this if
  /// this is a Right. This is like flatMap for the exception.
  ///
  /// Based on the arrow-kt implementation in Kotlin.
  Either<C, R> handleErrorWith<C>(Either<C, R> Function(L it) f) {
    // NOTE: Instantiating a new Right instance due to the bad typing of the dartz package.
    //  Right in arrow-kt extends Either<Nothing, R>, and in dartz: Either<L, R> instead of Either<Never, R>.
    //  This prevents a type cast here on right: (_) => this as Right<R>.
    return fold(f, Right.new);
  }

  /// Async version of [handleErrorWith].
  Future<Either<C, R>> handleErrorWithAsync<C>(
    Future<Either<C, R>> Function(L it) f,
  ) async {
    return fold(f, Right.new);
  }
}

extension TargetEitherNullableX<L, R> on Either<L, R>? {
  /// Returns [Left] when this is null.
  ///
  /// NOTE: Dart type inference is not able to discern this from an if-null operator.
  Either<L?, R> leftIfNull() {
    if (this == null) {
      return const Left(null);
    } else {
      return this!;
    }
  }

  /// Returns [Right] when this is null.
  ///
  /// NOTE: Dart type inference is not able to discern this from an if-null operator.
  Either<L, R?> rightIfNull() {
    if (this == null) {
      return const Right(null);
    } else {
      return this!;
    }
  }
}

extension TargetNullableTypeToEitherX<R> on R? {
  /// Returns [Right] if not null, otherwise [Left] with [ifNull].
  Either<L, R> toEither<L>(L Function() ifNull) {
    if (this == null) {
      return Left(ifNull());
    } else {
      // This is never null.
      // ignore: null_check_on_nullable_type_parameter
      return Right(this!);
    }
  }
}

extension TargetFutureEitherX<L, R> on Future<Either<L, R>> {
  Future<Either<L2, R>> thenLeftMap<L2>(L2 Function(L l) f) {
    return then((it) => it.leftMap(f));
  }
}

extension TargetFutureEitherBindX<Error, L extends Error, R>
    on Future<Either<L, R>> {
  Future<R> thenBind(Raise<Error> r) {
    return then(r.bind);
  }
}
