// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupTask _$GroupTaskFromJson(Map<String, dynamic> json) {
  return _GroupTask.fromJson(json);
}

/// @nodoc
mixin _$GroupTask {
  int get id => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get dateTask => throw _privateConstructorUsedError;
  String get completedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupTaskCopyWith<GroupTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupTaskCopyWith<$Res> {
  factory $GroupTaskCopyWith(GroupTask value, $Res Function(GroupTask) then) =
      _$GroupTaskCopyWithImpl<$Res, GroupTask>;
  @useResult
  $Res call(
      {int id, String? description, DateTime? dateTask, String completedBy});
}

/// @nodoc
class _$GroupTaskCopyWithImpl<$Res, $Val extends GroupTask>
    implements $GroupTaskCopyWith<$Res> {
  _$GroupTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = freezed,
    Object? dateTask = freezed,
    Object? completedBy = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTask: freezed == dateTask
          ? _value.dateTask
          : dateTask // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedBy: null == completedBy
          ? _value.completedBy
          : completedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupTaskCopyWith<$Res> implements $GroupTaskCopyWith<$Res> {
  factory _$$_GroupTaskCopyWith(
          _$_GroupTask value, $Res Function(_$_GroupTask) then) =
      __$$_GroupTaskCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, String? description, DateTime? dateTask, String completedBy});
}

/// @nodoc
class __$$_GroupTaskCopyWithImpl<$Res>
    extends _$GroupTaskCopyWithImpl<$Res, _$_GroupTask>
    implements _$$_GroupTaskCopyWith<$Res> {
  __$$_GroupTaskCopyWithImpl(
      _$_GroupTask _value, $Res Function(_$_GroupTask) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = freezed,
    Object? dateTask = freezed,
    Object? completedBy = null,
  }) {
    return _then(_$_GroupTask(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTask: freezed == dateTask
          ? _value.dateTask
          : dateTask // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedBy: null == completedBy
          ? _value.completedBy
          : completedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupTask implements _GroupTask {
  const _$_GroupTask(
      {required this.id,
      required this.description,
      required this.dateTask,
      required this.completedBy});

  factory _$_GroupTask.fromJson(Map<String, dynamic> json) =>
      _$$_GroupTaskFromJson(json);

  @override
  final int id;
  @override
  final String? description;
  @override
  final DateTime? dateTask;
  @override
  final String completedBy;

  @override
  String toString() {
    return 'GroupTask(id: $id, description: $description, dateTask: $dateTask, completedBy: $completedBy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupTask &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dateTask, dateTask) ||
                other.dateTask == dateTask) &&
            (identical(other.completedBy, completedBy) ||
                other.completedBy == completedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, description, dateTask, completedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupTaskCopyWith<_$_GroupTask> get copyWith =>
      __$$_GroupTaskCopyWithImpl<_$_GroupTask>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupTaskToJson(
      this,
    );
  }
}

abstract class _GroupTask implements GroupTask {
  const factory _GroupTask(
      {required final int id,
      required final String? description,
      required final DateTime? dateTask,
      required final String completedBy}) = _$_GroupTask;

  factory _GroupTask.fromJson(Map<String, dynamic> json) =
      _$_GroupTask.fromJson;

  @override
  int get id;
  @override
  String? get description;
  @override
  DateTime? get dateTask;
  @override
  String get completedBy;
  @override
  @JsonKey(ignore: true)
  _$$_GroupTaskCopyWith<_$_GroupTask> get copyWith =>
      throw _privateConstructorUsedError;
}
