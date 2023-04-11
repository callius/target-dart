/// Marks a field as external, and will not be present on the params/builder.
class External {
  const External();
}

/// Named this way, because `external` is a keyword in Dart.
const extern = External();
