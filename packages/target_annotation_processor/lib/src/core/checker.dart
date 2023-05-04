import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:target/target.dart';
import 'package:target_annotation/target_annotation.dart';

const kValueObjectChecker = TypeChecker.fromRuntime(ValueObject);
const kValidatorChecker = TypeChecker.fromRuntime(ValueValidator);
const kFreezedChecker = TypeChecker.fromRuntime(Freezed);
const kOptionChecker = TypeChecker.fromRuntime(Option);
const kBuildableChecker = TypeChecker.fromRuntime(Buildable);
const kExternalTypeChecker = TypeChecker.fromRuntime(External);
const kModelTemplateChecker = TypeChecker.fromRuntime(ModelTemplate);
const kAddFieldChecker = TypeChecker.fromRuntime(AddField);
