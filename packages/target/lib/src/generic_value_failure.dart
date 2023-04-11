import 'package:target/src/value_failure.dart';

class GenericValueFailure<T> implements ValueFailure<T> {
  @override
  final T failedValue;

  const GenericValueFailure(this.failedValue);
}
