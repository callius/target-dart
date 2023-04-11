import 'package:dartz/dartz.dart';

abstract class Modelable<Failure, Model> {
  /// Creates a model from this.
  Either<Failure, Model> toModel();
}
