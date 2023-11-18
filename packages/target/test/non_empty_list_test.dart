import 'package:target/src/non_empty_list.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('NonEmptyList.foldWithHead', () {
    test('returns the accumulated value', () {
      final numbers = [1, 2, 3].toNonEmptyListOrNull()!;

      final result = numbers.foldWithHead((it) => it, (acc, it) => acc + it);

      expect(result, 6);
    });
  });
}
