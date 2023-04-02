import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_task/common/search.dart';
import 'package:manager_task/data/models/task.dart';
import 'package:manager_task/data/repositories/task_repo.dart';
import '../../common/app_env.dart';
import '../../data/models/user.dart';
import 'package:manager_task/presentation/blocs/registration_bloc.dart';
import 'dart:developer' as developer;

import '../blocs/tasklist_bloc.dart';


class GroupListPage extends StatefulWidget {
  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  bool stop = false;
  //bool isRedirected =false;
  bool _searchBoolean = false;
  //int totalValueItems = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskListBloc(),
      child: BlocConsumer<TaskListBloc, TaskListBlocState>(
        listener: (context, state) {
          if (!state.succes && !stop) {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                      child: Text(state.message),
                      height: 100,
                      color: Colors.lightBlue);
                });
          }
          stop = true;
        },
        builder: (context, state) {
          if (state.nameState == "init" && !stop && (ModalRoute.of(context)?.settings.arguments??true) as bool)
            BlocProvider.of<TaskListBloc>(context).add(TaskListInitEvent());

          return Scaffold(
            appBar: AppBar(
              title: Text("My Groups"),
            ),
          
            body: 
             Column(
               children: [
                //  Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [

                //       IconButton(
                //         onPressed: () {
                //         },
                //         icon: Icon(Icons.group, size: 40,),
                //         color: Colors.green,
                //       ),


                //     IconButton(
                //         onPressed: () {
                //           try {
                //             state.taskList.clear();
                //           } catch (e) {}
                //           //TaskRepo.allTasks.clear();
                //           //BlocProvider.of<TaskListBloc>(context).add(TaskListInitEvent());
                //           //TaskRepo.allTasks.clear();
                //           //TaskListBlocState.taskList.clear();
                //           Navigator.pushNamed(context, "/CreateTask");
                //         },
                //         icon: Icon(Icons.add_box_outlined, size: 40,),
                //         color: Colors.green,
                //       ),
                    
                //   ],
                // ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 4, 10, 0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 173, 187, 201),
                            border: Border.all(color: Colors.black12, width: 2)
                          ),
                          child:   Container(
                            height: 60,
                            child: GestureDetector(
                            
                                    onTap: (){
                                       developer.log(AppEnv.userRefreshtoken, name: "mylog");
                                    },
                                    child: Container(
                                      
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Группа 2"),
                                          IconButton(
                                              onPressed: () {
                                                // BlocProvider.of<TaskListBloc>(context).add(
                                                //     TaskDeleteEvent(
                                                //         id: state.taskList[index].id));
                                              },
                                              icon: Icon(Icons.exit_to_app))
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                              
                        ),
                      );
                    },
                  ),
                ),
               
               ],
             ),
          );
        },
      ),
    );
  }

  Widget _searchTextField(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        BlocProvider.of<TaskListBloc>(context)
            .add(TaskSearchEvent(query: value));
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }
}
