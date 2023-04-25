import 'package:freezed_annotation/freezed_annotation.dart';
part 'group_task.freezed.dart';
part 'group_task.g.dart';
@freezed
class GroupTask with _$GroupTask{
  const factory GroupTask(
  {
    required int id,
    required String? description,
    required DateTime? dateTask,
    
    required String completedBy
  }
  ) = _GroupTask;
  
  factory GroupTask.fromJson(Map<String,dynamic> json) => _$GroupTaskFromJson(json);
}