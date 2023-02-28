// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user.dart';
import 'package:manager_task/presentation/blocs/registration_bloc.dart';

//import '../blocs/auth_bloc.dart';
import '../blocs/create_task_bloc.dart';

class CreateTaskPage extends StatelessWidget {
  final descriptionController = TextEditingController();
  DateTime selectedDateTime = DateTime.now().add(Duration(days: 1));
  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);

  //CreateTaskPage({super.key});
    void _showPicker(BuildContext context){
        showDatePicker(context: context, 
        initialDate: selectedDateTime ,
        firstDate: selectedDateTime,
        lastDate: DateTime.now().add(Duration(days: 1095)))
        .then((value) => {
          selectedDateTime=value??DateTime.now()
        }).then((value) => {
          showTimePicker(context: context, initialTime: TimeOfDay.now())
          });
    }
  //final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTaskBloc(),
        child: BlocBuilder<CreateTaskBloc, CreateTaskBlocState>(
            builder: (context, state) {
              return Scaffold(
                  backgroundColor: Color.fromARGB(255, 3, 158, 162),
                  body: Column(
                    children: [
                      // ignore: prefer_interpolation_to_compose_strings
                      Text(state.dateTime),
                      Container(
                          //color: Colors.black,
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            child: Container(
                                alignment: Alignment.center,
                                width: 100,
                                child: Text("Выберите дату")),
                            onPressed: ()  {
                              _showPicker(context);
                             BlocProvider.of<CreateTaskBloc>(context).add(CreateTaskBlocEvent(dateTime: selectedDateTime, timeOfDay: selectedTime));
                            },
                          )),
                    ],
                  ));
            }));
  }
}
