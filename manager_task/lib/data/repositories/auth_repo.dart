import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../common/app_env.dart';
import '../../core/error/failure.dart';
import '../models/user.dart';
class AuthRepo{
  Future<Either<String, User>> signIn(String email, String password) async {

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
            return Right(data);
          }else{
            return Left(DefaultFailure().errorMessage);
          }
    } on DioError catch(e){
        //if(e.)
            return Left(e.response?.data['message']??'Проблемы с сетью, проверьте подключение');
      }
    }
}



class RegRepo{

}