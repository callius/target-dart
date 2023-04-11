// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'model_property.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ModelProperty {
  String get name => throw _privateConstructorUsedError;
  String get vName => throw _privateConstructorUsedError;
  ModelPropertyType get type => throw _privateConstructorUsedError;
  bool get isExternal => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModelPropertyCopyWith<ModelProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelPropertyCopyWith<$Res> {
  factory $ModelPropertyCopyWith(
          ModelProperty value, $Res Function(ModelProperty) then) =
      _$ModelPropertyCopyWithImpl<$Res>;
  $Res call(
      {String name, String vName, ModelPropertyType type, bool isExternal});

  $ModelPropertyTypeCopyWith<$Res> get type;
}

/// @nodoc
class _$ModelPropertyCopyWithImpl<$Res>
    implements $ModelPropertyCopyWith<$Res> {
  _$ModelPropertyCopyWithImpl(this._value, this._then);

  final ModelProperty _value;
  // ignore: unused_field
  final $Res Function(ModelProperty) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? vName = freezed,
    Object? type = freezed,
    Object? isExternal = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      vName: vName == freezed
          ? _value.vName
          : vName // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ModelPropertyType,
      isExternal: isExternal == freezed
          ? _value.isExternal
          : isExternal // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $ModelPropertyTypeCopyWith<$Res> get type {
    return $ModelPropertyTypeCopyWith<$Res>(_value.type, (value) {
      return _then(_value.copyWith(type: value));
    });
  }
}

/// @nodoc
abstract class _$$_ModelPropertyCopyWith<$Res>
    implements $ModelPropertyCopyWith<$Res> {
  factory _$$_ModelPropertyCopyWith(
          _$_ModelProperty value, $Res Function(_$_ModelProperty) then) =
      __$$_ModelPropertyCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name, String vName, ModelPropertyType type, bool isExternal});

  @override
  $ModelPropertyTypeCopyWith<$Res> get type;
}

/// @nodoc
class __$$_ModelPropertyCopyWithImpl<$Res>
    extends _$ModelPropertyCopyWithImpl<$Res>
    implements _$$_ModelPropertyCopyWith<$Res> {
  __$$_ModelPropertyCopyWithImpl(
      _$_ModelProperty _value, $Res Function(_$_ModelProperty) _then)
      : super(_value, (v) => _then(v as _$_ModelProperty));

  @override
  _$_ModelProperty get _value => super._value as _$_ModelProperty;

  @override
  $Res call({
    Object? name = freezed,
    Object? vName = freezed,
    Object? type = freezed,
    Object? isExternal = freezed,
  }) {
    return _then(_$_ModelProperty(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      vName: vName == freezed
          ? _value.vName
          : vName // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ModelPropertyType,
      isExternal: isExternal == freezed
          ? _value.isExternal
          : isExternal // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ModelProperty extends _ModelProperty {
  const _$_ModelProperty(
      {required this.name,
      required this.vName,
      required this.type,
      required this.isExternal})
      : super._();

  @override
  final String name;
  @override
  final String vName;
  @override
  final ModelPropertyType type;
  @override
  final bool isExternal;

  @override
  String toString() {
    return 'ModelProperty.__(name: $name, vName: $vName, type: $type, isExternal: $isExternal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ModelProperty &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.vName, vName) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.isExternal, isExternal));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(vName),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(isExternal));

  @JsonKey(ignore: true)
  @override
  _$$_ModelPropertyCopyWith<_$_ModelProperty> get copyWith =>
      __$$_ModelPropertyCopyWithImpl<_$_ModelProperty>(this, _$identity);
}

abstract class _ModelProperty extends ModelProperty {
  const factory _ModelProperty(
      {required final String name,
      required final String vName,
      required final ModelPropertyType type,
      required final bool isExternal}) = _$_ModelProperty;
  const _ModelProperty._() : super._();

  @override
  String get name;
  @override
  String get vName;
  @override
  ModelPropertyType get type;
  @override
  bool get isExternal;
  @override
  @JsonKey(ignore: true)
  _$$_ModelPropertyCopyWith<_$_ModelProperty> get copyWith =>
      throw _privateConstructorUsedError;
}
