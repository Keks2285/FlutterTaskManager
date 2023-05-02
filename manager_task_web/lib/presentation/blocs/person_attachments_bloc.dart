// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:manager_task/data/models/group.dart';
// import 'package:manager_task/data/repositories/auth_repo.dart';

// import '../../common/app_env.dart';
// import '../../data/models/person_attacment.dart';
// import '../../data/models/user.dart';
// import '../../data/repositories/groups_repo.dart';
// import '../../data/repositories/personAttacment_repo.dart';

// class PersonAttachmentsBloc extends Bloc<PersonAttachmentsEvent,PersonAttachmentsState>{
//   PersonAttachmentsBloc():super(PersonAttachmentsInitState(attachmentsList: PersonAtachmentsRepository.allAttachment)){
//     on<PersonAttachmentsInitEvent>(
//       (PersonAttachmentsInitEvent event, Emitter<PersonAttachmentsState> emit)async{
//         PersonAtachmentsRepository.allAttachment.clear();
//         var result = await PersonAtachmentsRepository().LoadPersonAttachments(event.idTask);
        
//         result.fold(
//           (l) {
//             emit(PersonAttachmentsConnectionError( message:l, attachmentsList:PersonAtachmentsRepository.allAttachment));
//           },
//           (r) {
//           emit(PersonAttachmentsInitState(attachmentsList:PersonAtachmentsRepository.allAttachment));
//           } //тут изменить на другое состояние
//         );
//           //emit(PersonAttachmentsInitState(PersonAttachments: GroupsRepo.allGroups));
//       });
//   }
// }

// abstract class PersonAttachmentsState{
//   List<PersonAtachment> attachmentsList=[];
//   String nameState="";
//   String message="";
//   bool succes = true;
// }

// abstract class PersonAttachmentsEvent{
// }

// class PersonAttachmentsInitState extends PersonAttachmentsState {
//    String nameState="init";
//     bool succes = true;
//     @override
//     List<PersonAtachment> attachmentsList;
//     PersonAttachmentsInitState({required this.attachmentsList});
// }
// class PersonAttachmentsConnectionError extends PersonAttachmentsState {
//     String nameState="connError";
//     List<PersonAtachment> attachmentsList;
//     bool succes = false;
//     String message;
//     PersonAttachmentsConnectionError({required this.message, required this.attachmentsList});
// }

// class PersonAttachmentsInitEvent extends PersonAttachmentsEvent{
//   String idTask;
//   PersonAttachmentsInitEvent({required this.idTask});
// }
// class JoinGroupEvent extends PersonAttachmentsEvent{
//   String nameGroup;
//   JoinGroupEvent({required this.nameGroup});
// }


// class CreateGroupEvent extends PersonAttachmentsEvent{
//   String nameGroup;
//   CreateGroupEvent({required this.nameGroup});
// }