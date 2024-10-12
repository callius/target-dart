import 'package:equatable/equatable.dart';
import 'package:target_annotation_processor/src/core/domain/model_property_type.dart';

final class ModelProperty extends Equatable {
  final String name;
  final String vName;
  final ModelPropertyType type;

  factory ModelProperty({
    required String name,
    required ModelPropertyType type,
  }) {
    return ModelProperty._(
      name: name,
      vName: 'v${name.substring(0, 1).toUpperCase()}${name.substring(1)}',
      type: type,
    );
  }

  const ModelProperty._({
    required this.name,
    required this.vName,
    required this.type,
  });

  ModelProperty copyWith({required ModelPropertyType type}) {
    return ModelProperty._(
      name: name,
      vName: vName,
      type: type,
    );
  }

  @override
  List<Object> get props => [name, vName, type];
}
