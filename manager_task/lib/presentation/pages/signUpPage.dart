import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user.dart';
import 'package:manager_task/presentation/blocs/registration_bloc.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final repPassController = TextEditingController();
  final firstnameC = TextEditingController();
  final lastnameC = TextEditingController();
  final middlenameC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => RegBloc())],
        child: BlocConsumer<RegBloc, RegBlocState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
             
                backgroundColor: Color.fromARGB(255, 3, 158, 162),
                body: Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(50, 30, 50, 10),
                              child: TextFormField(
                                  validator: (value) {
                                    if ((value ?? '').isEmpty)
                                      return 'Пожалуйста введите свой Email';

                                    String p =
                                        r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$";
                                    RegExp regExp = new RegExp(p);

                                    if (regExp.hasMatch(value!)) return null;

                                    return 'Неверный формат почты';
                                  },
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Введите почту",
                                  ))),
                          Container(
                            margin: EdgeInsets.fromLTRB(50, 0, 50, 10),
                            child: TextFormField(
                                validator: (value) {
                                  if (value == null ||value.length < 6) {
                                    return "Пароль должен быть от 6 символов";
                                  }

                                  if(!value.contains(RegExp(r'[A-Z]'))){
                                      return "Пароль должен содержать латинские заглавные буквы";
                                  }
                                  if(!value.contains(RegExp(r'[a-z]'))){
                                      return "Пароль должен содержать латинские строчные буквы";
                                  }

                                  if(!value.contains(RegExp(r'[0-9]'))){
                                      return "Пароль должен содержать цифру";
                                  }

                                  if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
                                      return "Пароль должен содержать спецсимвол";
                                  }
                                  
                                },
                                controller: passController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Введите пароль")),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(50, 0, 50, 10),
                            child: TextFormField(
                              validator: (value) {
                                  if(value!=passController.text) return"Пароли не совпадают";
                              },
                                controller: repPassController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Повторите пароль")),
                          ),
                          
                          Container(
                            margin: EdgeInsets.fromLTRB(50, 0, 50, 10),
                            child: TextFormField(
                              validator:(value)  {

                                  if (value == null || value =="") return"Заполните фио";


                                    if(!value.contains(RegExp(r'^[а-яА-ЯёЁ]+$'))) return "Разрешена только кириллица";
                              },
                                controller: firstnameC,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Введите фамилию")),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(50, 0, 50, 10),
                            child: TextFormField(
                                controller: lastnameC,
                                validator:(value)  {

                                  if (value == null || value =="") return"Заполните фио";


                                    if(!value.contains(RegExp(r'^[а-яА-ЯёЁ]+$'))) return "Разрешена только кириллица";
                              },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Введите имя")),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(50, 0, 50, 40),
                            child: TextFormField(
                                controller: middlenameC,
                                validator:(value)  {

                                  
                                    if( value!=null &&value!=""&& !value.contains(RegExp(r'^[а-яА-ЯёЁ]+$'))) return "Разрешена только кириллица";
                              },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Введите отчество")),
                          ),
                          Text(state.message!),
                          Container(
                              //color: Colors.black,
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                child: Text("Зарегестрироваться"),
                                onPressed: () async {
                                  if (!_formKey.currentState!.validate())
                                    return;

                                  BlocProvider.of<RegBloc>(context).add( /////
                                      RegBlocEvent(
                                          password: passController.text,
                                          email: emailController.text,
                                          firstname: firstnameC.text,
                                          lastname: lastnameC.text,
                                          middlename: middlenameC.text,
                                          repeatPassword:
                                              repPassController.text));
                                },
                              )),
                          //returnTextState(state)
                          // Container(
                          //  child:

                          //)
                        ]),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushNamed(context, "/SignIn");
                    }));
          },
        ));
  }

  // Widget returnTextState( AuthBlocState state){
  //   if(state is AuthFailedState){
  //     return Text(state.message);
  //   }
  //   return Text(state.message);
  // }
}

