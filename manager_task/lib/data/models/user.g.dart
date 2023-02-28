// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      email: json['email'] as String,
      password: json['password'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      middlename: json['middlename'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'middlename': instance.middlename,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
