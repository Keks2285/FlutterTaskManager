import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:manager_task/presentation/pages/createTaskPage.dart';
import 'package:manager_task/presentation/pages/signInPage.dart';
import 'package:manager_task/presentation/pages/signUpPage.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        //FinanceData.routeName: (context) => const FinanceData(),
        "/SignIn": (context) => SignInPage(),
        "/SignUp":  (context) => SignUpPage(),
        "/CreateTask":  (context) => CreateTaskPage()
        //SignIn.routeName: (context) => const SignIn()
      },
      home:  SignInPage(),
    );
  }
}