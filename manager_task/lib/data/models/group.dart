import 'package:freezed_annotation/freezed_annotation.dart';
part 'group.freezed.dart';
part 'group.g.dart';
@freezed
class Group with _$Group{

  const factory Group(
  {
    required int id,
    required String? namegroup,
    required int? adminid
  }
  ) = _Group;

  factory Group.fromJson(Map<String,dynamic> json) => _$GroupFromJson(json);
}