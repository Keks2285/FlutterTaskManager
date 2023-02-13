import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_manager/data/provider/auth_provider.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState>{
  AuthBloc(AuthBlocState authBlocState):super(AuthBlocState(message: "Введите данные для авторизации", isSucces: false, countTries: 0)){
    
    
    //final Dio dio;
    
    on( (tryGetAccesEvent event, Emitter<AuthBlocState> emit) async  {

        emit(AuthBlocState(message: "", isSucces: true, countTries: 0));
      
    });



  on((accessDeniedEvent event, Emitter<AuthBlocState> emit) => {
        emit(AuthBlocState(message: "Доступ запрещен", isSucces: false, countTries: event.count++))
      
    });




  }
}

abstract class AuthBlocEvent{

}

class tryGetAccesEvent  extends AuthBlocEvent{
  String password;
  String email;
  int count=0;
  tryGetAccesEvent({required this.password, required this.email, required this.count});
}


class accessGrantedEvent extends AuthBlocEvent{
 
}

class accessDeniedEvent extends AuthBlocEvent{
   int count=0;
   accessDeniedEvent({ required this.count});
}
class AuthBlocState{
  String? message="";
  bool? isSucces=false;
  int? countTries=0;

  AuthBlocState({ this.message, this.isSucces, this.countTries});

}

