import 'package:target/src/generic_value_failure.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('GenericValueFailure', () {
    test('implements value equality', () {
      const instance1 = GenericValueFailure('failed');
      const instance2 = GenericValueFailure('failed');

      expect(instance1, instance2);
    });
  });
}
