import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:manager_task/data/repositories/auth_repo.dart';

import '../../common/app_env.dart';
import '../../data/models/user.dart';


class AuthBloc extends Bloc<AuthBlocEvent,AuthBlocState>{
  
  
  AuthBloc():super(AuthInitState()){
     on<AuthLoginEvent>((AuthLoginEvent event, Emitter<AuthBlocState> emit) async  {
        var authResult = await AuthRepo().signIn(event.email, event.password, event.remember);
        authResult.fold(
          (l) => emit(AuthFailedState(message: l)),
          (r) => emit(AuthSuccesState(message: "Успешная авторизация",user:r))
        );
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
  bool remember; 
  AuthLoginEvent({required this.email, required this.password, required this.remember});
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
  User user;
  String message;
  @override
  bool succes = true;
  AuthSuccesState({required this.message, required this.user});
}


