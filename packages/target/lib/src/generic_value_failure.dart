import 'package:equatable/equatable.dart';
import 'package:target/src/value_failure.dart';

/// A generic implementation of [ValueFailure]. Can either be used on its own or
/// extended.
class GenericValueFailure<T extends Object> extends Equatable
    implements ValueFailure<T> {
  @override
  final T failedValue;

  const GenericValueFailure(this.failedValue);

  @override
  List<Object> get props => [failedValue];

  @override
  bool get stringify => true;
}
