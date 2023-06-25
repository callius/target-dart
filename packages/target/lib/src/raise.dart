import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// DSL for computing an [Either] from the given effect [block]. Based on the
/// arrow-kt implementation.
Either<Error, A> either<Error, A>(A Function(Raise<Error> r) block) {
  return foldOrThrow(block, Left.new, Right.new);
}

B foldOrThrow<Error, A, B>(
  A Function(Raise<Error> r) block,
  B Function(Error error) recover,
  B Function(A value) transform,
) {
  return fold(block, (it) => throw it, recover, transform);
}

B fold<Error, A, B>(
  A Function(Raise<Error> r) block,
  B Function(Exception throwable) onCatch,
  B Function(Error error) recover,
  B Function(A value) transform,
) {
  final raise = _DefaultRaise<Error>();
  try {
    final res = block(raise);
    raise.complete();
    return transform(res);
  } on RaiseCancellationException<Error> catch (e) {
    raise.complete();
    return recover(e.raised);
  } on Exception catch (e) {
    raise.complete();
    return onCatch(e);
  }
}

/// DSL for computing an [Either] async from the given effect [block]. Based on
/// the arrow-kt implementation.
Future<Either<Error, A>> eitherAsync<Error, A>(
  Future<A> Function(Raise<Error> r) block,
) {
  return foldOrThrowAsync(block, Left.new, Right.new);
}

Future<B> foldOrThrowAsync<Error, A, B>(
  Future<A> Function(Raise<Error> r) block,
  B Function(Error error) recover,
  B Function(A value) transform,
) {
  return foldAsync(block, (it) => throw it, recover, transform);
}

Future<B> foldAsync<Error, A, B>(
  Future<A> Function(Raise<Error> r) block,
  B Function(Exception throwable) onCatch,
  B Function(Error error) recover,
  B Function(A value) transform,
) async {
  final raise = _DefaultRaise<Error>();
  try {
    final res = await block(raise);
    raise.complete();
    return transform(res);
  } on RaiseCancellationException<Error> catch (e) {
    raise.complete();
    return recover(e.raised);
  } on Exception catch (e) {
    raise.complete();
    return onCatch(e);
  }
}

/// Implementation of arrow-kt raise dsl.
abstract class Raise<Error> {
  Never raise(Error r);

  A bind<A, E extends Error>(Either<E, A> r) {
    return r.fold(raise, id);
  }
}

final class _DefaultRaise<Error> extends Raise<Error> {
  bool _isActive = true;

  bool complete() {
    final result = _isActive;
    _isActive = false;
    return result;
  }

  @override
  Never raise(Error r) {
    if (_isActive) {
      throw RaiseCancellationException(raised: r, raise: this);
    } else {
      throw RaiseLeakedError();
    }
  }
}

final class RaiseCancellationException<Error> extends Equatable
    implements Exception {
  final Error raised;
  final Raise<Error> raise;

  const RaiseCancellationException({required this.raised, required this.raise});

  @override
  List<Object?> get props => [raised, raise];
}

final class RaiseLeakedError extends StateError {
  RaiseLeakedError()
      : super(
          'raise or bind was called outside of its DSL scope, and the DSL Scoped operator was leaked',
        );
}

extension RaiseEnsureExtension<Error> on Raise<Error> {
  void ensure(bool condition, Error Function() raise) {
    if (!condition) {
      this.raise(raise());
    }
  }

  B ensureNotNull<B>(B? value, Error Function() raise) {
    return value ?? this.raise(raise());
  }
}
