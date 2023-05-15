import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:manager_task_web/data/models/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import '../../common/app_env.dart';
import '../../core/error/failure.dart';
import '../models/group.dart';
import '../models/user.dart';

class ComentsRepo{

  static List<Comment> allComments=[];
  Future<Either<String, int>> LoadComments() async{
    try{
      var result = await DioProvider().dio.get( 
          '/comments/${AppEnv.selectedGroupTask}',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${AppEnv.userRefreshtoken}",
          })
        );
        
        result.data.forEach((item){
          allComments.add(
            Comment(
              id: item["id"]  , 
              comment: item["stringComment"], 
              email: item["authorEmail"],
              dateComment:  DateTime.parse(item["dateComment"])
              ));
        });
     return Right(1);
    }on DioError catch(e){
      return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
    }

  }




  Future<Either<String, int>> deleteComment(int commentId) async{
    try{
      var result = await DioProvider().dio.delete( 
          '/comments/${commentId}',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${AppEnv.userRefreshtoken}",
          })
        );

         allComments.removeWhere((element) => element.id==commentId);
     return Right(1);
    }on DioError catch(e){
      return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
    }

  }



  Future<Either<String, int>> createComment(String comment) async{
    try{
      var result = await DioProvider().dio.put( 
          "/comments/${AppEnv.selectedGroupTask}",
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${AppEnv.userRefreshtoken}",
          }),
          data: {
            'stringComment': comment
          }
        );
         allComments.add(
            Comment(
              id: result.data["data"]["id"]  , 
              comment: result.data["data"]["stringComment"], 
              email: result.data["data"]["authorEmail"],
              dateComment:  DateTime.now()
              ));
     return Right(1);
    }on DioError catch(e){
      if(e.response?.data['message']=='entity_already_exists')return Left('Группа с таким названием уже существует');
      return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
    }

  }




  // Future<Either<String, int>> joinGroup(String nameGroup) async{
  //   try{
  //     var result = await DioProvider().dio.post( 
  //         '/groups/${nameGroup}',
  //         options: Options(headers: {
  //           "Content-Type": "application/json",
  //           "Authorization":
  //               "Bearer ${AppEnv.userRefreshtoken}",
  //         })
  //       );
  //        allGroups.add(
  //           Group(
  //             id: result.data["id"] , 
  //             namegroup: result.data["nameGroup"], 
  //             adminid: result.data["adminid"]));
  //    return Right(1);
  //   }on DioError catch(e){

  //     if(e.response?.data['message']=='non_null_violation')return Left('Такой группы не существует');

  //     return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
  //   }

  // }


}