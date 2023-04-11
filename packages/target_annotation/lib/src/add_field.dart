/// Defines a field to add to the generated classes. By default, it only adds the field to the
/// generated model class.
///
/// This annotation can be used to compose multiple fields, like so:
///
/// ```dart
/// @HasUpdated()
/// @AddField("updatedBy", PositiveLong, ignore = false)
/// class Updatable {
///   const Updatable();
/// }
///
/// @Updatable()
/// @ModelTemplate("Record")
/// abstract class RecordModel {
///  RecordInformation get information;
/// }
/// ```
///
/// This example generates a model class with the [AddField] annotations defined by both the `HasUpdated` and the newly
/// defined `Updatable` annotations:
///
/// ```dart
/// final DateTime updated;
/// final PositiveLong updatedBy;
/// ```
class AddField {
  /// The name of the generated field.
  final String name;

  /// The type of the generated field.
  final Type type;

  /// If `true`, this field will only be added to the generated model class.
  final bool ignore;

  const AddField({required this.name, required this.type, this.ignore = true});
}
