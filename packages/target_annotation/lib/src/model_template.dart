/// Marks an interface as a model template.
class ModelTemplate {
  /// The base class name of the generated model from which the builder/params will be generated.
  final String name;

  const ModelTemplate(this.name);
}
