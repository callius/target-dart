import 'package:source_gen_test/source_gen_test.dart';
import 'package:target/target.dart';
import 'package:target_annotation/target_annotation.dart';

@ShouldGenerate(
  r'''
// Generated code. Do not modify by hand.

// ignore_for_file: require_trailing_commas, unused_element

Either<Nel<ModelFieldFailure>, Model> _$of({
  required int id,
  required int field,
  required Either<Nel<ModelFieldFailure>, Model>? parent,
}) {
  final vId = PositiveInt.of(id);
  final vField = PositiveInt.of(field);
  final Either<Nel<ModelFieldFailure>, Model?> vParent =
      parent ?? const Right(null);
  if (vId is Right<GenericValueFailure<int>, PositiveInt> &&
      vField is Right<GenericValueFailure<int>, PositiveInt> &&
      vParent is Right<Nel<ModelFieldFailure>, Model?>) {
    return Right(Model(
      id: vId.value,
      field: vField.value,
      parent: vParent.value,
    ));
  } else {
    return Left(Nel.fromListUnsafe([
      if (vId is Left<GenericValueFailure<int>, PositiveInt>)
        ModelFieldFailureId(vId.value),
      if (vField is Left<GenericValueFailure<int>, PositiveInt>)
        ModelFieldFailureField(vField.value),
      if (vParent is Left<Nel<ModelFieldFailure>, Model?>)
        ModelFieldFailureParent(vParent.value),
    ]));
  }
}

sealed class ModelFieldFailure<T> extends Equatable {
  const ModelFieldFailure(this.parent);

  final T parent;

  @override
  List<Object?> get props => [parent];
}

final class ModelFieldFailureId
    extends ModelFieldFailure<GenericValueFailure<int>> {
  const ModelFieldFailureId(super.parent);
}

final class ModelFieldFailureField
    extends ModelFieldFailure<GenericValueFailure<int>> {
  const ModelFieldFailureField(super.parent);
}

final class ModelFieldFailureParent
    extends ModelFieldFailure<Nel<ModelFieldFailure>> {
  const ModelFieldFailureParent(super.parent);
}
''',
)
@Validatable()
final class Model {
  final PositiveInt id;
  final PositiveInt field;
  final Model? parent;

  const Model({required this.id, required this.field, required this.parent});
}
