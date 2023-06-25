import 'package:analyzer/dart/constant/value.dart';
import 'package:source_gen/source_gen.dart';

final class ModelTemplateAnnotation {
  final String name;

  const ModelTemplateAnnotation({required this.name});

  factory ModelTemplateAnnotation.ofReader(ConstantReader reader) {
    return ModelTemplateAnnotation(
      name: reader.read('name').stringValue,
    );
  }

  factory ModelTemplateAnnotation.ofObject(DartObject object) {
    return ModelTemplateAnnotation(
      name: object.getField('name')!.toStringValue()!,
    );
  }
}
