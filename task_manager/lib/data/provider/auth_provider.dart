import 'package:dio/dio.dart';

class AuthProvider{
  Future signIn(String email, String password) async{
    Dio dio = Dio();
    Response responce = await Dio().get("http://localhost:8080/token",
    queryParameters: {'email':email,'password':password});
    return responce.data;
  }
}