import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:target/src/raise_fold.dart';

/// Implementation of arrow-kt raise dsl.
abstract class Raise<Error> {
  Never raise(Error r);
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

A recover<Error, A>(
  A Function(Raise<Error>) block,
  A Function(Error) recover,
) =>
    fold(block, (it) => throw it, recover, id);

Future<A> recoverAsync<Error, A>(
  Future<A> Function(Raise<Error>) block,
  A Function(Error) recover,
) =>
    foldAsync(block, (it) => throw it, recover, id);

extension RaiseEnsureExtension<Error> on Raise<Error> {
  A bind<A, E extends Error>(Either<E, A> r) => r.fold(raise, id);

  void ensure(bool condition, Error Function() raise) {
    if (!condition) {
      this.raise(raise());
    }
  }

  B ensureNotNull<B>(B? value, Error Function() raise) =>
      value ?? this.raise(raise());
}

A merge<A>(A Function(Raise<A>) block) => recover(block, id);

Future<A> mergeAsync<A>(Future<A> Function(Raise<A>) block) =>
    recoverAsync(block, id);
