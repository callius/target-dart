Option<T> optionOf<T>(T? value) => value == null ? const None() : Some(value);

sealed class Option<T> {
  const Option();

  R fold<R>(R Function() onNone, R Function(T) onSome);

  Option<R> map<R>(R Function(T) onSome);

  T getOrElse(T Function() onNone) => fold(onNone, (it) => it);

  T? getOrNull() => fold(() => null, (it) => it);

  bool isNone();

  bool isSome();

  Option<T> onNone(void Function() onNone);

  Option<T> onSome(void Function(T) onSome);
}

final class None extends Option<Never> {
  const None();

  @override
  R fold<R>(R Function() onNone, R Function(Never) onSome) => onNone();

  @override
  Option<R> map<R>(R Function(Never) onSome) => this;

  @override
  bool isNone() => true;

  @override
  bool isSome() => false;

  @override
  Option<Never> onNone(void Function() onNone) {
    onNone();
    return this;
  }

  @override
  Option<Never> onSome(void Function(Never p1) onSome) => this;

  @override
  bool operator ==(Object other) => other is None;

  @override
  int get hashCode => identityHashCode(this);
}

final class Some<T> extends Option<T> {
  const Some(this.value);

  final T value;

  @override
  R fold<R>(R Function() onNone, R Function(T p1) onSome) => onSome(value);

  @override
  Option<R> map<R>(R Function(T) onSome) => Some(onSome(value));

  @override
  bool isNone() => false;

  @override
  bool isSome() => true;

  @override
  Option<T> onNone(void Function() onNone) => this;

  @override
  Option<T> onSome(void Function(T p1) onSome) {
    onSome(value);
    return this;
  }

  @override
  bool operator ==(Object other) {
    return other is Some<T> && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}
