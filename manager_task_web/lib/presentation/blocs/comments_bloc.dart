import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:manager_task_web/data/models/comment.dart';
import 'package:manager_task_web/data/models/task.dart';
import 'package:manager_task_web/data/repositories/task_repo.dart';

import '../../common/app_env.dart';
import '../../data/models/user.dart';
import '../../data/repositories/auth_repo.dart';
import '../../data/repositories/comments_repo.dart';

class CommentsBloc extends Bloc<CommentsBlocEvent, CommentsBlocState>{


  
  CommentsBloc():super(CommentsBlocInitState(Comments:ComentsRepo.allComments)){
    on<CommentsBlocAddEvent>(
      (CommentsBlocAddEvent event, Emitter<CommentsBlocState> emit) async{
       
       var result = await ComentsRepo().createComment(event.description);
        
        result.fold(
          (l) {
            emit(CommentsBlocConnectionErrorState(message: l));
          },
          (r) {
          emit(CommentsBlocInitState(Comments:ComentsRepo.allComments));
          } //тут изменить на другое состояние
        );
      
    });

    on<CommentsInitEvent>(
      (CommentsInitEvent event, Emitter<CommentsBlocState> emit) async{
     // TaskRepo.allTasks.clear();
        var result = await ComentsRepo().LoadComments();
        
        result.fold(
          (l) {
            emit(CommentsBlocConnectionErrorState(message: l));
          },
          (r) {
          emit(CommentsBlocInitState(Comments:ComentsRepo.allComments));
          } 
        );
    });



     on<CommentDeleteEvent>((CommentDeleteEvent event, Emitter<CommentsBlocState> emit) async{
        var result = await ComentsRepo().deleteComment(event.id);
        
        // await TaskRepo().Deletetask(event.id);
        result.fold(
          (l) {
            emit(CommentsBlocConnectionErrorState(message: l));
          },
          (r) {
          emit(CommentsBlocInitState(Comments:ComentsRepo.allComments));
          } 
        );
    });




    // on<TaskSearchEvent>((TaskSearchEvent event, Emitter<CommentsBlocState> emit) async{

    //         var searchedList=TaskRepo.allTasks.where((element) => element.description!.toLowerCase().contains(event.query.toLowerCase())||element.tag!.toLowerCase().contains(event.query.toLowerCase()));

    //         //emit(CommentsBlocSearchState(Comments: searchedList.toList()));
    //        emit(CommentsBlocSearchState(Comments: searchedList.toList()));
    // });
       
  }

}


abstract class CommentsBlocState{
  String nameState="init";
  List<Comment> Comments =List.empty();
  bool succes = true;
  String message="";
}

abstract class CommentsBlocEvent{
  
}


class CommentDeleteEvent extends CommentsBlocEvent{
  final int id;
  List<Comment> Comments = ComentsRepo.allComments;
  CommentDeleteEvent({required this.id});
}


class CommentsInitEvent extends CommentsBlocEvent{

}

class TaskSearchEvent extends CommentsBlocEvent{
  final String query;
  TaskSearchEvent({required this.query});
}

class CommentsBlocAddEvent extends CommentsBlocEvent{
  String description;
  CommentsBlocAddEvent({required this.description});
}

class CommentsBlocInitState extends CommentsBlocState{
  String nameState="init";
  bool succes = true;
  @override
  List<Comment> Comments;
  List<Comment> searchedTask=[];
  CommentsBlocInitState({required this.Comments});
}

class CommentsBlocSearchState extends CommentsBlocState{
  String nameState="search";
  bool succes = true;
  final List<Comment> Comments;
  CommentsBlocSearchState({required this.Comments});
}




class ConnectionErrorEvent extends CommentsBlocEvent{

}

class CommentsBlocConnectionErrorState extends CommentsBlocState{
  List<Comment> Comments= List.empty();
  String message;
  String nameState="connectionErr";
  bool succes = false;
  CommentsBlocConnectionErrorState({required this.message});
}

