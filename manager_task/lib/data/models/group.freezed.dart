// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
mixin _$Group {
  int get id => throw _privateConstructorUsedError;
  String? get namegroup => throw _privateConstructorUsedError;
  int? get adminid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res, Group>;
  @useResult
  $Res call({int id, String? namegroup, int? adminid});
}

/// @nodoc
class _$GroupCopyWithImpl<$Res, $Val extends Group>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? namegroup = freezed,
    Object? adminid = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      namegroup: freezed == namegroup
          ? _value.namegroup
          : namegroup // ignore: cast_nullable_to_non_nullable
              as String?,
      adminid: freezed == adminid
          ? _value.adminid
          : adminid // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$_GroupCopyWith(_$_Group value, $Res Function(_$_Group) then) =
      __$$_GroupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? namegroup, int? adminid});
}

/// @nodoc
class __$$_GroupCopyWithImpl<$Res> extends _$GroupCopyWithImpl<$Res, _$_Group>
    implements _$$_GroupCopyWith<$Res> {
  __$$_GroupCopyWithImpl(_$_Group _value, $Res Function(_$_Group) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? namegroup = freezed,
    Object? adminid = freezed,
  }) {
    return _then(_$_Group(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      namegroup: freezed == namegroup
          ? _value.namegroup
          : namegroup // ignore: cast_nullable_to_non_nullable
              as String?,
      adminid: freezed == adminid
          ? _value.adminid
          : adminid // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Group implements _Group {
  const _$_Group(
      {required this.id, required this.namegroup, required this.adminid});

  factory _$_Group.fromJson(Map<String, dynamic> json) =>
      _$$_GroupFromJson(json);

  @override
  final int id;
  @override
  final String? namegroup;
  @override
  final int? adminid;

  @override
  String toString() {
    return 'Group(id: $id, namegroup: $namegroup, adminid: $adminid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Group &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.namegroup, namegroup) ||
                other.namegroup == namegroup) &&
            (identical(other.adminid, adminid) || other.adminid == adminid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, namegroup, adminid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupCopyWith<_$_Group> get copyWith =>
      __$$_GroupCopyWithImpl<_$_Group>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupToJson(
      this,
    );
  }
}

abstract class _Group implements Group {
  const factory _Group(
      {required final int id,
      required final String? namegroup,
      required final int? adminid}) = _$_Group;

  factory _Group.fromJson(Map<String, dynamic> json) = _$_Group.fromJson;

  @override
  int get id;
  @override
  String? get namegroup;
  @override
  int? get adminid;
  @override
  @JsonKey(ignore: true)
  _$$_GroupCopyWith<_$_Group> get copyWith =>
      throw _privateConstructorUsedError;
}
