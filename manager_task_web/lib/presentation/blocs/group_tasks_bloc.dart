import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manager_task_web/data/models/task.dart';
import 'package:manager_task_web/data/repositories/task_repo.dart';

import '../../common/app_env.dart';
import '../../data/models/group_task.dart';
import '../../data/models/user.dart';
import '../../data/repositories/auth_repo.dart';
import '../../data/repositories/groupTasks_repo.dart';

class GroupTasksBloc extends Bloc<GroupTasksBlocEvent, GroupTasksBlocState>{


  
  GroupTasksBloc():super(GroupTasksBlocInitState(taskList:GroupTaskRepo.allTasks, 
            date: DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 1))),
            Time: TimeOfDay.now().hour.toString().padLeft(2, '0')+":"+TimeOfDay.now().minute.toString().padLeft(2, '0')+":00",
            description: ""))
            {
      on<GroupTasksBlocSearcEvent>(
      (GroupTasksBlocSearcEvent event, Emitter<GroupTasksBlocState> emit) async{
       
       
      
    });

    on<GroupTasksInitEvent>(
      (GroupTasksInitEvent event, Emitter<GroupTasksBlocState> emit) async{
      //GroupTaskRepo.allTasks.clear();
        var result = await GroupTaskRepo().LoadGroupTasks(event.groupId);
        
        result.fold(
          (l) {
            emit(GroupTasksBlocConnectionErrorState(message: l));
          },
          (r) {
          emit(GroupTasksBlocInitState(
            taskList:GroupTaskRepo.allTasks, 
            date: DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 1))),
            Time: TimeOfDay.now().hour.toString().padLeft(2, '0')+":"+TimeOfDay.now().minute.toString().padLeft(2, '0')+":00",
            description: ""
            ));
          } //тут изменить на другое состояние
        );
    });



     on<GroupTasksDeleteEvent>((GroupTasksDeleteEvent event, Emitter<GroupTasksBlocState> emit) async{
        var result = await GroupTaskRepo().Deletetask(event.id);
        result.fold(
          (l) {
            emit(GroupTasksBlocConnectionErrorState(message: l));
          },
          (r) {
          emit(GroupTasksBlocInitState(taskList:GroupTaskRepo.allTasks, Time: event.Time, date: event.date, description: event.description));
          } 
        );
    });
    on<GroupTasksSearchEvent>((GroupTasksSearchEvent event, Emitter<GroupTasksBlocState> emit) async{

                var searchedList=GroupTaskRepo.allTasks.where((element) => element.description!.toLowerCase().contains(event.query.toLowerCase()));

                //emit(GroupTasksBlocSearchState(taskList: searchedList.toList()));
              emit(GroupTasksBlocSearchState(taskList: searchedList.toList()));
        });



    on<CompleteTaskEvent>((CompleteTaskEvent event, Emitter<GroupTasksBlocState> emit) async{

           // var searchedList=GroupTaskRepo.allTasks.where((element) => element.description!.toLowerCase().contains(event.query.toLowerCase()));

            //emit(GroupTasksBlocSearchState(taskList: searchedList.toList()));

       var result = await GroupTaskRepo().CompleteTask(id:event.id);
        result.fold(
          (l) {
            emit(GroupTasksBlocConnectionErrorState(message: l));
          },
          (r) {
          emit(GroupTasksBlocInitState(taskList:GroupTaskRepo.allTasks, Time: event.Time, date: event.date, description: event.description));
          } 
        );
           //emit(GroupTasksBlocInitState(taskList: GroupTaskRepo.allTasks, Time: event.Time, date: event.Time, description: event.description));
    });

    on<CreateGroupTaskEvent>((CreateGroupTaskEvent event, Emitter<GroupTasksBlocState> emit) async{
          var result = await GroupTaskRepo().CreateTask(
            dataTask:{"description":event.description, 
                      "dateTask":event.date+" "+event.Time}, idGroup: event.groupId);
        result.fold(
          (l) {
            emit(GroupTasksBlocConnectionErrorState(message: l));
          },
          (r) {
          emit(GroupTasksBlocInitState(taskList:GroupTaskRepo.allTasks, Time: event.Time, date: event.date, description: event.description));
          } 
        );

         //  emit(GroupTasksBlocInitState(taskList: GroupTaskRepo.allTasks, Time: event.Time, date: event.Time, description: event.description));
    
    });
    on<SelectedDateTimeEvent>((SelectedDateTimeEvent event, Emitter<GroupTasksBlocState> emit) async{
           emit(GroupTasksBlocInitState(taskList: GroupTaskRepo.allTasks, Time: event.Time, date: event.date, description: event.description));
    });
       
  }

}


