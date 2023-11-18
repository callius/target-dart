import 'package:collection/collection.dart';

typedef Nel<T> = NonEmptyList<T>;

/// A list which contains at least one item.
/// Loosely based on the ArrowKt implementation, optimized for Dart `const` constructors.
final class NonEmptyList<T> extends DelegatingList<T> {
  const NonEmptyList._(super.base);

  const NonEmptyList.fromListUnsafe(super.list);

  factory NonEmptyList.of(T item) => NonEmptyList._([item]);

  @override
  bool get isEmpty => false;

  @override
  NonEmptyList<R> map<R>(R Function(T p1) f) {
    return NonEmptyList.fromListUnsafe(
      super.map(f).toList(),
    );
  }

  /// Returns a new instance of the items in this appended with the items in [other].
  @override
  NonEmptyList<T> operator +(Iterable<T> other) {
    return NonEmptyList._([...this, ...other]);
  }

  /// Returns a new instance of the items in this appended with the given [item].
  NonEmptyList<T> plus(T item) {
    return NonEmptyList._([...this, item]);
  }

  /// Folds this list using the result of the [headOperation] as the first
  /// value, followed by accumulating the value with the tail using the
  /// [operation].
  ///
  /// ```
  /// final numbers = [1, 2, 3].toNonEmptyListOrNull()!;
  /// final six = numbers.foldWithHead((it) => it, (acc, it) => acc + it);
  /// ```
  R foldWithHead<R>(
    R Function(T) headOperation,
    R Function(R acc, T) operation,
  ) {
    return skip(1).fold(headOperation(first), operation);
  }
}

extension TypeNelX<T> on T {
  NonEmptyList<T> nel() => NonEmptyList.of(this);
}

extension IterableNonEmptyListX<T> on List<T> {
  NonEmptyList<T>? toNonEmptyListOrNull() {
    if (isEmpty) {
      return null;
    } else {
      return NonEmptyList._(this);
    }
  }
}
