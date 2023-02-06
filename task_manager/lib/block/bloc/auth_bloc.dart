import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState>{
  AuthBloc(AuthBlocState authBlocState):super(AuthBlocState(message: "Введите данные для авторизации", isSucces: false, countTries: 0)){
    on((tryGetAccesEvent event, Emitter<AuthBlocState> emit) => {
      if (event.email.length>5 && event.password.length>5){
        emit(AuthBlocState(message: "Доступ разрешен", isSucces: true, countTries: 0))
      } else{ // не работает
        emit(AuthBlocState(message: "Доступ запрещен", isSucces: false, countTries: event.count++))
      }
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
  String message="";
  bool? isSucces=false;
  int? countTries=0;

  AuthBlocState({required this.message, this.isSucces, this.countTries});

}

