import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:manager_task/data/models/group.dart';
import 'package:manager_task/data/repositories/auth_repo.dart';

import '../../common/app_env.dart';
import '../../data/models/user.dart';
import '../../data/repositories/groups_repo.dart';

class GroupListBloc extends Bloc<GroupListEvent,GroupListState>{
  GroupListBloc():super(GroupListInitState(groupList: GroupsRepo.allGroups)){
    on<GroupListInitEvent>(
      (GroupListInitEvent event, Emitter<GroupListState> emit)async{
        GroupsRepo.allGroups.clear();
        var result = await GroupsRepo().LoadGroups();
        
        result.fold(
          (l) {
            emit(GroupListConnectionError( message:l, groupList: GroupsRepo.allGroups));
          },
          (r) {
          emit(GroupListInitState(groupList:GroupsRepo.allGroups));
          } //тут изменить на другое состояние
        );
          //emit(GroupListInitState(groupList: GroupsRepo.allGroups));
      });


      on<CreateGroupEvent>(
        (CreateGroupEvent event, Emitter<GroupListState> emit)async{
             var result = await GroupsRepo().createGroup(Group(id: 0, namegroup: event.nameGroup, adminid: AppEnv.userId));


              result.fold(
          (l) {
            emit(GroupListConnectionError( message:l, groupList: GroupsRepo.allGroups));
          },
          (r) {
          emit(GroupListInitState(groupList:GroupsRepo.allGroups));
          } //тут изменить на другое состояние
        );
        //  emit(GroupListInitState(groupList: GroupsRepo.allGroups));
        });




         on<JoinGroupEvent>(
        (JoinGroupEvent event, Emitter<GroupListState> emit)async{
             var result = await GroupsRepo().joinGroup(event.nameGroup);


              result.fold(
          (l) {
            emit(GroupListConnectionError( message:l, groupList: GroupsRepo.allGroups));
          },
          (r) {
          emit(GroupListInitState(groupList:GroupsRepo.allGroups));
          } //тут изменить на другое состояние
        );
        //  emit(GroupListInitState(groupList: GroupsRepo.allGroups));
        });
  }
}

abstract class GroupListState{
  List<Group> groupList=[];
  String nameState="";
  String message="";
  bool succes = true;
}

abstract class GroupListEvent{
}

class GroupListInitState extends GroupListState {
   String nameState="init";
    bool succes = true;
    @override
    List<Group> groupList;
    GroupListInitState({required this.groupList});
}
class GroupListConnectionError extends GroupListState {
    String nameState="connError";
    List<Group> groupList;
    bool succes = false;
    String message;
    GroupListConnectionError({required this.message, required this.groupList});
}

class GroupListInitEvent extends GroupListEvent{

}
class JoinGroupEvent extends GroupListEvent{
  String nameGroup;
  JoinGroupEvent({required this.nameGroup});
}


class CreateGroupEvent extends GroupListEvent{
  String nameGroup;
  CreateGroupEvent({required this.nameGroup});
}