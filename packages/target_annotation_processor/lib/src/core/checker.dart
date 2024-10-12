import 'package:dartz/dartz.dart';
import 'package:source_gen/source_gen.dart';
import 'package:target/target.dart';
import 'package:target_annotation/target_annotation.dart';

const kValueObjectChecker = TypeChecker.fromRuntime(ValueObject);
const kValidatorChecker = TypeChecker.fromRuntime(ValueValidator);
const kOptionChecker = TypeChecker.fromRuntime(Option);
const kValidatableChecker = TypeChecker.fromRuntime(Validatable);
