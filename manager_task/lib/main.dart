import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:manager_task/presentation/pages/createTaskPage.dart';
import 'package:manager_task/presentation/pages/groupListPage.dart';
import 'package:manager_task/presentation/pages/mainPage.dart';
import 'package:manager_task/presentation/pages/signInPage.dart';
import 'package:manager_task/presentation/pages/signUpPage.dart';
import 'dart:developer' as developer;

import 'package:manager_task/presentation/pages/taskList.dart';


void main() {
  
   WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        //FinanceData.routeName: (context) => const FinanceData(),z
        "/SignIn": (context) => SignInPage(),
        "/SignUp":  (context) => SignUpPage(),
        "/CreateTask":  (context) => CreateTaskPage(),
        "/Groups":(context) => GroupListPage(),
        "/ListTasks":  (context) => TaskListPage()
        //SignIn.routeName: (context) => const SignIn()
      },
      home:  SignInPage(),
    );
  }
}