import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:manager_task/presentation/pages/createTaskPage.dart';
import 'package:manager_task/presentation/pages/groupListPage.dart';
import 'package:manager_task/presentation/pages/groupTasksPage.dart';
import 'package:manager_task/presentation/pages/mainPage.dart';
import 'package:manager_task/presentation/pages/notifiesPage.dart';
import 'package:manager_task/presentation/pages/personAttachmentListPage.dart';
import 'package:manager_task/presentation/pages/signInPage.dart';
import 'package:manager_task/presentation/pages/signUpPage.dart';
import 'dart:developer' as developer;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:manager_task/presentation/pages/taskList.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'firebase_options.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async{
   

   WidgetsFlutterBinding.ensureInitialized();
    tz.initializeTimeZones();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
    final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings  initializationSettingsIOS =
      DarwinInitializationSettings();
  final InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  
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
        "/Notifies":  (context) => NotifiesPage()
        //SignIn.routeName: (context) => const SignIn()
      },
      home:  SignInPage(),
    );
  }
}