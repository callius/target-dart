import 'package:target_annotation/src/add_field.dart';

/// Marks a `ModelTemplate` as having an updated field. Generated as:
///
/// ```dart
/// final DateTime updated;
/// ```
@AddField(name: 'updated', type: DateTime)
class HasUpdated {
  const HasUpdated();
}

const hasUpdated = HasUpdated();
