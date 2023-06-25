import 'package:target_annotation/src/has_created.dart';
import 'package:target_annotation/src/has_updated.dart';

/// Aggregate for [HasCreated] and [HasUpdated].
@hasCreated
@hasUpdated
final class HasCreatedAndUpdated {
  const HasCreatedAndUpdated();
}

const hasCreatedAndUpdated = HasCreatedAndUpdated();
