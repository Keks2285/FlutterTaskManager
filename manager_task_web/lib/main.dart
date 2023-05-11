import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:manager_task_web/presentation/pages/commentsPage.dart';
import 'package:manager_task_web/presentation/pages/createTaskPage.dart';
import 'package:manager_task_web/presentation/pages/groupAttachmentListPage.dart';
import 'package:manager_task_web/presentation/pages/groupListPage.dart';
import 'package:manager_task_web/presentation/pages/groupTasksPage.dart';
import 'package:manager_task_web/presentation/pages/mainPage.dart';
import 'package:manager_task_web/presentation/pages/personAttachmentListPage.dart';
import 'package:manager_task_web/presentation/pages/signInPage.dart';
import 'package:manager_task_web/presentation/pages/signUpPage.dart';
import 'dart:developer' as developer;

import 'package:manager_task_web/presentation/pages/taskList.dart';

import 'firebase_options.dart';


void main() async{
   

   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        //FinanceData.routeName: (context) => const FinanceData(),z
        "/SignIn": (context) => SignInPage(),
        "/SignUp":  (context) => SignUpPage(),
        "/CreateTask":  (context) => CreateTaskPage(),
        "/Groups":(context) => GroupListPage(),
        "/ListTasks":  (context) => TaskListPage(),
        "/GroupTasks":  (context) => GroupTasksPage(),
        "/PersonAtachments":  (context) => PersonAttachmentsListPage(),
        "/GroupAtachments":  (context) => GroupAttachmentsListPage(),
        "/CommentsPage":  (context) => CommentsPage()
        //SignIn.routeName: (context) => const SignIn()
      },
      home:  SignInPage(),
    );
  }
}