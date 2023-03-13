// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ToDoTask _$$_ToDoTaskFromJson(Map<String, dynamic> json) => _$_ToDoTask(
      id: json['id'] as int,
      description: json['description'] as String?,
      tag: json['tag'] as String?,
      dateTask: json['dateTask'] == null
          ? null
          : DateTime.parse(json['dateTask'] as String),
    );

Map<String, dynamic> _$$_ToDoTaskToJson(_$_ToDoTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'tag': instance.tag,
      'dateTask': instance.dateTask?.toIso8601String(),
    };
