import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:manager_task/data/models/task.dart';
import 'package:manager_task/data/repositories/task_repo.dart';

import '../../common/app_env.dart';
import '../../data/models/user.dart';
import '../../data/repositories/auth_repo.dart';

class TaskListBloc extends Bloc<TaskListBlocEvent, TaskListBlocState>{


  
  TaskListBloc():super(TaskListBlocInitState()){
    on<TaskListBlocSearcEvent>(
      (TaskListBlocSearcEvent event, Emitter<TaskListBlocState> emit) async{
       
       
      
    });

    on<TaskListInitEvent>((TaskListInitEvent event, Emitter<TaskListBlocState> emit) async{
        var result = await TaskRepo()
            .Load10Tasks(1);
        
        result.fold(
          (l) {
            emit(TaskListBlocConnectionErrorState(message: l));
          },
          (r) {
          emit(TaskListBlocInitState());
          } //тут изменить на другое состояние
        );
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


class TaskListInitEvent extends TaskListBlocEvent{

}

class TaskListBlocSearcEvent extends TaskListBlocEvent{
  String tag;
  TaskListBlocSearcEvent({required this.tag});
}

class TaskListBlocInitState extends TaskListBlocState{
  String nameState="init";
  bool succes = true;
  List<ToDoTask> taskList = TaskRepo.allTasks;
}


class TaskListBlocSearchState extends TaskListBlocState{
  String nameState="search";
  List<ToDoTask> taskList;
  bool succes = true;
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

