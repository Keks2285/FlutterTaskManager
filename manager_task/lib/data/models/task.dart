import 'package:freezed_annotation/freezed_annotation.dart';

part'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task{

  const factory Task(
  {
    required String? description,
    required String? tag,
    required DateTime? dateTask
  }
  ) = _Task;

  factory Task.fromJson(Map<String,dynamic> json) => _$TaskFromJson(json);
}