abstract class GroupTasksBlocState{
  String nameState="init";
  List<GroupTask> taskList =List.empty();
  bool succes = true;
  String message="";
  final String date = "";
  final String Time = "";
  String description = "";
}

abstract class GroupTasksBlocEvent{
  
}


class CreateGroupTaskEvent extends GroupTasksBlocEvent {
  final int groupId;
  final String date ;
  final String Time;
  final String description ;
  CreateGroupTaskEvent({
      required this.date, required this.Time, required this.description, required this.groupId
    });
}

class SelectedDateTimeEvent extends GroupTasksBlocEvent {
  final String date ;
  final String Time;
  final String description ;
  SelectedDateTimeEvent(
      {required this.date, required this.Time, required this.description});
}

class GroupTasksDeleteEvent extends GroupTasksBlocEvent{
  final String date ;
  final String Time;
  final String description ;
  final int id;
  List<GroupTask> taskList = GroupTaskRepo.allTasks;
  GroupTasksDeleteEvent({required this.id, required this.date, required this.Time, required this.description});
}


class GroupTasksInitEvent extends GroupTasksBlocEvent{
  int groupId;
  GroupTasksInitEvent({required this.groupId});
}

class GroupTasksSearchEvent extends GroupTasksBlocEvent{
  final String query;
  GroupTasksSearchEvent({required this.query});
}

class GroupTasksBlocSearcEvent extends GroupTasksBlocEvent{
  String tag;
  GroupTasksBlocSearcEvent({required this.tag});
}

class GroupTasksBlocInitState extends GroupTasksBlocState{
  String nameState="init";
  bool succes = true;
  String message="";
  final String date ;
  final String Time;
  final String description ;
  @override
  List<GroupTask> taskList;
  List<GroupTask> searchedTask=[];
  GroupTasksBlocInitState({required this.taskList, required this.date, required this.Time, required this.description, this.message="", this.succes=true});
}

class GroupTasksBlocSearchState extends GroupTasksBlocState{
  String nameState="search";
  bool succes = true;
  String date= DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 1)));
  String Time= TimeOfDay.now().hour.toString()+":"+TimeOfDay.now().minute.toString()+":00";
  final List<GroupTask> taskList;
  GroupTasksBlocSearchState({required this.taskList});
}




class ConnectionErrorEvent extends GroupTasksBlocEvent{

}

class CompleteTaskEvent extends GroupTasksBlocEvent{
final int id;
final int index;
final String date ;
final String Time;
final String description ;
CompleteTaskEvent({required this.id,required this.index,required this.date, required this.Time, required this.description});
}

class CompleteTaskState extends GroupTasksBlocState{

}

class GroupTasksBlocConnectionErrorState extends GroupTasksBlocState{
  List<GroupTask> taskList= GroupTaskRepo.allTasks;
  String message;
  String nameState="connectionErr";
  bool succes = false;
  String date= DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 1)));
  String Time= TimeOfDay.now().hour.toString()+":"+TimeOfDay.now().minute.toString()+":00";
  GroupTasksBlocConnectionErrorState({required this.message});
}

