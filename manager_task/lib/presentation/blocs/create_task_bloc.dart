import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manager_task/data/models/task.dart';
import 'package:manager_task/data/repositories/auth_repo.dart';

import '../../common/app_env.dart';
import '../../data/models/user.dart';
import '../../data/repositories/task_repo.dart';

class CreateTaskBloc extends Bloc<TaskBlocEvent, CreateTaskBlocState> {
  CreateTaskBloc()
      : super(CreateTaskInitState(
            dateTime: DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
            selectedtag: "#Учеба",
            message: "")) {
    on<SelectedDateTimeEvent>(
        (SelectedDateTimeEvent event, Emitter<CreateTaskBlocState> emit) async {
      emit(CreateTaskInitState(
          selectedtag: event.selectedtag,
          dateTime: DateFormat("yyyy-MM-dd").format(event.dateTime) +
              " " +
              event.timeOfDay.hour.toString().padLeft(2, "0") +
              ":" +
              event.timeOfDay.minute.toString().padLeft(2, "0") +
              ":00",
          message: ""));
    });

    on<SelectedTagEvent>(
        (SelectedTagEvent event, Emitter<CreateTaskBlocState> emit) async {
      emit(SelectedTagState(
          selectedtag: event.selectedtag, dateTime: event.dateTime));
    });

    on<CreateTaskBlocEvent>(
        (CreateTaskBlocEvent event, Emitter<CreateTaskBlocState> emit) async {
      if (event.description.length < 1) {
        emit(CreateTaskInitState(
            dateTime: event.dateTime,
            selectedtag: "#Учеба",
            message: "Заполните описание"));
      } else {
        var result = await TaskRepo().CreateTask(ToDoTask(
            id: 0,
            description: event.description,
            tag: event.selectedtag,
            dateTask: DateTime.parse(event.dateTime)));

        result.fold((l) {
          emit(CreateTaskConnectionError());
        }, (r) {
          emit(CreateTaskInitState(
              dateTime: event.dateTime,
              selectedtag: "#Учеба",
              message: "Задача добавлена"));
        } //тут изменить на другое состояние
            );
      }
    });
  }
}

abstract class CreateTaskBlocState {
  String message = "";
  String description = "";
  bool succes = false;
  String selectedtag = "#Учеба";
  final String dateTime = "";
  final String TimeOfDay = "";
}

abstract class TaskBlocEvent {}

class CreateTaskBlocEvent extends TaskBlocEvent {
  final String description;
  final String selectedtag;
  final String dateTime;
  CreateTaskBlocEvent(
      {required this.selectedtag,
      required this.description,
      required this.dateTime});
}

class SelectedTagEvent extends TaskBlocEvent {
  final String selectedtag;
  final String dateTime;
  final String timeOfDay;
  SelectedTagEvent(
      {required this.selectedtag,
      required this.dateTime,
      required this.timeOfDay});
}

class SelectedDateTimeEvent extends TaskBlocEvent {
  final String selectedtag; //
  final DateTime dateTime;
  final TimeOfDay timeOfDay;
  SelectedDateTimeEvent(
      {required this.dateTime,
      required this.timeOfDay,
      required this.selectedtag});
}

class CreateTaskInitState extends CreateTaskBlocState {
  @override
  String message = "Введите данные задачи";
  final String dateTime;
  final String selectedtag;
  CreateTaskInitState(
      {required this.dateTime,
      required this.selectedtag,
      required this.message});
}

class SelectedTagState extends CreateTaskBlocState {
  final String selectedtag; //
  final String dateTime;
  SelectedTagState({required this.selectedtag, required this.dateTime});
}

class CreateTaskConnectionError extends CreateTaskBlocState {
  final String dateTime=DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()); //чтобы поле с датой не оставалось пустым
  String get message => "Проблемы с сетью проверьте подключение";
}
