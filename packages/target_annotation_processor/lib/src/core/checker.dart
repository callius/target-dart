import 'package:dartz/dartz.dart';
import 'package:source_gen/source_gen.dart';
import 'package:target/target.dart';
import 'package:target_annotation/target_annotation.dart';

const kValueObjectChecker = TypeChecker.typeNamed(
  ValueObject,
  inPackage: 'target',
);
const kValidatorChecker = TypeChecker.typeNamed(
  ValueValidator,
  inPackage: 'target',
);
const kOptionChecker = TypeChecker.typeNamed(Option, inPackage: 'dartz');
const kValidatableChecker = TypeChecker.typeNamed(
  Validatable,
  inPackage: 'target_annotation',
);
