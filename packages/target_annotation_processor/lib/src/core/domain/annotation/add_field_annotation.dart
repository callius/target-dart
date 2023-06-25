import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';

final class AddFieldAnnotation {
  final String name;
  final DartType type;
  final bool ignore;

  const AddFieldAnnotation({
    required this.name,
    required this.type,
    required this.ignore,
  });

  factory AddFieldAnnotation.ofObject(DartObject object) {
    return AddFieldAnnotation(
      name: object.getField('name')!.toStringValue()!,
      type: object.getField('type')!.toTypeValue()!,
      ignore: object.getField('ignore')!.toBoolValue()!,
    );
  }
}
