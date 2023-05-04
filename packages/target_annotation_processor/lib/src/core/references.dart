import 'package:code_builder/code_builder.dart';
import 'package:target_annotation_processor/src/core/packages.dart';

const kOverrideRef = Reference('override');
const kDynamic = Reference('dynamic');
const kLeftRef = Reference('Left', kDartzPackage);
const kRightRef = Reference('Right', kDartzPackage);
const kFreezedRef = Reference(
  'freezed',
  'package:freezed_annotation/freezed_annotation.dart',
);
final kOptionRef = TypeReference(
  (it) => it
    ..symbol = 'Option'
    ..url = kDartzPackage,
);
final kNoneRef = TypeReference(
  (it) => it
    ..symbol = 'None'
    ..url = kDartzPackage,
);
final kSomeRef = TypeReference(
  (it) => it
    ..symbol = 'Some'
    ..url = kDartzPackage,
);

TypeReference valueFailureRef(Reference of) {
  return TypeReference(
    (it) => it
      ..symbol = 'ValueFailure'
      ..types.add(of)
      ..url = kTargetPackage,
  );
}

TypeReference buildableRef(Reference of) {
  return TypeReference(
    (it) => it
      ..symbol = 'Buildable'
      ..types.add(of)
      ..url = kTargetPackage,
  );
}

TypeReference optionRef(Reference of) {
  return (kOptionRef.toBuilder()..types.add(of)).build();
}

TypeReference eitherRef(Reference left, Reference right) {
  return TypeReference(
    (it) => it
      ..symbol = 'Either'
      ..types.addAll([left, right])
      ..url = kDartzPackage,
  );
}
