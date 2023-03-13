import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_task/data/repositories/task_repo.dart';
import '../../common/app_env.dart';
import '../../data/models/user.dart';
import 'package:manager_task/presentation/blocs/registration_bloc.dart';
import 'dart:developer' as developer;

import '../blocs/tasklist_bloc.dart';

class TaskListPage extends StatelessWidget {
  bool isCanLoadMore = true;
  bool stop =false;
  int totalValueItems=0;
  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => TaskListBloc(),
      child: BlocConsumer<TaskListBloc, TaskListBlocState>(
        listener: (context, state) {
          if(!state.succes&& !stop){
            
              showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  child: Text(state.message),
                  height: 100, color: Colors.lightBlue);
              });
          }
          stop=true;
        },
        builder: (context, state) {
          if(state.nameState=="init" &&!stop)
             BlocProvider.of<TaskListBloc>(context).add(TaskListInitEvent());


          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/SignIn",
                          arguments: false);
                    }),
              ],
              title: Text('ToDoList'),
            ),

            body: ListView.builder(
              itemCount: state.taskList.length,
              itemBuilder: (BuildContext context,int index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: 30,
                    color: Colors.amber,
                    child: Text(
                      "${state.taskList[index].description!.length<10?state.taskList[index].description:"${state.taskList[index].description!.substring(0,10)}..."} ${state.taskList[index].dateTask.toString().replaceAll(".000Z", "")}")
                    )
                );
              } ,

            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, "/CreateTask");
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add_box_outlined),
            ),
          );
        },
      ),
    );
  }
}
