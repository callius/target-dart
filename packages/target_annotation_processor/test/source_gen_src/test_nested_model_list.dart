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
  required List<Either<Nel<ModelFieldFailure>, Model>> parents,
}) {
  final vId = PositiveInt.of(id);
  final vField = PositiveInt.of(field);
  final vParents = parents.validate();
  if (vId is Right<GenericValueFailure<int>, PositiveInt> &&
      vField is Right<GenericValueFailure<int>, PositiveInt> &&
      vParents is Right<Nel<Nel<ModelFieldFailure>>, List<Model>>) {
    return Right(Model(
      id: vId.value,
      field: vField.value,
      parent: vParents.value,
    ));
  } else {
    return Left(Nel.fromListUnsafe([
      if (vId is Left<GenericValueFailure<int>, PositiveInt>)
        ModelFieldFailureId(vId.value),
      if (vField is Left<GenericValueFailure<int>, PositiveInt>)
        ModelFieldFailureField(vField.value),
      if (vParents is Left<Nel<Nel<ModelFieldFailure>>, List<Model>>)
        ModelFieldFailureParent(vParents.value),
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

final class ModelFieldFailureParents
    extends ModelFieldFailure<Nel<Nel<ModelFieldFailure>>> {
  const ModelFieldFailureParents(super.parent);
}
''',
)
@validatable
final class Model {
  final PositiveInt id;
  final PositiveInt field;
  final List<Model> parents;

  const Model({
    required this.id,
    required this.field,
    required this.parents,
  });
}
