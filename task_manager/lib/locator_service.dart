import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


final sl = GetIt.instance;

Future<void> init() async{

  sl.registerLazySingleton(()=>(){});

  sl.registerLazySingleton(
    ()=> Dio(
      BaseOptions(
        sendTimeout: 1500, 
        connectTimeout: 1500,
        receiveTimeout: 1500,
        baseUrl: '${AppEnv.protocol}://${AppEnv.ip}',
      ),
    )
  );
}



abstract class AppEnv{
  static const String protocol = 'http';
  static const String ip = '127.0.0.1:8081';
  static const String auth = '/token';
  static const String user = '/user';
  static const String finance = '/finance';
}