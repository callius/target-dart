import 'package:target_annotation/src/add_field.dart';

/// Marks a `ModelTemplate` as having a created field. Generated as:
///
/// ```dart
/// final DateTime created;
/// ```
@AddField(name: 'created', type: DateTime)
final class HasCreated {
  const HasCreated();
}

const hasCreated = HasCreated();
