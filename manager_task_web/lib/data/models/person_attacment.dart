import 'package:freezed_annotation/freezed_annotation.dart';
part 'person_attacment.freezed.dart';
part 'person_attacment.g.dart';
@freezed
class PersonAtachment with _$PersonAtachment{
  const factory PersonAtachment(
  {
    required String? filename,
    required String extension,
    required String size
  }
  ) = _PersonAtachment;
  
  factory PersonAtachment.fromJson(Map<String,dynamic> json) => _$PersonAtachmentFromJson(json);
}