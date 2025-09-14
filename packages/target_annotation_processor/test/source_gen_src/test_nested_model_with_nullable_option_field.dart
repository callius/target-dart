import 'package:source_gen_test/source_gen_test.dart';
import 'package:target/target.dart';
import 'package:target_annotation/target_annotation.dart';

@ShouldGenerate(r'''
// Generated code. Do not modify by hand.

// ignore_for_file: require_trailing_commas, unused_element

Either<Nel<ModelFieldFailure>, Model> _$of({
  required int id,
  required Option<int?> field,
  required Either<Nel<ModelFieldFailure>, Model> parent,
}) {
  final vId = PositiveInt.of(id);
  final vField = PositiveInt.of.nullableOption(field);
  if (vId is Right<PositiveInt> &&
      vField is Right<Option<PositiveInt?>> &&
      parent is Right<Model>) {
    return Right(
      Model(id: vId.value, field: vField.value, parent: parent.value),
    );
  } else {
    return Left(
      Nel.fromListUnsafe([
        if (vId is Left<GenericValueFailure<int>>)
          ModelFieldFailureId(vId.value),
        if (vField is Left<GenericValueFailure<int>>)
          ModelFieldFailureField(vField.value),
        if (parent is Left<Nel<ModelFieldFailure>>)
          ModelFieldFailureParent(parent.value),
      ]),
    );
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
''')
@Validatable()
final class Model {
  final PositiveInt id;
  final Option<PositiveInt?> field;
  final Model parent;

  const Model({required this.id, required this.field, required this.parent});
}

final class PositiveInt extends GenericValueObject<int> {
  static const of = PositiveIntValidator(PositiveInt._);

  const PositiveInt._(super.value);
}
