import 'package:equatable/equatable.dart';
import 'package:target_annotation_processor/src/core/domain/model_property_type.dart';

final class ModelProperty extends Equatable {
  final String name;
  final String vName;
  final ModelPropertyType type;
  final bool isExternal;

  factory ModelProperty({
    required String name,
    required ModelPropertyType type,
    required bool isExternal,
  }) {
    return ModelProperty._(
      name: name,
      vName: 'v${name.substring(0, 1).toUpperCase()}${name.substring(1)}',
      type: type,
      isExternal: isExternal,
    );
  }

  ModelProperty._({
    required this.name,
    required this.vName,
    required this.type,
    required this.isExternal,
  });

  bool get isNotExternal => !isExternal;

  ModelProperty copyWith({required ModelPropertyType type}) {
    return ModelProperty._(
      name: name,
      vName: vName,
      type: type,
      isExternal: isExternal,
    );
  }

  @override
  List<Object> get props => [name, vName, type, isExternal];
}
