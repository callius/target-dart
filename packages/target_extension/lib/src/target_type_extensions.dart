extension TargetTypeExtensions<T> on T {
  /// Kotlin's let function.
  R let<R>(R Function(T it) f) => f(this);

  /// Kotlin's also function.
  T also(void Function(T it) f) {
    f(this);
    return this;
  }
}
