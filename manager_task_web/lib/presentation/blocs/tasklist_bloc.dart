import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:manager_task_web/data/models/task.dart';
import 'package:manager_task_web/data/repositories/task_repo.dart';

import '../../common/app_env.dart';
import '../../data/models/user.dart';
import '../../data/repositories/auth_repo.dart';

class TaskListBloc extends Bloc<TaskListBlocEvent, TaskListBlocState>{


  
  TaskListBloc():super(TaskListBlocInitState(taskList:TaskRepo.allTasks)){
    on<TaskListBlocSearcEvent>(
      (TaskListBlocSearcEvent event, Emitter<TaskListBlocState> emit) async{
       
       
      
    });

    on<TaskListInitEvent>(
      (TaskListInitEvent event, Emitter<TaskListBlocState> emit) async{
      TaskRepo.allTasks.clear();
        var result = await TaskRepo()
            .LoadTasks();
        
        result.fold(
          (l) {
            emit(TaskListBlocConnectionErrorState(message: l));
          },
          (r) {
          emit(TaskListBlocInitState(taskList:TaskRepo.allTasks));
          } //тут изменить на другое состояние
        );
    });



     on<TaskDeleteEvent>((TaskDeleteEvent event, Emitter<TaskListBlocState> emit) async{
        var result = await TaskRepo().Deletetask(event.id);
        result.fold(
          (l) {
            emit(TaskListBlocConnectionErrorState(message: l));
          },
          (r) {
          emit(TaskListBlocInitState(taskList:TaskRepo.allTasks));
          } 
        );
    });




    on<TaskSearchEvent>((TaskSearchEvent event, Emitter<TaskListBlocState> emit) async{

            var searchedList=TaskRepo.allTasks.where((element) => element.description!.toLowerCase().contains(event.query.toLowerCase())||element.tag!.toLowerCase().contains(event.query.toLowerCase()));

            //emit(TaskListBlocSearchState(taskList: searchedList.toList()));
           emit(TaskListBlocSearchState(taskList: searchedList.toList()));
    });
       
  }

}


abstract class TaskListBlocState{
  String nameState="init";
  List<ToDoTask> taskList =List.empty();
  bool succes = true;
  String message="";
}

abstract class TaskListBlocEvent{
  
}


class TaskDeleteEvent extends TaskListBlocEvent{
  final int id;
  List<ToDoTask> taskList = TaskRepo.allTasks;
  TaskDeleteEvent({required this.id});
}


class TaskListInitEvent extends TaskListBlocEvent{

}

class TaskSearchEvent extends TaskListBlocEvent{
  final String query;
  TaskSearchEvent({required this.query});
}

class TaskListBlocSearcEvent extends TaskListBlocEvent{
  String tag;
  TaskListBlocSearcEvent({required this.tag});
}

class TaskListBlocInitState extends TaskListBlocState{
  String nameState="init";
  bool succes = true;
  @override
  List<ToDoTask> taskList;
  List<ToDoTask> searchedTask=[];
  TaskListBlocInitState({required this.taskList});
}

class TaskListBlocSearchState extends TaskListBlocState{
  String nameState="search";
  bool succes = true;
  final List<ToDoTask> taskList;
  TaskListBlocSearchState({required this.taskList});
}




class ConnectionErrorEvent extends TaskListBlocEvent{

}

class TaskListBlocConnectionErrorState extends TaskListBlocState{
  List<ToDoTask> taskList= List.empty();
  String message;
  String nameState="connectionErr";
  bool succes = false;
  TaskListBlocConnectionErrorState({required this.message});
}

