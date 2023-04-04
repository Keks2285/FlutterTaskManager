import 'package:conduit/conduit.dart';
import 'package:taskapi/model/group.dart';

class GroupTask extends ManagedObject<_GroupTask> implements _GroupTask {}

class _GroupTask {
  @primaryKey
  int? id;
  @Column(unique: false, nullable: true, defaultValue: "'-'")
  String? completedBy;

  @Column(unique: false, indexed: true)
  String? description;

  @Column(unique: false, indexed: true)
  DateTime? dateTask;


  @Relate(#groupTaskList, isRequired: true, onDelete: DeleteRule.cascade)
  Group? group;
}