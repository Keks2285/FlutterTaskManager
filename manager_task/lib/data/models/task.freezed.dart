// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ToDoTask _$ToDoTaskFromJson(Map<String, dynamic> json) {
  return _ToDoTask.fromJson(json);
}

/// @nodoc
mixin _$ToDoTask {
  int get id => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get tag => throw _privateConstructorUsedError;
  DateTime? get dateTask => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ToDoTaskCopyWith<ToDoTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToDoTaskCopyWith<$Res> {
  factory $ToDoTaskCopyWith(ToDoTask value, $Res Function(ToDoTask) then) =
      _$ToDoTaskCopyWithImpl<$Res, ToDoTask>;
  @useResult
  $Res call({int id, String? description, String? tag, DateTime? dateTask});
}

/// @nodoc
class _$ToDoTaskCopyWithImpl<$Res, $Val extends ToDoTask>
    implements $ToDoTaskCopyWith<$Res> {
  _$ToDoTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = freezed,
    Object? tag = freezed,
    Object? dateTask = freezed,
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
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTask: freezed == dateTask
          ? _value.dateTask
          : dateTask // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ToDoTaskCopyWith<$Res> implements $ToDoTaskCopyWith<$Res> {
  factory _$$_ToDoTaskCopyWith(
          _$_ToDoTask value, $Res Function(_$_ToDoTask) then) =
      __$$_ToDoTaskCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? description, String? tag, DateTime? dateTask});
}

/// @nodoc
class __$$_ToDoTaskCopyWithImpl<$Res>
    extends _$ToDoTaskCopyWithImpl<$Res, _$_ToDoTask>
    implements _$$_ToDoTaskCopyWith<$Res> {
  __$$_ToDoTaskCopyWithImpl(
      _$_ToDoTask _value, $Res Function(_$_ToDoTask) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = freezed,
    Object? tag = freezed,
    Object? dateTask = freezed,
  }) {
    return _then(_$_ToDoTask(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTask: freezed == dateTask
          ? _value.dateTask
          : dateTask // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ToDoTask implements _ToDoTask {
  const _$_ToDoTask(
      {required this.id,
      required this.description,
      required this.tag,
      required this.dateTask});

  factory _$_ToDoTask.fromJson(Map<String, dynamic> json) =>
      _$$_ToDoTaskFromJson(json);

  @override
  final int id;
  @override
  final String? description;
  @override
  final String? tag;
  @override
  final DateTime? dateTask;

  @override
  String toString() {
    return 'ToDoTask(id: $id, description: $description, tag: $tag, dateTask: $dateTask)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ToDoTask &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.dateTask, dateTask) ||
                other.dateTask == dateTask));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, description, tag, dateTask);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ToDoTaskCopyWith<_$_ToDoTask> get copyWith =>
      __$$_ToDoTaskCopyWithImpl<_$_ToDoTask>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ToDoTaskToJson(
      this,
    );
  }
}

abstract class _ToDoTask implements ToDoTask {
  const factory _ToDoTask(
      {required final int id,
      required final String? description,
      required final String? tag,
      required final DateTime? dateTask}) = _$_ToDoTask;

  factory _ToDoTask.fromJson(Map<String, dynamic> json) = _$_ToDoTask.fromJson;

  @override
  int get id;
  @override
  String? get description;
  @override
  String? get tag;
  @override
  DateTime? get dateTask;
  @override
  @JsonKey(ignore: true)
  _$$_ToDoTaskCopyWith<_$_ToDoTask> get copyWith =>
      throw _privateConstructorUsedError;
}
