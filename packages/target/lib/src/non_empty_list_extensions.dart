import 'package:dartz/dartz.dart';
import 'package:target/target.dart';

extension TargetCoreEitherNonEmptyListExtensions<L, R>
    on NonEmptyList<Either<L, R>> {
  Either<Nel<L>, Nel<R>> validate() {
    final failureList = <L>[];
    final successList = <R>[];

    for (final it in this) {
      it.fold(failureList.add, successList.add);
    }

    final failureNel = failureList.toNonEmptyListOrNull();
    if (failureNel == null) {
      return Right(successList.toNonEmptyListOrNull()!);
    } else {
      return Left(failureNel);
    }
  }
}
