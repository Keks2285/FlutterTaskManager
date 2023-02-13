import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user.dart';
import 'package:manager_task/blocs/auth_bloc.dart';

class SignInPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  //SignInPage(String s);
  @override
  Widget build(BuildContext context) {
    String a =""; 
    return MultiBlocProvider(
     
       providers:[
         BlocProvider(
           create: 
             (context) => AuthBloc())
       ],
      
      
      child: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) {
           if(state.succes!)
            {
              a="Успешная авторизация123";
            }else{ a="не спешная авторизация";};
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
                                  Text(state.message!),
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
                                          BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent(password: passController.text, email: emailController.text));
                                        },
                                      )),
                                      




                                      //returnTextState(state)
                                     // Container(
                                      //  child:
                          
                          
                                        
                                      //)
                                      
                                ]),
                                
                          ),
                        Align(
                          
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
                                        child: 
                                        ElevatedButton(
                                          child: Text("Регистрация"),
                                          
                                          onPressed: () {
                                          Navigator.pushNamed(context,"/SignUp");}

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
