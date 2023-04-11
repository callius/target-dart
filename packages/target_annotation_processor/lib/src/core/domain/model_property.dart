import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:target_annotation_processor/src/core/domain/model_property_type.dart';

part 'model_property.freezed.dart';

@freezed
class ModelProperty with _$ModelProperty {
  factory ModelProperty({
    required String name,
    required ModelPropertyType type,
    required bool isExternal,
  }) {
    return ModelProperty.__(
      name: name,
      vName: 'v${name.substring(0, 1).toUpperCase()}${name.substring(1)}',
      type: type,
      isExternal: isExternal,
    );
  }

  const factory ModelProperty.__({
    required String name,
    required String vName,
    required ModelPropertyType type,
    required bool isExternal,
  }) = _ModelProperty;

  const ModelProperty._();

  bool get isNotExternal => !isExternal;
}
