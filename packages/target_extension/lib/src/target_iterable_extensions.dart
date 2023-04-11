import 'package:dartz/dartz.dart';
import 'package:target_extension/src/build_map.dart';

extension TargetIterableExtensions<T> on Iterable<T> {
  int get lastIndex => length - 1;

  Map<K, List<T>> associateBy<K>(K Function(T it) keySelector) {
    return buildMap((result) {
      for (final it in this) {
        result.update(
          keySelector(it),
          (value) => value..add(it),
          ifAbsent: () => [it],
        );
      }
    });
  }

  /// Traverse either implementation based on the arrow-kt library in Kotlin.
  Either<L, List<R>> traverseEither<L, R>(Either<L, R> Function(T it) f) {
    final destination = <R>[];
    for (final item in this) {
      final res = f(item);
      if (res is Right<L, R>) {
        destination.add(res.value);
      } else if (res is Left<L, R>) {
        return Left(res.value);
      }
    }
    return Right(destination);
  }
}
