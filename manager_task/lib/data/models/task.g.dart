// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      description: json['description'] as String?,
      tag: json['tag'] as String?,
      dateTask: json['dateTask'] == null
          ? null
          : DateTime.parse(json['dateTask'] as String),
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'description': instance.description,
      'tag': instance.tag,
      'dateTask': instance.dateTask?.toIso8601String(),
    };
