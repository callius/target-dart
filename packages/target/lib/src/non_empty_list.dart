import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';

typedef Nel<T> = NonEmptyList<T>;

/// A list which contains at least one item.
/// Loosely based on the ArrowKt implementation, optimized for Dart `const` constructors.
class NonEmptyList<T> extends DelegatingIterable<T> {
  const NonEmptyList._(super.base);

  const NonEmptyList.fromListUnsafe(List<T> super.list);

  factory NonEmptyList.of(T item) => NonEmptyList._([item]);

  // NOTE: This syntax is deprecated in arrow-kt.
  static Option<NonEmptyList<T>> fromList<T>(List<T> list) {
    if (list.isEmpty) {
      return const None();
    } else {
      return Some(NonEmptyList._(list));
    }
  }

  @override
  bool get isEmpty => false;

  @override
  NonEmptyList<R> map<R>(R Function(T p1) f) {
    return NonEmptyList.fromListUnsafe(
      super.map(f).toList(),
    );
  }

  T operator [](int index) {
    return elementAt(index);
  }

  /// Returns a new instance of the items in this appended with the items in [other].
  NonEmptyList<T> operator +(Iterable<T> other) {
    return NonEmptyList._([...this, ...other]);
  }

  /// Returns a new instance of the items in this appended with the given [item].
  NonEmptyList<T> plus(T item) {
    return NonEmptyList._([...this, item]);
  }
}

extension TypeNelX<T> on T {
  NonEmptyList<T> nel() => NonEmptyList.of(this);
}

extension IterableNonEmptyListX<T> on Iterable<T> {
  NonEmptyList<T>? toNonEmptyListOrNull() {
    if (isEmpty) {
      return null;
    } else {
      return NonEmptyList._(this);
    }
  }
}
