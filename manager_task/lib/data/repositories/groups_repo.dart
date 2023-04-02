import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import '../../common/app_env.dart';
import '../../core/error/failure.dart';
import '../models/group.dart';
import '../models/user.dart';

class GroupsRepo{

  static List<Group> allGroups=[];
  Future<Either<String, int>> LoadGroups() async{
    try{
      var result = await DioProvider().dio.get( 
          '/groups',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer ${AppEnv.userRefreshtoken}",
          })
        );
        
        result.data.forEach((item){
          allGroups.add(
            Group(
              id: item["id"], 
              namegroup: item["nameGroup"], 
              adminid: item["adminid"]));
        });
     return Right(1);
    }on DioError catch(e){
      return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
    }

  }
}