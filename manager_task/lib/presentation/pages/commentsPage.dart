import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_task/common/search.dart';
import 'package:manager_task/data/models/task.dart';
import 'package:manager_task/core/usecase/firestore_person_attacments.dart';
import 'package:manager_task/data/repositories/groups_repo.dart';
import 'package:manager_task/data/repositories/personAttacment_repo.dart';
import 'package:manager_task/data/repositories/task_repo.dart';
import '../../common/app_env.dart';
import '../../data/models/user.dart';
import 'package:manager_task/presentation/blocs/registration_bloc.dart';
import 'dart:developer' as developer;

import '../../data/repositories/comments_repo.dart';
import '../../data/repositories/groupTasks_repo.dart';
import '../blocs/comments_bloc.dart';
import '../blocs/tasklist_bloc.dart';

class CommentsPage extends StatefulWidget {
  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  bool stop = false;
  //bool isRedirected =false;
 
  //int totalValueItems = 0;
  @override
  Widget build(BuildContext context) {
    final int adminID=(ModalRoute.of(context)?.settings.arguments) as int;
    final descriptionController = TextEditingController();
    return BlocProvider(
      create: (context) => CommentsBloc(),
      child: BlocConsumer<CommentsBloc, CommentsBlocState>(
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
          if (state.nameState == "init" && !stop)
            BlocProvider.of<CommentsBloc>(context).add(CommentsInitEvent());

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
               leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    ComentsRepo.allComments.clear();
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                       
                        IconButton(
                            icon: const Icon(Icons.logout),
                            onPressed: () {
                              TaskRepo.allTasks.clear();
                              GroupTaskRepo.allTasks.clear();
                              GroupsRepo.allGroups.clear();
                              Navigator.pushReplacementNamed(context, "/SignIn",arguments: false);
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
                    itemCount: state.Comments.length,
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
                                        "${state.Comments[index].dateComment.toString().substring(0, state.Comments[index].dateComment.toString().length - 7)}\n${"${state.Comments[index].comment!}\n"}\n ${state.Comments[index].email.toString().replaceAll(".000Z", "")}"),
                                    if (adminID == AppEnv.userId) 
                                        IconButton(
                                        onPressed: () {
                                          BlocProvider.of<CommentsBloc>(context).add(
                                              CommentDeleteEvent(
                                                  id: state.Comments[index].id));
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
                Container(
                  margin: EdgeInsets.fromLTRB(20, 2, 0, 2),
                  child: TextFormField(
                      controller: descriptionController,
                      maxLines: 2,
                      cursorWidth: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Введите описание",
                      )),
                ),
                ElevatedButton(
                            child: Text("Добавить"),
                            onPressed: () {
                              BlocProvider.of<CommentsBloc>(context).add(
                                    CommentsBlocAddEvent(description:descriptionController.text ));
                            }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                      
                    
                  ],
                )
               ],
             ),
          );
        },
      ),
    );
  }

  // Widget _searchTextField(BuildContext context) {
  //   return TextField(
  //     onSubmitted: (value) {
  //       BlocProvider.of<TaskListBloc>(context)
  //           .add(TaskSearchEvent(query: value));
  //     },
  //     autofocus: true,
  //     cursorColor: Colors.white,
  //     style: TextStyle(
  //       color: Colors.white,
  //       fontSize: 20,
  //     ),
  //     textInputAction: TextInputAction.search,
  //     decoration: InputDecoration(
  //       enabledBorder:
  //           UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  //       focusedBorder:
  //           UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  //       hintText: 'Search',
  //       hintStyle: TextStyle(
  //         color: Colors.white60,
  //         fontSize: 20,
  //       ),
  //     ),
  //   );
  // }
}
