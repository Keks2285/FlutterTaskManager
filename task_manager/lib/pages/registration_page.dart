import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/block/bloc/auth_bloc.dart';
import '../models/user.dart';

class RegistrationPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final middlenameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     
      providers:[
        BlocProvider(
          create: 
            (context) => AuthBloc(AuthBlocState(message: "авторизаnfjenjfnция", isSucces: false, countTries: 0)))
      ],
      
      
      child: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) {
           if(state.isSucces!) Navigator.pushNamed(context, '/ColorPage');
        },
        builder: (context, state) {
          return  Scaffold(
                    backgroundColor: Color.fromARGB(255, 3, 158, 162),
                    body: Align(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(50, 0, 50, 50),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Введите почту",
                                ))),
                            Container(
                              margin: EdgeInsets.fromLTRB(50, 0, 50, 100),
                              child: TextFormField(
                                controller: passController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Введите пароль")),
                            ),
                            Container(
                              color: Colors.black,
                              margin: EdgeInsets.fromLTRB(50, 0, 50, 100),
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  // ignore: prefer_const_constructors
                                  style: ButtonStyle(
                                    ),
                                  child: Text("Войти"),
                                  onPressed: () async {
                                    BlocProvider.of<AuthBloc>(context).add(tryGetAccesEvent(password: passController.text, email: emailController.text, count: state.countTries!+1));
                                   // if(emailController.text.length<5 || passController.text.length<5)
                                     // BlocProvider.of<AuthBloc>(context).add(accessDeniedEvent(count:state.countTries!+1));

                                     
                                    //await Dio().put('http://127.0.0.1:8081/token', data: User(userName: 'qwe', email: 'qwe@mail.ru', password: '123'));
                                  },
                                )),
                                Text(state.message!+ (state.countTries==0?"":" Количество попыток: ${5-state.countTries!}"))
                          ]),
                    ));
          },)
    );
  }
}
