import 'package:freezed_annotation/freezed_annotation.dart';

part'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User{

  const factory User(
  {
    required String email,
    required String? password,
    required String? firstname,
    required String? lastname,
    required String? middlename,
    required String? accessToken,
    required String? refreshToken,
  }
  ) = _User;

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
}