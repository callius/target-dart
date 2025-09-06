Option<T> optionOf<T>(T? value) => value == null ? const None() : Some(value);

sealed class Option<T> {
  const Option();

  T? getOrNull();

  bool isNone();

  bool isSome();
}

final class None extends Option<Never> {
  const None();

  @override
  Null getOrNull() => null;

  @override
  bool isNone() => true;

  @override
  bool isSome() => false;

  @override
  bool operator ==(Object other) => other is None;

  @override
  int get hashCode => identityHashCode(this);
}

final class Some<T> extends Option<T> {
  const Some(this.value);

  final T value;

  @override
  T getOrNull() => value;

  @override
  bool isNone() => false;

  @override
  bool isSome() => true;

  @override
  bool operator ==(Object other) => other is Some<T> && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

extension TargetOptionExtensions<T> on Option<T> {
  R fold<R>(R Function() onNone, R Function(T) onSome) => switch (this) {
    Some(value: final value) => onSome(value),
    _ => onNone(),
  };

  Option<R> map<R>(R Function(T) onSome) => switch (this) {
    Some(value: final value) => Some(onSome(value)),
    _ => const None(),
  };

  Option<R> flatMap<R>(Option<R> Function(T) onSome) => switch (this) {
    Some(value: final value) => onSome(value),
    _ => const None(),
  };

  T getOrElse(T Function() onNone) => switch (this) {
    Some(value: final value) => value,
    _ => onNone(),
  };

  Option<T> onNone(void Function() onNone) {
    if (this is! Some<T>) {
      onNone();
    }
    return this;
  }

  Option<T> onSome(void Function(T) onSome) {
    if (this is Some<T>) {
      onSome((this as Some<T>).value);
    }
    return this;
  }
}
