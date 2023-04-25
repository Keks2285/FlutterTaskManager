import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:taskapi/model/groupTask.dart';
import 'package:taskapi/model/task.dart';

import '../model/group.dart';
import '../model/user.dart';
import '../utils/app_responce.dart';
import '../utils/app_utils.dart';
import '../utils/model_responce.dart';


class AppGroupTaskControler extends ResourceController {
  AppGroupTaskControler(this.managedContext);
  final ManagedContext managedContext;



   @Operation.post("id") Future<Response> createGroupTask(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.body() GroupTask task,
    @Bind.path("id") int groupId,
    ) async {
    try{
      final fUser = await managedContext.fetchObjectWithID<User>(AppUtils.getIdFromHeader(header));
      final group = await managedContext.fetchObjectWithID<Group>(groupId);
      if(task.dateTask==null || task.description=="" ){
        return Response.badRequest(
          body:
              ModelResponse(message: 'Все поля должны быть заполнены'),
        );
      }
      late final int id;
      await managedContext.transaction((transaction) async {
          final qCreateTask = Query<GroupTask>(transaction)
          ..values.dateTask = task.dateTask!.add(Duration(hours: 3)) //добавляю 3 часа
          ..values.description = task.description
          ..values.group=group;
          

          final createdtask = await qCreateTask.insert();
          id=createdtask.id!;
      });

        final taskData = await managedContext.fetchObjectWithID<GroupTask>(id);
       return Response.ok(
         ModelResponse(
          data:{
            "id":id,
            "dateTask":taskData!.dateTask.toString(),
            "description":taskData.description
          } ,
          message: 'Задача успешно добавлена',
        ),
      );
       
    }on QueryException catch(e){
      return Response.serverError(

        body:  ModelResponse(message: e.message, error: "Not added")
      
      );
    }
    
  }

    @Operation.put('id') Future<Response> updateTask(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.path("id") int taskId) async {
    try{
      final fUser = await managedContext.fetchObjectWithID<User>(AppUtils.getIdFromHeader(header));
      final taskData = await managedContext.fetchObjectWithID<GroupTask>(taskId);
      final uId = AppUtils.getIdFromHeader(header) ;
      
      await managedContext.transaction((transaction) async {
          final qUpdateTask = Query<GroupTask>(transaction)
          ..where((x) => x.id).equalTo(taskId)
          ..values.completedBy=fUser!.email;
          //..values.user = fUser;

          final createdtask = await qUpdateTask.update();
      });

        //final taskData = await managedContext.fetchObjectWithID<Task>(id);
       return Response.ok(
         ModelResponse(
          data:{
            "dateTask":taskData!.dateTask.toString(),
            "description":taskData.description,
            "completedBy":fUser!.email
          } ,
          message: 'Задача отмечена как выполненая',
        ),
      );
       
    }on QueryException catch(e){
      return Response.serverError(

        body:  ModelResponse(message: e.message, error: "Not updated")
      
      );
    }
    
  }







   @Operation.get("id")
  Future<Response> getAllTasks(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
     @Bind.path("id") int groupId
  ) async {
    try {
      // Получаем id пользователя из header
      final uId = AppUtils.getIdFromHeader(header) ;
      
      final qGetTasks = Query<GroupTask>(managedContext)
      ..where((el)=>el.group!.id).equalTo(groupId);

      final List<GroupTask> list = await qGetTasks.fetch();

      if (list.isEmpty)
      {
        return Response.notFound(body: ModelResponse(data: [], message: "Нет ни одной задачи"));
      }

      return Response.ok(list);
    } catch (e) {
      return AppResponse.serverError(e);
    }
  }


  //    @Operation.get("id")
  // Future<Response> get10onPageTasks(
  //   @Bind.header(HttpHeaders.authorizationHeader) String header,
  //     @Bind.path("id") int pageNum
  // ) async {
  //   try {
  //     // Получаем id пользователя из header
  //     final uId = AppUtils.getIdFromHeader(header) ;

  //     final qGetTasks = Query<Task>(managedContext)
  //     ..where((el)=>el.user!.id).equalTo(uId)
  //     ..fetchLimit=10
  //     ..offset =(pageNum-1)*10;


  //     final List<Task> list = await qGetTasks.fetch();

  //     if (list.isEmpty)
  //     {
  //       return Response.notFound(body: ModelResponse(data: [], message: "Нет ни одной задачи"));
  //     }

  //     return Response.ok(list);
  //   } catch (e) {
  //     return AppResponse.serverError(e);
  //   }
  // }






   @Operation.delete('id')
  Future<Response> deleteTask(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.path("id") int taskId,
    //@Bind.path("logical") int logical,
  ) async {
    try {
      final uId = AppUtils.getIdFromHeader(header) ;
      // Получаем id пользователя из header
      final taskData = await managedContext.fetchObjectWithID<GroupTask>(taskId);
      if(taskData?.id ==null){
        return Response.notFound(body: {
          "message":"запись не найдена"
        });
      }

      //  final qDeleteTask = Query<Task>(managedContext)
      // ..where((el)=>el.id).equalTo(taskId);
      // if(logical==1){
      //   qDeleteTask.values.isDeleted=true;
      //   qDeleteTask.update();
      // }else{
        final qDeleteTask = Query<GroupTask>(managedContext)
      ..where((el)=>el.id).equalTo(taskId);
      qDeleteTask.delete();
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