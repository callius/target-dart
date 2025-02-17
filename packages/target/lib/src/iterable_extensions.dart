import 'package:dartz/dartz.dart';
import 'package:target/target.dart';

extension TargetCoreEitherIterableExtensions<L, R> on Iterable<Either<L, R>> {
  Either<Nel<L>, List<R>> validate() {
    final failureList = <L>[];
    final successList = <R>[];

    for (final it in this) {
      it.fold(failureList.add, successList.add);
    }

    final failureNel = failureList.toNonEmptyListOrNull();
    if (failureNel == null) {
      return Right(successList);
    } else {
      return Left(failureNel);
    }
  }
}
