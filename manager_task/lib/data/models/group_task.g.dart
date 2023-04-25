// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GroupTask _$$_GroupTaskFromJson(Map<String, dynamic> json) => _$_GroupTask(
      id: json['id'] as int,
      description: json['description'] as String?,
      dateTask: json['dateTask'] == null
          ? null
          : DateTime.parse(json['dateTask'] as String),
      completedBy: json['completedBy'] as String,
    );

Map<String, dynamic> _$$_GroupTaskToJson(_$_GroupTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'dateTask': instance.dateTask?.toIso8601String(),
      'completedBy': instance.completedBy,
    };
