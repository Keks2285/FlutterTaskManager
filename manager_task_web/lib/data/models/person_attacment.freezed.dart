// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'person_attacment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PersonAtachment _$PersonAtachmentFromJson(Map<String, dynamic> json) {
  return _PersonAtachment.fromJson(json);
}

/// @nodoc
mixin _$PersonAtachment {
  String? get filename => throw _privateConstructorUsedError;
  String get extension => throw _privateConstructorUsedError;
  String get size => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PersonAtachmentCopyWith<PersonAtachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonAtachmentCopyWith<$Res> {
  factory $PersonAtachmentCopyWith(
          PersonAtachment value, $Res Function(PersonAtachment) then) =
      _$PersonAtachmentCopyWithImpl<$Res, PersonAtachment>;
  @useResult
  $Res call({String? filename, String extension, String size});
}

/// @nodoc
class _$PersonAtachmentCopyWithImpl<$Res, $Val extends PersonAtachment>
    implements $PersonAtachmentCopyWith<$Res> {
  _$PersonAtachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = freezed,
    Object? extension = null,
    Object? size = null,
  }) {
    return _then(_value.copyWith(
      filename: freezed == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      extension: null == extension
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PersonAtachmentCopyWith<$Res>
    implements $PersonAtachmentCopyWith<$Res> {
  factory _$$_PersonAtachmentCopyWith(
          _$_PersonAtachment value, $Res Function(_$_PersonAtachment) then) =
      __$$_PersonAtachmentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? filename, String extension, String size});
}

/// @nodoc
class __$$_PersonAtachmentCopyWithImpl<$Res>
    extends _$PersonAtachmentCopyWithImpl<$Res, _$_PersonAtachment>
    implements _$$_PersonAtachmentCopyWith<$Res> {
  __$$_PersonAtachmentCopyWithImpl(
      _$_PersonAtachment _value, $Res Function(_$_PersonAtachment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = freezed,
    Object? extension = null,
    Object? size = null,
  }) {
    return _then(_$_PersonAtachment(
      filename: freezed == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      extension: null == extension
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PersonAtachment implements _PersonAtachment {
  const _$_PersonAtachment(
      {required this.filename, required this.extension, required this.size});

  factory _$_PersonAtachment.fromJson(Map<String, dynamic> json) =>
      _$$_PersonAtachmentFromJson(json);

  @override
  final String? filename;
  @override
  final String extension;
  @override
  final String size;

  @override
  String toString() {
    return 'PersonAtachment(filename: $filename, extension: $extension, size: $size)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PersonAtachment &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.extension, extension) ||
                other.extension == extension) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, filename, extension, size);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PersonAtachmentCopyWith<_$_PersonAtachment> get copyWith =>
      __$$_PersonAtachmentCopyWithImpl<_$_PersonAtachment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PersonAtachmentToJson(
      this,
    );
  }
}

abstract class _PersonAtachment implements PersonAtachment {
  const factory _PersonAtachment(
      {required final String? filename,
      required final String extension,
      required final String size}) = _$_PersonAtachment;

  factory _PersonAtachment.fromJson(Map<String, dynamic> json) =
      _$_PersonAtachment.fromJson;

  @override
  String? get filename;
  @override
  String get extension;
  @override
  String get size;
  @override
  @JsonKey(ignore: true)
  _$$_PersonAtachmentCopyWith<_$_PersonAtachment> get copyWith =>
      throw _privateConstructorUsedError;
}
