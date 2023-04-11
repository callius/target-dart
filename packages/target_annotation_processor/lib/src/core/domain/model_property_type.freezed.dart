// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'model_property_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ModelPropertyType {
  TypeReference get type => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TypeReference type, TypeReference valueObjectType)
        valueObject,
    required TResult Function(
            TypeReference type, List<ModelPropertyType> typeArguments)
        standard,
    required TResult Function(TypeReference type) modelTemplate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TypeReference type, TypeReference valueObjectType)?
        valueObject,
    TResult Function(TypeReference type, List<ModelPropertyType> typeArguments)?
        standard,
    TResult Function(TypeReference type)? modelTemplate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TypeReference type, TypeReference valueObjectType)?
        valueObject,
    TResult Function(TypeReference type, List<ModelPropertyType> typeArguments)?
        standard,
    TResult Function(TypeReference type)? modelTemplate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueObjectModelPropertyType value) valueObject,
    required TResult Function(StandardModelPropertyType value) standard,
    required TResult Function(ModelTemplateModelPropertyType value)
        modelTemplate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ValueObjectModelPropertyType value)? valueObject,
    TResult Function(StandardModelPropertyType value)? standard,
    TResult Function(ModelTemplateModelPropertyType value)? modelTemplate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueObjectModelPropertyType value)? valueObject,
    TResult Function(StandardModelPropertyType value)? standard,
    TResult Function(ModelTemplateModelPropertyType value)? modelTemplate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModelPropertyTypeCopyWith<ModelPropertyType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelPropertyTypeCopyWith<$Res> {
  factory $ModelPropertyTypeCopyWith(
          ModelPropertyType value, $Res Function(ModelPropertyType) then) =
      _$ModelPropertyTypeCopyWithImpl<$Res>;
  $Res call({TypeReference type});
}

/// @nodoc
class _$ModelPropertyTypeCopyWithImpl<$Res>
    implements $ModelPropertyTypeCopyWith<$Res> {
  _$ModelPropertyTypeCopyWithImpl(this._value, this._then);

  final ModelPropertyType _value;
  // ignore: unused_field
  final $Res Function(ModelPropertyType) _then;

  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TypeReference,
    ));
  }
}

/// @nodoc
abstract class _$$ValueObjectModelPropertyTypeCopyWith<$Res>
    implements $ModelPropertyTypeCopyWith<$Res> {
  factory _$$ValueObjectModelPropertyTypeCopyWith(
          _$ValueObjectModelPropertyType value,
          $Res Function(_$ValueObjectModelPropertyType) then) =
      __$$ValueObjectModelPropertyTypeCopyWithImpl<$Res>;
  @override
  $Res call({TypeReference type, TypeReference valueObjectType});
}

/// @nodoc
class __$$ValueObjectModelPropertyTypeCopyWithImpl<$Res>
    extends _$ModelPropertyTypeCopyWithImpl<$Res>
    implements _$$ValueObjectModelPropertyTypeCopyWith<$Res> {
  __$$ValueObjectModelPropertyTypeCopyWithImpl(
      _$ValueObjectModelPropertyType _value,
      $Res Function(_$ValueObjectModelPropertyType) _then)
      : super(_value, (v) => _then(v as _$ValueObjectModelPropertyType));

  @override
  _$ValueObjectModelPropertyType get _value =>
      super._value as _$ValueObjectModelPropertyType;

  @override
  $Res call({
    Object? type = freezed,
    Object? valueObjectType = freezed,
  }) {
    return _then(_$ValueObjectModelPropertyType(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TypeReference,
      valueObjectType: valueObjectType == freezed
          ? _value.valueObjectType
          : valueObjectType // ignore: cast_nullable_to_non_nullable
              as TypeReference,
    ));
  }
}

/// @nodoc

class _$ValueObjectModelPropertyType extends ValueObjectModelPropertyType {
  const _$ValueObjectModelPropertyType(
      {required this.type, required this.valueObjectType})
      : super._();

  @override
  final TypeReference type;
  @override
  final TypeReference valueObjectType;

