import 'package:dio/dio.dart';

abstract class AppEnv{
  static const String protocol = 'http';
  static const String ip = '192.168.1.51:8080';
  static const String auth = '/token';
  static const String user = '/user';
  static const String finance = '/finance';
  static String userRefreshtoken='';
  static String userEmail="";
  static int userId=0;
}

 class DioProvider{
  
final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://"+ AppEnv.ip,
      connectTimeout: 4000,
      receiveTimeout: 4000,
      sendTimeout: 4000
      )
  );
}