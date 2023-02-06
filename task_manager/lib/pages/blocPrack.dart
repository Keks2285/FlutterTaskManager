import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/block/bloc/same_bloc.dart';
import '../models/user.dart';

class PracticPage extends StatelessWidget {
  int counter =1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  SameBloc(SameBloc_State(color: Colors.red, text: "Helgdtgtlo")))
        ],
        child: BlocBuilder<SameBloc, SameBloc_State>(
          builder: (context, state) {
            return Scaffold(
                    backgroundColor: Color.fromARGB(255, 3, 158, 162),
                    body: Align(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(50, 0, 50, 50),
                                child: TextFormField(
                                    decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Введите почту",
                                ))),
                            AnimatedContainer(
                              alignment: Alignment.center,
                              width: 100,
                              height: 50,
                              duration: Duration(microseconds: 100),
                              color: state.color,
                              child: Text(state.text??"Something"),
                            ),
                            Container(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                  child: Text("поменять на RGB random"),
                                  onPressed: () async {
                                    BlocProvider.of<SameBloc>(context).add(SameBloc_Event_ToRGB(r:Random().nextInt(255), g: Random().nextInt(255), b: Random().nextInt(255), text: counter.toString()));
                                    counter++;
                                    //   await Dio().put('http://127.0.0.1:8081/token', data: User(userName: 'qwe', email: 'qwe@mail.ru', password: '123'));
                                  },
                                )),
                                Container(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                  child: Text("поменять на красный"),
                                  onPressed: () async {
                                     BlocProvider.of<SameBloc>(context).add(SameBloc_Event_ToColor(color: Colors.blue, text: counter.toString()));
                                     counter++;
                                   
                                    //   await Dio().put('http://127.0.0.1:8081/token', data: User(userName: 'qwe', email: 'qwe@mail.ru', password: '123'));
                                  },
                                ))
                          ]),
                    ));
          },
        )
        );
  }
}