  @override
  String toString() {
    return 'ModelPropertyType.valueObject(type: $type, valueObjectType: $valueObjectType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValueObjectModelPropertyType &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.valueObjectType, valueObjectType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(valueObjectType));

  @JsonKey(ignore: true)
  @override
  _$$ValueObjectModelPropertyTypeCopyWith<_$ValueObjectModelPropertyType>
      get copyWith => __$$ValueObjectModelPropertyTypeCopyWithImpl<
          _$ValueObjectModelPropertyType>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TypeReference type, TypeReference valueObjectType)
        valueObject,
    required TResult Function(
            TypeReference type, List<ModelPropertyType> typeArguments)
        standard,
    required TResult Function(TypeReference type) modelTemplate,
  }) {
    return valueObject(type, valueObjectType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TypeReference type, TypeReference valueObjectType)?
        valueObject,
    TResult Function(TypeReference type, List<ModelPropertyType> typeArguments)?
        standard,
    TResult Function(TypeReference type)? modelTemplate,
  }) {
    return valueObject?.call(type, valueObjectType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TypeReference type, TypeReference valueObjectType)?
        valueObject,
    TResult Function(TypeReference type, List<ModelPropertyType> typeArguments)?
        standard,
    TResult Function(TypeReference type)? modelTemplate,
    required TResult orElse(),
  }) {
    if (valueObject != null) {
      return valueObject(type, valueObjectType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueObjectModelPropertyType value) valueObject,
    required TResult Function(StandardModelPropertyType value) standard,
    required TResult Function(ModelTemplateModelPropertyType value)
        modelTemplate,
  }) {
    return valueObject(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ValueObjectModelPropertyType value)? valueObject,
    TResult Function(StandardModelPropertyType value)? standard,
    TResult Function(ModelTemplateModelPropertyType value)? modelTemplate,
  }) {
    return valueObject?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueObjectModelPropertyType value)? valueObject,
    TResult Function(StandardModelPropertyType value)? standard,
    TResult Function(ModelTemplateModelPropertyType value)? modelTemplate,
    required TResult orElse(),
  }) {
    if (valueObject != null) {
      return valueObject(this);
    }
    return orElse();
  }
}

abstract class ValueObjectModelPropertyType extends ModelPropertyType {
  const factory ValueObjectModelPropertyType(
          {required final TypeReference type,
          required final TypeReference valueObjectType}) =
      _$ValueObjectModelPropertyType;
  const ValueObjectModelPropertyType._() : super._();

  @override
  TypeReference get type;
  TypeReference get valueObjectType;
  @override
  @JsonKey(ignore: true)
  _$$ValueObjectModelPropertyTypeCopyWith<_$ValueObjectModelPropertyType>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StandardModelPropertyTypeCopyWith<$Res>
    implements $ModelPropertyTypeCopyWith<$Res> {
  factory _$$StandardModelPropertyTypeCopyWith(
          _$StandardModelPropertyType value,
          $Res Function(_$StandardModelPropertyType) then) =
      __$$StandardModelPropertyTypeCopyWithImpl<$Res>;
  @override
  $Res call({TypeReference type, List<ModelPropertyType> typeArguments});
}

/// @nodoc
class __$$StandardModelPropertyTypeCopyWithImpl<$Res>
    extends _$ModelPropertyTypeCopyWithImpl<$Res>
    implements _$$StandardModelPropertyTypeCopyWith<$Res> {
  __$$StandardModelPropertyTypeCopyWithImpl(_$StandardModelPropertyType _value,
      $Res Function(_$StandardModelPropertyType) _then)
      : super(_value, (v) => _then(v as _$StandardModelPropertyType));

  @override
  _$StandardModelPropertyType get _value =>
      super._value as _$StandardModelPropertyType;

  @override
  $Res call({
    Object? type = freezed,
    Object? typeArguments = freezed,
  }) {
    return _then(_$StandardModelPropertyType(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TypeReference,
      typeArguments: typeArguments == freezed
          ? _value._typeArguments
          : typeArguments // ignore: cast_nullable_to_non_nullable
              as List<ModelPropertyType>,
    ));
  }
}

/// @nodoc

class _$StandardModelPropertyType extends StandardModelPropertyType {
  const _$StandardModelPropertyType(
      {required this.type,
      required final List<ModelPropertyType> typeArguments})
      : _typeArguments = typeArguments,
        super._();

  @override
  final TypeReference type;
  final List<ModelPropertyType> _typeArguments;
  @override
  List<ModelPropertyType> get typeArguments {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeArguments);
  }

  @override
  String toString() {
    return 'ModelPropertyType.standard(type: $type, typeArguments: $typeArguments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StandardModelPropertyType &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other._typeArguments, _typeArguments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(_typeArguments));

  @JsonKey(ignore: true)
  @override
  _$$StandardModelPropertyTypeCopyWith<_$StandardModelPropertyType>
      get copyWith => __$$StandardModelPropertyTypeCopyWithImpl<
          _$StandardModelPropertyType>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TypeReference type, TypeReference valueObjectType)
        valueObject,
    required TResult Function(
            TypeReference type, List<ModelPropertyType> typeArguments)
        standard,
    required TResult Function(TypeReference type) modelTemplate,
  }) {
    return standard(type, typeArguments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TypeReference type, TypeReference valueObjectType)?
        valueObject,
    TResult Function(TypeReference type, List<ModelPropertyType> typeArguments)?
        standard,
    TResult Function(TypeReference type)? modelTemplate,
  }) {
    return standard?.call(type, typeArguments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TypeReference type, TypeReference valueObjectType)?
        valueObject,
    TResult Function(TypeReference type, List<ModelPropertyType> typeArguments)?
        standard,
    TResult Function(TypeReference type)? modelTemplate,
    required TResult orElse(),
  }) {
    if (standard != null) {
      return standard(type, typeArguments);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueObjectModelPropertyType value) valueObject,
    required TResult Function(StandardModelPropertyType value) standard,
    required TResult Function(ModelTemplateModelPropertyType value)
        modelTemplate,
  }) {
    return standard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ValueObjectModelPropertyType value)? valueObject,
    TResult Function(StandardModelPropertyType value)? standard,
    TResult Function(ModelTemplateModelPropertyType value)? modelTemplate,
  }) {
    return standard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueObjectModelPropertyType value)? valueObject,
    TResult Function(StandardModelPropertyType value)? standard,
    TResult Function(ModelTemplateModelPropertyType value)? modelTemplate,
    required TResult orElse(),
  }) {
    if (standard != null) {
      return standard(this);
    }
    return orElse();
  }
}

