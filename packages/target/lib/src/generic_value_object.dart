import 'package:equatable/equatable.dart';
import 'package:target/src/value_object.dart';

/// A generic implementation of [ValueObject].
abstract class GenericValueObject<T extends Object> extends Equatable
    implements ValueObject<T> {
  @override
  final T value;

  const GenericValueObject(this.value);

  @override
  List<Object> get props => [value];

  @override
  bool get stringify => true;
}
