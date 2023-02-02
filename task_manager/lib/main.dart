import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build (BuildContext context ){
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
            home:Scaffold(
                backgroundColor: Color.fromARGB(255, 3, 158, 162),
                body: Align(
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                       Container(
                        margin: EdgeInsets.fromLTRB(50, 0, 50, 50),
                        child: TextFormField(
                        decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Введите почту",
                        ))),
                        Container(
                          margin: EdgeInsets.fromLTRB(50, 0, 50, 100),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Введите пароль"
                        )),
                          
                          ),
                          Container(alignment: Alignment.bottomCenter,
                          child:ElevatedButton(
                            child: Text("Войти"),
                             onPressed: ()async{
                              await Dio().put('http://127.0.0.1:8081/token', data: User(userName: 'qwe', email: 'qwe@mail.ru', password: '123'));
                             },
                            )
                          )
                    ]
                    ),
                )
            )


    );
  }

}
