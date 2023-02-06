import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:task_manager/pages/blocPrack.dart';
import 'package:task_manager/pages/firstPage.dart';
import 'models/user.dart';

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
        "/FirstPage": (context) => Firstpage(),
        "/ColorPage":  (context) => PracticPage()
        //SignIn.routeName: (context) => const SignIn()
      },
      home:  Firstpage(),
    );
  }
}

