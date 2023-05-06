// import 'package:bloc/bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:manager_task/data/models/notify.dart';
// import 'package:manager_task/data/models/task.dart';
// import 'package:manager_task/data/repositories/notify_repo.dart';
// import 'package:manager_task/data/repositories/task_repo.dart';

// import '../../common/app_env.dart';
// import '../../data/models/group_task.dart';
// import '../../data/models/user.dart';
// import '../../data/repositories/auth_repo.dart';
// import '../../data/repositories/groupTasks_repo.dart';

// class NotifyBloc extends Bloc<NotifyBlocEvent, NotifyBlocState> {
//   NotifyBloc()
//       : super(NotifyInitState(
//             notifiesList: NotifyRepo.allNotifies,
//             date: DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 1))),
//             time: TimeOfDay.now().hour.toString().padLeft(2, '0') +":" +TimeOfDay.now().minute.toString().padLeft(2, '0') +":00",
//             body: "",
//             title: "")) {



//             on<NotifyInitEvent>(
//                 (NotifyInitEvent event, Emitter<NotifyBlocState> emit) async {
//               //GroupTaskRepo.allTasks.clear();
//                 await NotifyRepo().getNotyifications().then((value) => {
//                     emit(NotifyInitState(
//                       notifiesList: NotifyRepo.allNotifies,
//                       date: DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 1))),
//                       time: TimeOfDay.now().hour.toString().padLeft(2, '0') +":" +TimeOfDay.now().minute.toString().padLeft(2, '0') +":00",
//                       body: "",
//                       title: "")
//                     )
//                 },);
                
                  
//             });
//   }
// }

// abstract class NotifyBlocEvent {}

// abstract class NotifyBlocState {
//   String nameState = "init";
//   List<Notify> notifyList = List.empty();
//   bool succes = true;
//   String message = "";
//   final String date = "";
//   final String Time = "";
//   String description = "";
// }

// class CreateNotifyEvent extends NotifyBlocEvent {
//   final String date;
//   final String time;
//   final String title;
//   final String body;
//   CreateNotifyEvent(
//       {required this.date,
//       required this.time,
//       required this.title,
//       required this.body});
// }

// class SelectedDateTimeEvent extends NotifyBlocEvent {
//   final String date;
//   final String time;
//   final String title;
//   final String body;
//   SelectedDateTimeEvent({
//     required this.date,
//     required this.time,
//     required this.body,
//     required this.title,
//   });
// }

// class NotifyInitEvent extends NotifyBlocEvent{}

// class NotifyInitState extends NotifyBlocState {
//   List<Notify> notifiesList;
//   String title;
//   String body;
//   String time;
//   String date;
//   NotifyInitState(
//       {required this.notifiesList,
//       required this.date,
//       required this.time,
//       required this.body,
//       required this.title});
// }
