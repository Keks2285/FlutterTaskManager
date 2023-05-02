// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notify.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Notify _$NotifyFromJson(Map<String, dynamic> json) {
  return _Notify.fromJson(json);
}

/// @nodoc
mixin _$Notify {
  int get id => throw _privateConstructorUsedError;
  String? get date_time => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotifyCopyWith<Notify> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotifyCopyWith<$Res> {
  factory $NotifyCopyWith(Notify value, $Res Function(Notify) then) =
      _$NotifyCopyWithImpl<$Res, Notify>;
  @useResult
  $Res call({int id, String? date_time, String? title, String? body});
}

/// @nodoc
class _$NotifyCopyWithImpl<$Res, $Val extends Notify>
    implements $NotifyCopyWith<$Res> {
  _$NotifyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date_time = freezed,
    Object? title = freezed,
    Object? body = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date_time: freezed == date_time
          ? _value.date_time
          : date_time // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NotifyCopyWith<$Res> implements $NotifyCopyWith<$Res> {
  factory _$$_NotifyCopyWith(_$_Notify value, $Res Function(_$_Notify) then) =
      __$$_NotifyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? date_time, String? title, String? body});
}

/// @nodoc
class __$$_NotifyCopyWithImpl<$Res>
    extends _$NotifyCopyWithImpl<$Res, _$_Notify>
    implements _$$_NotifyCopyWith<$Res> {
  __$$_NotifyCopyWithImpl(_$_Notify _value, $Res Function(_$_Notify) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date_time = freezed,
    Object? title = freezed,
    Object? body = freezed,
  }) {
    return _then(_$_Notify(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date_time: freezed == date_time
          ? _value.date_time
          : date_time // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Notify implements _Notify {
  const _$_Notify(
      {required this.id,
      required this.date_time,
      required this.title,
      required this.body});

  factory _$_Notify.fromJson(Map<String, dynamic> json) =>
      _$$_NotifyFromJson(json);

  @override
  final int id;
  @override
  final String? date_time;
  @override
  final String? title;
  @override
  final String? body;

  @override
  String toString() {
    return 'Notify(id: $id, date_time: $date_time, title: $title, body: $body)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Notify &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date_time, date_time) ||
                other.date_time == date_time) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, date_time, title, body);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotifyCopyWith<_$_Notify> get copyWith =>
      __$$_NotifyCopyWithImpl<_$_Notify>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotifyToJson(
      this,
    );
  }
}

abstract class _Notify implements Notify {
  const factory _Notify(
      {required final int id,
      required final String? date_time,
      required final String? title,
      required final String? body}) = _$_Notify;

  factory _Notify.fromJson(Map<String, dynamic> json) = _$_Notify.fromJson;

  @override
  int get id;
  @override
  String? get date_time;
  @override
  String? get title;
  @override
  String? get body;
  @override
  @JsonKey(ignore: true)
  _$$_NotifyCopyWith<_$_Notify> get copyWith =>
      throw _privateConstructorUsedError;
}
