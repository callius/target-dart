import 'package:code_builder/code_builder.dart';
import 'package:target_annotation_processor/src/core/packages.dart';

const kOverrideRef = Reference('override');

const kDynamic = Reference('dynamic');

final kObjectRef = TypeReference(
  (it) => it..symbol = 'Object',
);

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

final kNelRef = TypeReference(
  (it) => it
    ..symbol = 'Nel'
    ..url = kTargetPackage,
);

final kEquatableRef = TypeReference(
  (it) => it
    ..symbol = 'Equatable'
    ..url = kEquatablePackage,
);

TypeReference listRef(Reference of) {
  return TypeReference(
    (it) => it
      ..symbol = 'List'
      ..types.add(of),
  );
}

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

TypeReference nelRef(Reference of) {
  return TypeReference(
    (it) => it
      ..symbol = 'Nel'
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

TypeReference rightRef(Reference left, Reference right) {
  return TypeReference(
    (it) => it
      ..symbol = 'Right'
      ..types.addAll([left, right])
      ..url = kDartzPackage,
  );
}

TypeReference leftRef(Reference left, Reference right) {
  return TypeReference(
    (it) => it
      ..symbol = 'Left'
      ..types.addAll([left, right])
      ..url = kDartzPackage,
  );
}
