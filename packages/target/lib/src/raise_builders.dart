import 'package:target/src/either.dart';
import 'package:target/src/option.dart';
import 'package:target/src/raise.dart';
import 'package:target/src/raise_fold.dart';

/// DSL for computing an [Either] from the given effect [block]. Based on the
/// arrow-kt implementation.
Either<E, A> either<E, A>(A Function(Raise<E> r) block) =>
    foldOrThrow(block, Left.new, Right.new);

/// DSL for computing an [Either] async from the given effect [block]. Based on
/// the arrow-kt implementation.
Future<Either<E, A>> eitherAsync<E, A>(Future<A> Function(Raise<E> r) block) =>
    foldOrThrowAsync(block, Left.new, Right.new);

/// DSL for computing a nullable from the given effect [block]. Based on the
/// arrow-kt implementation.
A? nullable<A>(A Function(NullableRaise r) block) =>
    merge((r) => block(NullableRaise(r)));

/// DSL for computing a nullable async from the given effect [block]. Based on
/// the arrow-kt implementation.
Future<A?> nullableAsync<A>(Future<A> Function(NullableRaise r) block) =>
    mergeAsync((r) => block(NullableRaise(r)));

final class NullableRaise implements Raise<void> {
  final Raise<void> _delegate;

  NullableRaise(this._delegate);

  @override
  Never raise(void r) => _delegate.raise(r);

  A bind<B, A>(Either<B, A> r) => r.fold((_) => raise(null), (it) => it);

  A bindOption<A>(Option<A> r) => r.fold(() => raise(null), (it) => it);

  void ensure(bool condition) {
    if (!condition) {
      raise(null);
    }
  }
}
