import 'package:freezed_annotation/freezed_annotation.dart';
part 'notify.freezed.dart';
part 'notify.g.dart';
@freezed
class Notify with _$Notify{
  const factory Notify(
  {
    required int id,
    required String? date_time,
    required String? title,
    required String? body
  }
  ) = _Notify;
  
  factory Notify.fromJson(Map<String,dynamic> json) => _$NotifyFromJson(json);
}