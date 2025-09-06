import 'package:target/src/either.dart';

abstract interface class Modelable<Failure, Model> {
  /// Creates a model from this.
  Either<Failure, Model> toModel();
}
