import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_task_web/common/search.dart';
import 'package:manager_task_web/data/models/task.dart';
import 'package:manager_task_web/core/usecase/firestore_person_attacments.dart';
import 'package:manager_task_web/data/repositories/groups_repo.dart';
import 'package:manager_task_web/data/repositories/personAttacment_repo.dart';
import 'package:manager_task_web/data/repositories/task_repo.dart';
import '../../common/app_env.dart';
import '../../data/models/user.dart';
import 'package:manager_task_web/presentation/blocs/registration_bloc.dart';
import 'dart:developer' as developer;

import '../../data/repositories/groupTasks_repo.dart';
import '../blocs/tasklist_bloc.dart';

class TaskListPage extends StatefulWidget {
  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
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
          if (state.nameState == "init" && !stop && (ModalRoute.of(context)?.settings.arguments??true )as bool)
            BlocProvider.of<TaskListBloc>(context).add(TaskListInitEvent());

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
                //title: _searchTextField(context),
                //title:  _searchTextField(),
                title:
                    !_searchBoolean ? Text("ToDo") : _searchTextField(context),
                actions: !_searchBoolean
                    ? [
                        IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                _searchBoolean = true;
                              });
                            }),
                        IconButton(
                            icon: const Icon(Icons.logout),
                            onPressed: () {
                              TaskRepo.allTasks.clear();
                              GroupTaskRepo.allTasks.clear();
                              GroupsRepo.allGroups.clear();
                              Navigator.pushReplacementNamed(context, "/SignIn",arguments: false);
                            })
                      ]
                    : [
                        IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchBoolean = false;
                                BlocProvider.of<TaskListBloc>(context).add(TaskSearchEvent(query:""));
                              });
                            })
                      ]
                // actions:  [

                //   IconButton(
                //             icon: const Icon(Icons.logout),
                //             onPressed: () {
                //               TaskRepo.allTasks.clear();
                //               Navigator.pushReplacementNamed(context, "/SignIn",
                //                   arguments: false);
                //             })
                // ]
                ),
            body: 
             Column(
               children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 151, 205, 255),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            
                              child: Container(
                                constraints: BoxConstraints(
                                        minWidth: MediaQuery.of(context).size.width-20,
                                        ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        "${state.taskList[index].tag}\n${"${state.taskList[index].description!}\n"}\n ${state.taskList[index].dateTask.toString().replaceAll(".000Z", "")}"),
                                    
                                    IconButton(
                                        onPressed: () {
                                          
                                          Navigator.pushNamed(context, "/PersonAtachments");
                                          AppEnv.selectedPersonalTask=state.taskList[index].id.toString();
                                        },
                                        icon: Icon(Icons.attach_file)),
                                        IconButton(
                                        onPressed: () {
                                          BlocProvider.of<TaskListBloc>(context).add(
                                              TaskDeleteEvent(
                                                  id: state.taskList[index].id));
                                        },
                                        icon: Icon(Icons.delete_forever_outlined))
                                  ],
                                ),
                              ),
                            
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/Groups");
                        },
                        icon: Icon(Icons.group, size: 40,),
                        color: Colors.green,
                      ),


                    IconButton(
                        onPressed: () {
                          try {
                            state.taskList.clear();
                          } catch (e) {}
                          //TaskRepo.allTasks.clear();
                          //BlocProvider.of<TaskListBloc>(context).add(TaskListInitEvent());
                          //TaskRepo.allTasks.clear();
                          //TaskListBlocState.taskList.clear();
                          Navigator.pushNamed(context, "/CreateTask");
                        },
                        icon: Icon(Icons.add_box_outlined, size: 40,),
                        color: Colors.green,
                      ),
                    
                  ],
                )
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
