import 'package:equatable/equatable.dart';
import 'package:target/src/either.dart';
import 'package:target/src/raise_fold.dart';

/// Implementation of arrow-kt raise dsl.
abstract interface class Raise<E> {
  Never raise(E r);
}

final class RaiseCancellationException<E> extends Equatable
    implements Exception {
  final E raised;
  final Raise<E> raise;

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

A recover<E, A>(A Function(Raise<E>) block, A Function(E) recover) =>
    fold(block, (it) => throw it, recover, (it) => it);

Future<A> recoverAsync<E, A>(
  Future<A> Function(Raise<E>) block,
  A Function(E) recover,
) => foldAsync(block, (it) => throw it, recover, (it) => it);

extension RaiseEnsureExtension<E> on Raise<E> {
  A bind<A, E2 extends E>(Either<E2, A> r) => r.fold(raise, (it) => it);

  void ensure(bool condition, E Function() raise) {
    if (!condition) {
      this.raise(raise());
    }
  }
}

A merge<A>(A Function(Raise<A>) block) => recover<A, A>(block, (it) => it);

Future<A> mergeAsync<A>(Future<A> Function(Raise<A>) block) =>
    recoverAsync<A, A>(block, (it) => it);
