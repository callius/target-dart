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
}
