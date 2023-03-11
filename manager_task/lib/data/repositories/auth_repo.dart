import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import '../../common/app_env.dart';
import '../../core/error/failure.dart';
import '../models/user.dart';
class AuthRepo{
  Future<Either<String, User>> signIn(String email, String password, bool remember) async {
  var prefs = await SharedPreferences.getInstance();
    try{
      var result = 
          await DioProvider().dio.post(AppEnv.auth,data: 
            User(
              email:email,
              password:password, 
              firstname: "", 
              lastname: "",
              middlename: "",
              accessToken: "",
              refreshToken: ""));

          var data = User.fromJson(result.data['data']);
          if(result.statusCode == 200){
            if(data.refreshToken == null){
              throw DioError(requestOptions: RequestOptions(path: ''),error: 'Токен равен нулю');
            }
            //prefs.clear();
            if(remember){
              prefs.setString("email", data.email);
              prefs.setString("accesToken", data.accessToken!);
              developer.log(data.email, name: "mylog");
              developer.log(data.accessToken!, name: "mylog");
            }
              

            return Right(data);
          }else{
            return Left(DefaultFailure().errorMessage);
          }
    } on DioError catch(e){
        //if(e.)
            return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
      }
    }


  Future<Either<String, User>> signUp(User user) async {
    try{


      var result = 
        await DioProvider().dio.put(AppEnv.auth,data: user);
        var data = User.fromJson(result.data['data']);
        if(result.statusCode == 200){
          if(data.refreshToken == null){
            throw DioError(requestOptions: RequestOptions(path: ''),error: 'Токен равен нулю');
          }

          return Right(user);
        }else{
          return Left(DefaultFailure().errorMessage);
        }

    }on DioError catch(e){
        return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
    }
  }


}

