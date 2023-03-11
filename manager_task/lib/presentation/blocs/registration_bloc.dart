import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/app_env.dart';
import '../../data/models/user.dart';
import '../../data/repositories/auth_repo.dart';

class RegBloc extends Bloc<RegBlocEvent, RegBlocState>{
  RegBloc():super(RegInitState()){
    on<RegBlocEvent>((RegBlocEvent event, Emitter<RegBlocState> emit) async{

          User newUser=  User(
            email:event.email,
            password:event.password, 
            firstname: event.firstname, 
            lastname: event.lastname,
            middlename: event.middlename??'',
            accessToken: "",
            refreshToken: "");

          var authResult = await AuthRepo().signUp(newUser);



            authResult.fold(
              (l) => emit(RegFailedState(message: l)),
              (r) => emit(RegSuccesState(message: "Успешная авторизация"))
            );





      //  try{
      //   // var result = 
      //   // await DioProvider().dio.put(AppEnv.auth,data: 
      //   //   User(
      //   //     email:event.email,
      //   //     password:event.password, 
      //   //     firstname: event.firstname, 
      //   //     lastname: event.lastname,
      //   //     middlename: event.middlename??'',
      //   //     accessToken: "",
      //   //     refreshToken: ""));
      //   //// тут переделать(перенести в репозиторий)
      //   // var data = User.fromJson(result.data['data']);
      //   // if(result.statusCode == 200){
      //   //   if(data.refreshToken == null){
      //   //     throw DioError(requestOptions: RequestOptions(path: ''),error: 'Токен равен нулю');
      //   //   }
      //     emit(RegSuccesState(message: "Успешная регистрация"));
      //   }
      //   } on DioError catch(e){

      //     if( e.response?.data['message']=="entity_already_exists"){
      //       emit(RegFailedState(message: 'Почта уже используется в системе'));
      //     } else{
      //       emit(RegFailedState(message: e.response?.data['message'] ??'Проблемы с сетью проверьте подключение`'));
      //     }
            
      //   }

    });
  }
 
}


 class RegBlocEvent{
  String email;
  String password;
  String repeatPassword;
  String firstname;
  String lastname;
  String? middlename;
  RegBlocEvent({
    required this.email, 
    required this.firstname,
    required this.lastname,
    this.middlename,
    required this.repeatPassword,
    required this.password
  });
}

abstract class RegBlocState{
  String message ="Введите данные регистрации";
  bool succes = false;
}


class RegInitState extends RegBlocState{
  @override
  String get message => super.message;
  @override
  bool get succes => super.succes;
}

class RegSuccesState extends RegBlocState{
  String message;
  bool succes=true;
  RegSuccesState({required this.message});
}


class RegFailedState extends RegBlocState{
  String message;
  bool succes=false;
  RegFailedState({required this.message});
}

