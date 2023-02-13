import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../common/app_env.dart';
import '../models/user.dart';


class AuthBloc extends Bloc<AuthBlocEvent,AuthBlocState>{
  
  
  AuthBloc():super(AuthInitState()){
     on<AuthLoginEvent>( (AuthLoginEvent event, Emitter<AuthBlocState> emit) async  {
      //emit(AuthInitState());
      try{
        var result = 
        await DioProvider().dio.post(AppEnv.auth,data: 
          User(
            email:event.email,
            password:event.password, 
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
          emit(AuthSuccesState(message: "Успешная авторизация"));
        }
        } on DioError catch(e){
            emit(AuthFailedState(message: e.response?.data['message']??'Проблемы с сетью, проверьте подключение'  ));
        }
     });
  }






}


abstract class AuthBlocState{
  String message="Введите данные для авторизации";
  bool succes = false;
}

abstract class AuthBlocEvent{

}

class AuthLoginEvent extends AuthBlocEvent{
  //User user;
  String password;
  String email;
  AuthLoginEvent({required this.email, required this.password});
}


class AuthInitState extends AuthBlocState{
   @override
  String get mesage => super.message;
}

class AuthFailedState extends AuthBlocState{
  String message;
  @override
  bool succes = false;
  AuthFailedState({required this.message});
}

class AuthSuccesState extends AuthBlocState{
  String message;
  @override
  bool succes = true;
  AuthSuccesState({required this.message});
}


