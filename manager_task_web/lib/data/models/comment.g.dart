// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      id: json['id'] as int,
      comment: json['comment'] as String?,
      email: json['email'] as String?,
      dateComment: json['dateComment'] == null
          ? null
          : DateTime.parse(json['dateComment'] as String),
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'email': instance.email,
      'dateComment': instance.dateComment?.toIso8601String(),
    };
