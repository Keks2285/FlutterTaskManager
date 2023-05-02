import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_task_web/data/repositories/groupTasks_repo.dart';
import 'package:manager_task_web/data/repositories/groups_repo.dart';
import '../../common/app_env.dart';
import '../blocs/group_list_bloc.dart';
import '../blocs/tasklist_bloc.dart';
import 'groupTasksPage.dart';


class GroupListPage extends StatelessWidget {
  bool stop = false;

  final namegroupController = TextEditingController();

  bool _searchBoolean = false;

  //int totalValueItems = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupListBloc(),
      child: BlocConsumer<GroupListBloc, GroupListState>(
        listener: (context, state) {
          if (!state.succes ) {
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
            BlocProvider.of<GroupListBloc>(context).add(GroupListInitEvent());

          return Scaffold(
            appBar: AppBar(
              title: Text("My Groups"),
            ),
          
            body: 
             Column(
               children: [
                 Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                     Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        width: 220,
                       child: TextFormField(
                        controller: namegroupController,
                       ),
                     ),
                     Column(
                      children: [
                        Container(
                          width:150,
                          child: ElevatedButton(
                          style:ButtonStyle(
                            
                          ),
                          onPressed: (){

                            BlocProvider.of<GroupListBloc>(context).add(CreateGroupEvent(nameGroup:namegroupController.text));
                              // GroupsRepo().createGroup(
                              //   Group(
                              //   id: 0, 
                              //   namegroup: namegroupController.text,
                              //   adminid: AppEnv.userId));
                          }, 
                          child: Text("Создать группу")),
                        ),
                        Container(
                          width: 150,
                          child: ElevatedButton(
                            
                          onPressed: (){
                           BlocProvider.of<GroupListBloc>(context).add(JoinGroupEvent(nameGroup:namegroupController.text));
                          }, 
                          child: Text("Найти группу")),
                        )
                      ],
                     )


                    // IconButton(
                    //     onPressed: () {
                    //       try {
                    //         state.groupList.clear();
                    //       } catch (e) {}
                    //       //TaskRepo.allTasks.clear();
                    //       //BlocProvider.of<TaskListBloc>(context).add(TaskListInitEvent());
                    //       //TaskRepo.allTasks.clear();
                    //       //TaskListBlocState.taskList.clear();
                    //       Navigator.pushNamed(context, "/CreateTask");
                    //     },
                    //     icon: Icon(Icons.add_box_outlined, size: 40,),
                    //     color: Colors.green,
                    //   ),
                    
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.groupList.length,
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
                            child: InkWell(
                            
                                    onTap: (){ 
                                        GroupTaskRepo.allTasks.clear();
                                        Navigator.pushNamed(context, "/GroupTasks", arguments: ScreenArguments(groupID:state.groupList[index].id, groupName:state.groupList[index].namegroup,adminID: state.groupList[index].adminid) );
                                    },
                                    child: Container(
                                      
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,  
                                        children: [
                                          Text(state.groupList[index].namegroup??""),
                                          if(GroupsRepo.allGroups[index].adminid==AppEnv.userId)...{
                                            IconButton(
                                              onPressed: () {
                                                GroupsRepo().deleteLeaveGroup(GroupsRepo.allGroups[index].id);
                                                 GroupsRepo.allGroups.remove(GroupsRepo.allGroups[index]);
                                                  BlocProvider.of<GroupListBloc>(context).add(GroupListInitEvent());
                                              },
                                              icon: Icon(Icons.delete_forever))
                                          }else...{
                                            IconButton(
                                              onPressed: () {
                                               
                                                GroupsRepo().deleteLeaveGroup(GroupsRepo.allGroups[index].id);
                                                 GroupsRepo.allGroups.remove(GroupsRepo.allGroups[index]);
                                                  BlocProvider.of<GroupListBloc>(context).add(GroupListInitEvent());
                                              },
                                              icon: Icon(Icons.exit_to_app))
                                          }
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