abstract class StandardModelPropertyType extends ModelPropertyType {
  const factory StandardModelPropertyType(
          {required final TypeReference type,
          required final List<ModelPropertyType> typeArguments}) =
      _$StandardModelPropertyType;
  const StandardModelPropertyType._() : super._();

  @override
  TypeReference get type;
  List<ModelPropertyType> get typeArguments;
  @override
  @JsonKey(ignore: true)
  _$$StandardModelPropertyTypeCopyWith<_$StandardModelPropertyType>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ModelTemplateModelPropertyTypeCopyWith<$Res>
    implements $ModelPropertyTypeCopyWith<$Res> {
  factory _$$ModelTemplateModelPropertyTypeCopyWith(
          _$ModelTemplateModelPropertyType value,
          $Res Function(_$ModelTemplateModelPropertyType) then) =
      __$$ModelTemplateModelPropertyTypeCopyWithImpl<$Res>;
  @override
  $Res call({TypeReference type});
}

/// @nodoc
class __$$ModelTemplateModelPropertyTypeCopyWithImpl<$Res>
    extends _$ModelPropertyTypeCopyWithImpl<$Res>
    implements _$$ModelTemplateModelPropertyTypeCopyWith<$Res> {
  __$$ModelTemplateModelPropertyTypeCopyWithImpl(
      _$ModelTemplateModelPropertyType _value,
      $Res Function(_$ModelTemplateModelPropertyType) _then)
      : super(_value, (v) => _then(v as _$ModelTemplateModelPropertyType));

  @override
  _$ModelTemplateModelPropertyType get _value =>
      super._value as _$ModelTemplateModelPropertyType;

  @override
  $Res call({
    Object? type = freezed,
  }) {
    return _then(_$ModelTemplateModelPropertyType(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TypeReference,
    ));
  }
}

/// @nodoc

class _$ModelTemplateModelPropertyType extends ModelTemplateModelPropertyType {
  const _$ModelTemplateModelPropertyType({required this.type}) : super._();

  @override
  final TypeReference type;

  @override
  String toString() {
    return 'ModelPropertyType.modelTemplate(type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelTemplateModelPropertyType &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$$ModelTemplateModelPropertyTypeCopyWith<_$ModelTemplateModelPropertyType>
      get copyWith => __$$ModelTemplateModelPropertyTypeCopyWithImpl<
          _$ModelTemplateModelPropertyType>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TypeReference type, TypeReference valueObjectType)
        valueObject,
    required TResult Function(
            TypeReference type, List<ModelPropertyType> typeArguments)
        standard,
    required TResult Function(TypeReference type) modelTemplate,
  }) {
    return modelTemplate(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TypeReference type, TypeReference valueObjectType)?
        valueObject,
    TResult Function(TypeReference type, List<ModelPropertyType> typeArguments)?
        standard,
    TResult Function(TypeReference type)? modelTemplate,
  }) {
    return modelTemplate?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TypeReference type, TypeReference valueObjectType)?
        valueObject,
    TResult Function(TypeReference type, List<ModelPropertyType> typeArguments)?
        standard,
    TResult Function(TypeReference type)? modelTemplate,
    required TResult orElse(),
  }) {
    if (modelTemplate != null) {
      return modelTemplate(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValueObjectModelPropertyType value) valueObject,
    required TResult Function(StandardModelPropertyType value) standard,
    required TResult Function(ModelTemplateModelPropertyType value)
        modelTemplate,
  }) {
    return modelTemplate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ValueObjectModelPropertyType value)? valueObject,
    TResult Function(StandardModelPropertyType value)? standard,
    TResult Function(ModelTemplateModelPropertyType value)? modelTemplate,
  }) {
    return modelTemplate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValueObjectModelPropertyType value)? valueObject,
    TResult Function(StandardModelPropertyType value)? standard,
    TResult Function(ModelTemplateModelPropertyType value)? modelTemplate,
    required TResult orElse(),
  }) {
    if (modelTemplate != null) {
      return modelTemplate(this);
    }
    return orElse();
  }
}

abstract class ModelTemplateModelPropertyType extends ModelPropertyType {
  const factory ModelTemplateModelPropertyType(
      {required final TypeReference type}) = _$ModelTemplateModelPropertyType;
  const ModelTemplateModelPropertyType._() : super._();

  @override
  TypeReference get type;
  @override
  @JsonKey(ignore: true)
  _$$ModelTemplateModelPropertyTypeCopyWith<_$ModelTemplateModelPropertyType>
      get copyWith => throw _privateConstructorUsedError;
}
