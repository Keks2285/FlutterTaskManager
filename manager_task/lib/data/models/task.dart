import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
part'task.freezed.dart';
part 'task.g.dart';

@freezed
class ToDoTask with _$ToDoTask{

  const factory ToDoTask(
  {
    required int id,
    required String? description,
    required String? tag,
    required DateTime? dateTask
  }
  ) = _ToDoTask;

  factory ToDoTask.fromJson(Map<String,dynamic> json) => _$ToDoTaskFromJson(json);
}