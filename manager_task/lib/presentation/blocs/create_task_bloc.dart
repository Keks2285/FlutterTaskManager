import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:manager_task/data/repositories/auth_repo.dart';

import '../../common/app_env.dart';
import '../../data/models/user.dart';

class CreateTaskBloc extends Bloc<TaskBlocEvent, CreateTaskBlocState>{
  CreateTaskBloc():super(CreateTaskInitState(dateTime: "2022-03-01 12:20:00")){
    
    
    on<SelectedDateTimeEvent>((SelectedDateTimeEvent event, Emitter<CreateTaskBlocState> emit) async{
      emit(CreateTaskInitState(
        dateTime: 
          event.dateTime.year.toString()+"-"
          +event.dateTime.month.toString()+"-"
          +event.dateTime.day.toString()+" "+
          event.timeOfDay.hour.toString()+":"+
          event.timeOfDay.minute.toString()+":00"
        ));
    });

    on<SelectedTagEvent>((SelectedTagEvent event, Emitter<CreateTaskBlocState> emit)async{
      emit(SelectedTagState(
        selectedtag: event.selectedtag
      ));
    });
  }

}


abstract class CreateTaskBlocState{
  String message="";
  bool succes=false;
  String selectedtag="#Учеба";
  final String dateTime="";
}

abstract class TaskBlocEvent{
}


 class CreateTaskBlocEvent extends TaskBlocEvent{
  final DateTime dateTime;
  final TimeOfDay timeOfDay;
  CreateTaskBlocEvent({required  this.dateTime, required this.timeOfDay});
}


class SelectedTagEvent extends TaskBlocEvent{
  final String selectedtag;
  SelectedTagEvent({required this.selectedtag});
} 

class SelectedDateTimeEvent extends TaskBlocEvent{
  final DateTime dateTime;
  final TimeOfDay timeOfDay;
  SelectedDateTimeEvent({required  this.dateTime, required this.timeOfDay});
}

class CreateTaskInitState extends CreateTaskBlocState{
  @override
  String get message=>"Введите данные задачи";
  final String dateTime;
  CreateTaskInitState({required this.dateTime});
}
class SelectedTagState extends CreateTaskBlocState{
  final String selectedtag;
  SelectedTagState({required this.selectedtag});
}