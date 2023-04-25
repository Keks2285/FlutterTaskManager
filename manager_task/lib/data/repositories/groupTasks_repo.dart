import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import '../../common/app_env.dart';
import '../../core/error/failure.dart';
import '../models/group_task.dart';
import '../models/task.dart';
import 'dart:convert';

class GroupTaskRepo{

  static List<GroupTask> allTasks=[];

   Future<Either<String, int>> LoadGroupTasks(int idGroup) async {
     try{
        var result = await DioProvider().dio.get( 
          '/groupTasks/${idGroup}',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${AppEnv.userRefreshtoken}",
          })
        );
        //var data = ToDoTask.fromJson(result.data['data']);
        if(result.statusCode == 200){
        List<GroupTask> taskObjs=[];
        //  var taskObjsJson = jsonDecode(result.data.toString())['data'] as List;
          result.data.forEach((item){

            taskObjs.add(
              GroupTask(
                id: item["id"],
                description: item["description"], 
                completedBy: item["completedBy"],
                dateTask: DateTime.parse(item["dateTask"])
              )
            );
            
          });

          // taskObjs.forEach((element) { 
          //     if(!allTasks.contains(element.id));
          //       allTasks.add(element);
          // });

          allTasks.addAll(taskObjs);
          return Right(taskObjs.length);
        }else{
          return Left("Время сессии истекло, необходимо войти повторно");
        }
     } on DioError catch (e){
        return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
     } 

   }
  

  Future<Either<String, int>> CreateTask({ required Map<String, String> dataTask, required int idGroup}) async{
    try{

      var result = await DioProvider().dio.post( 
          '/groupTasks/${idGroup}',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${AppEnv.userRefreshtoken}",
          }),
          data: {
            "description":dataTask["description"],
            "dateTask":dataTask["dateTask"]
          }
        );
      allTasks.add(GroupTask(completedBy: "-", dateTask: result.data["dateTask"], id:result.data["id"], description: result.data["description"]));
      return Right(1);
    } on DioError catch (e){
      return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
    }
  }
  
  

   Future<Either<String, int>> Deletetask( int id) async {
    try{
      var result = await DioProvider().dio.delete( 
          '/groupTasks/${id}',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${AppEnv.userRefreshtoken}",
          }),
        );
        allTasks.removeWhere((element) => element.id==id);
        return Right(1);

    } on DioError catch (e){
       

         return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
    }
   }


   Future<Either<String, int>> CompleteTask( {required int id}) async {
    try{
      var result = await DioProvider().dio.put( 
          '/groupTasks/${id}',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${AppEnv.userRefreshtoken}",
          }),
        );
        GroupTask updated=GroupTask(
          id: allTasks.lastWhere((element) => element.id==id).id,
          description: allTasks.lastWhere((element) => element.id==id).description,
          dateTask: allTasks.lastWhere((element) => element.id==id).dateTask,
          completedBy: AppEnv.userEmail
          );
        int index =allTasks.indexWhere((element) => element.id==id);
        allTasks[index]=updated;
        return Right(1);

    } on DioError catch (e){
       
        
         return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
    }
   }
}
