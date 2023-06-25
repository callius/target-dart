import 'package:dartz/dartz.dart';

abstract interface class Buildable<T> {
  /// Builds [T] from this. Analogous to a zip function on all the builder's properties passed
  /// to the constructor of [T].
  Option<T> build();
}
