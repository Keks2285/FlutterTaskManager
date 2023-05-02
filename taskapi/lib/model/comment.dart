import 'package:conduit/conduit.dart';
import 'package:taskapi/model/user.dart';

import 'groupTask.dart';

class Comment extends ManagedObject<_Comment> implements _Comment {}


class _Comment{
  @primaryKey
  int? id;
  @Column(unique: false, indexed: true, nullable: false)
  String? stringComment;

  @Column(unique: false, indexed: true, nullable: false)
  String? authorEmail;

  @Relate(#commentList, isRequired: true, onDelete: DeleteRule.cascade)
  GroupTask? groupTask;
}