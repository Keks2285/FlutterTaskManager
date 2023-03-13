import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import '../../common/app_env.dart';
import '../../core/error/failure.dart';
import '../models/task.dart';
import 'dart:convert';

class TaskRepo{

  static List<ToDoTask> allTasks=[];

   Future<Either<String, int>> Load10Tasks( int page) async {
     try{
        var result = await DioProvider().dio.get( 
          '/task/${page}',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${AppEnv.userRefreshtoken}",
          })
        );
        //var data = ToDoTask.fromJson(result.data['data']);
        if(result.statusCode == 200){
        List<ToDoTask> taskObjs=[];
        //  var taskObjsJson = jsonDecode(result.data.toString())['data'] as List;
          result.data.forEach((item){

            taskObjs.add(
              ToDoTask(
                id: item["id"],
                description: item["description"], 
                tag: item["tag"],
                dateTask: DateTime.parse(item["dateTask"])
              )
            );
            allTasks.addAll(taskObjs);
          });
          return Right(taskObjs.length);
        }else{
          return Left(DefaultFailure().errorMessage);
        }
     } on DioError catch (e){
        return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
     } 

   }
  

  Future<Either<String, int>> CreateTask( ToDoTask task) async{
    try{

      var result = await DioProvider().dio.post( 
          '/task',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${AppEnv.userRefreshtoken}",
          }),
          data: task
        );
      allTasks.add(task);
      return Right(1);
    } on DioError catch (e){
      return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
    }
  }
  // Future<Either<String, String>> CreateTask(ToDoTask task) async {


  // }
}
