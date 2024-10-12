/// Marks a model as being validatable: containing one or more value object
/// fields.
///
/// Generates a  function, named `_of`, and failure classes representing
/// validation failures.
///
/// ```dart
/// @freezed
/// class Model with _$Model {
///   const factory Model({
///     required Field1 field1,
///   }) = _Model;
///
///   static const of = _of;
/// }
///
/// Either<Nel<ModelFieldFailure>, Model> _of({
///   required RawField1 field1,
/// }) {
///   final vField1 = Field1.of(field1);
///   if (vField1 is Right<Field1Failure, Field1>) {
///     return Model(
///       field1: vField1.value,
///     ).right();
///   } else {
///     return Nel.fromListUnsafe([
///       if (vField1 is Left<Field1Failure, Field1>)
///         ModelFieldFailureField1(vField1.value),
///     ]).left();
///   }
/// }
///
/// sealed class ModelFieldFailure<T> extends Equatable {
///   final T parent;
///
///   const ModelFieldFailure(this.parent);
///
///   @override
///   List<Object?> get props => [parent];
/// }
///
/// final class ModelFieldFailureField1
///   extends ModelFieldFailure<Field1Failure> {
///   const ModelFieldFailureField1(super.parent);
/// }
/// ```
final class Validatable {
  const Validatable();
}
