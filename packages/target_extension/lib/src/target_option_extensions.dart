import 'package:target/target.dart';

extension TargetOptionX<T> on Option<T> {
  Either<L, T> toEither<L>(L Function() onNone) =>
      this.fold(() => Left(onNone()), Right.new);

  /// Returns `Some(null)` when [None].
  Some<T?> orSomeNull() =>
      this.fold(() => const Some(null), (_) => this as Some<T>);
}
