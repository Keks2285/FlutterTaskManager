import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:taskapi/model/comment.dart';
import 'package:taskapi/model/groupTask.dart';
import '../model/user.dart';
import '../utils/app_responce.dart';
import '../utils/app_utils.dart';
import '../utils/model_responce.dart';


class AppCommentControler extends ResourceController {
  AppCommentControler(this.managedContext);
  final ManagedContext managedContext;



    @Operation.put("id") Future<Response> createComments(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.body() Comment comment,
    @Bind.path("id") int taskId,
    ) async {
    try{
      final fUser = await managedContext.fetchObjectWithID<User>(AppUtils.getIdFromHeader(header));
      final groupTask = await managedContext.fetchObjectWithID<GroupTask>(taskId);
      if(comment.stringComment==""){
        return Response.badRequest(
          body:
              ModelResponse(message: 'Все поля должны быть заполнены'),
        );
      }
      late final int id;
      await managedContext.transaction((transaction) async {
          final qCreateComment = Query<Comment>(transaction)
          ..values.authorEmail =fUser!.email //добавляю 3 часа
          ..values.dateComment = DateTime.now()
          ..values.stringComment=comment.stringComment
          ..values.groupTask =groupTask;
          

          final createdtask = await qCreateComment.insert();
          id=createdtask.id!;
      });

        final taskData = await managedContext.fetchObjectWithID<Comment>(id);
       return Response.ok(
         ModelResponse(
          data:{
            "id":id,
            "dateComment":taskData!.dateComment.toString(),
            "stringComment":taskData.stringComment,
            "authorEmail":taskData.authorEmail
          } ,
          message: 'Комментраий успешно добавлен',
        ),
      );
       
    }on QueryException catch(e){
      return Response.serverError(

        body:  ModelResponse(message: e.message, error: "Not added")
      
      );
    }
    
  }







  @Operation.get("id")
  Future<Response> getComments(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.path("id") int taskId
  ) async {
    try {
      final qGetTasks = Query<Comment>(managedContext)
      ..where((el)=>el.groupTask!.id).equalTo(taskId)
      ..sortBy((el) => el.id, QuerySortOrder.descending)
      ..fetchLimit = 10;

       List<Comment> list = await qGetTasks.fetch();
       list.sort((a, b) => a.id!.compareTo(b.id!));
      if (list.isEmpty)
      {
        return Response.notFound(body: ModelResponse(data: [], message: "Нет ни одного комментария"));
      }

      return Response.ok(list);
    } catch (e) {
      return AppResponse.serverError(e);
    }
  }
  
  @Operation.delete('id')
  Future<Response> deleteTask(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.path("id") int commmentId
  ) async {
    try {
      //final uId = AppUtils.getIdFromHeader(header) ;
      // Получаем id пользователя из header
      final commentData = await managedContext.fetchObjectWithID<Comment>(commmentId);
      if(commentData?.id ==null){
        return Response.notFound(body: {
          "message":"запись не найдена"
        });
      }
      
        final qDeleteComment = Query<Comment>(managedContext)
      ..where((el)=>el.id).equalTo(commmentId);
      qDeleteComment.delete();
      //}


      
     // final List<Task> list = await qGetTasks.fetch();
      
      

      return Response.ok(
        ModelResponse(data: {
          "message":"Запись удалена"
        })
      );
    } catch (e) {
      return AppResponse.serverError(e);
    }
  }



}