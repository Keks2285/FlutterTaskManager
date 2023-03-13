import 'dart:math';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_task/common/app_env.dart';
import 'package:manager_task/presentation/customWidgets/customCheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user.dart';
import 'package:manager_task/presentation/blocs/auth_bloc.dart';
import 'dart:developer' as developer;

import '../../data/repositories/auth_repo.dart';

class SignInPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String message="";
  late var prefs;
  bool rememberMe=false;
  
  
  Future prefsInit()async{
         prefs = await SharedPreferences.getInstance();
        developer.log(prefs.getString("email")?? prefs.getString("email")??" ", name: "mylog");
        developer.log(prefs.getString("userRefreshtoken")?? prefs.getString("accesToken")??" ", name: "mylog");
    }
  
  //SignInPage(String s);
  @override
  Widget build(BuildContext context) {
    
    final isEntering = (ModalRoute.of(context)?.settings.arguments??true) as bool;


      prefsInit().then((value)async{
       if(prefs.containsKey('email')&&prefs.containsKey('accesToken') && isEntering){
         AppEnv.userEmail=prefs.getString('email');
         AppEnv.userRefreshtoken=prefs.getString('accesToken');
         Navigator.pushReplacementNamed(context,"/ListTasks");
      }
    });




    //String a =""; 
    return MultiBlocProvider(
     
       providers:[
         BlocProvider(
           create: 
             (context) => AuthBloc())
       ],
      
      
      child: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) {
           if(state.succes)
            {
              Navigator.pushReplacementNamed(context,"/ListTasks");
            }
        },
        builder: (context, state) {
          return  Scaffold(
                    backgroundColor: Color.fromARGB(255, 3, 158, 162),
                    
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin:  EdgeInsets.fromLTRB(0, 100, 00, 50),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(50, 10, 50, 50),
                                      child: TextFormField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Введите почту",
                                      ))),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(50, 0, 50, 50),
                                    child: TextFormField(
                                      controller: passController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "Введите пароль")),
                                  ),
                                  Text(message==""? state.message : message),
                                  Container(
                                    //color: Colors.black,
                                    margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 100,
                                          child: Text("Войти")
                                          ),
                                        onPressed: () async {
                                          BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent(password: passController.text, email: emailController.text, remember: rememberMe));
                                        },
                                      )),
                                      




                                      //returnTextState(state)
                                     // Container(
                                      //  child:
                          
                          
                                        
                                      //)
                                      
                                ]),
                                
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Запомнить меня"),
                                MyCheckBox(
                                  onChanged: () {
                                    rememberMe=!rememberMe;
                                  },
                                ),
                              ],
                          ),
                        Align(
                          
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
                                        child: 
                                        ElevatedButton(
                                          child: Text("Регистрация"),
                                          
                                          onPressed: () {
                                          Navigator.pushNamed(context,"/SignUp");
                                          //prefsInit();
                                          }

                                        ),
                                      ),
                          
                          )
                              
                            
                        ],
                      ),

                      
                    );
          },)
    );
  }



  // Widget returnTextState( AuthBlocState state){
  //   if(state is AuthFailedState){
  //     return Text(state.message);
  //   }
  //   return Text(state.message);
  // }



}
