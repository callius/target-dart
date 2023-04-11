import 'package:dartz/dartz.dart';
import 'package:target_extension/src/target_effects.dart';

extension TargetOptionX<T> on Option<T> {
  /// Performs the given side-[effect] if this is [Some].
  void ifSome(DartzEffect<T> effect) {
    if (this is Some<T>) {
      effect((this as Some<T>).value);
    }
  }

  /// Returns `Some(null)` when [None].
  Some<T?> orSomeNull() => fold(() => const Some(null), (_) => this as Some<T>);
}
