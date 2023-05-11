import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manager_task_web/data/repositories/task_repo.dart';
import '../../common/app_env.dart';

import '../../data/repositories/groupTasks_repo.dart';
import '../../data/repositories/groups_repo.dart';
import '../blocs/group_tasks_bloc.dart';

class GroupTasksPage extends StatefulWidget {
  @override
  State<GroupTasksPage> createState() => _GroupTasksPageState();
}

class ScreenArguments {
  final int groupID;
  final String groupName;
  final int adminID;
  ScreenArguments(
      {required this.groupID, required this.groupName, required this.adminID});
}

class _GroupTasksPageState extends State<GroupTasksPage> {
  bool stop = false;

  //bool isRedirected =false;
  bool _searchBoolean = false;
  //int totalValueItems = 0;
  @override
  Widget build(BuildContext context) {
    final ScreenArguments scrArg =
        (ModalRoute.of(context)?.settings.arguments) as ScreenArguments;
    final descriptionController = TextEditingController();
    DateTime selectedDateTime = DateTime.now().add(Duration(days: 1));
    TimeOfDay selectedTime = TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

    Future<void> _showPicker(BuildContext context) async {
      await showDatePicker(
              context: context,
              initialDate: selectedDateTime,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 1095)))
          .then((value) => {selectedDateTime = value ?? selectedDateTime})
          .then((value) => {});
      selectedTime = await showTimePicker(
              context: context, initialTime: TimeOfDay.now()) ??
          selectedTime;
    }

    //final int groupID=(ModalRoute.of(context)?.settings.arguments??0) as int;
    return BlocProvider(
      create: (context) => GroupTasksBloc(),
      child: BlocConsumer<GroupTasksBloc, GroupTasksBlocState>(
        listener: (context, state) {
          if ( state is GroupTasksBlocConnectionErrorState && !stop) {
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
          //stop = false;
        },
        builder: (context, state) {
          if (state.nameState == "init" && !stop){
            BlocProvider.of<GroupTasksBloc>(context).add(GroupTasksInitEvent(groupId: scrArg.groupID));
            stop=true;
          }
            

          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    TaskRepo.allTasks.clear();
                    GroupTaskRepo.allTasks.clear();
                    Navigator.of(context).pop();
                  },
                ),
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
                              Navigator.pushReplacementNamed(context, "/SignIn",
                                  arguments: false);
                            })
                      ]
                    : [
                        IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchBoolean = false;
                                BlocProvider.of<GroupTasksBloc>(context)
                                    .add(GroupTasksSearchEvent(query: ""));
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
            body: Column(
              children: [
                if(scrArg.adminID==AppEnv.userId)
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
                if(scrArg.adminID==AppEnv.userId)
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 2, 2),
                  child: Row(
                    children: [
                      Text(state.date+" "+state.Time),
                      IconButton(
                        icon: Icon(Icons.calendar_month_sharp),
                        onPressed: () {
                          _showPicker(context).then((value) {
                              BlocProvider.of<GroupTasksBloc>(context).add(
                                  SelectedDateTimeEvent(
                                      date:    DateFormat("yyyy-MM-dd").format(selectedDateTime),
                                      Time: selectedTime.hour.toString().padLeft(2, '0')+":"+selectedTime.minute.toString().padLeft(2, '0')+":00",
                                      description: descriptionController.text));
                          });
                        },
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 2, 20),
                        child: ElevatedButton(
                            child: Text("Добавить"),
                            onPressed: () {
                              BlocProvider.of<GroupTasksBloc>(context).add(
                                    CreateGroupTaskEvent(
                                        date: state.date,
                                        Time: state.Time,
                                        description: descriptionController.text,
                                        groupId: scrArg.groupID));
                            }),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                            color: state.taskList[index].completedBy == "-"
                                ? Color.fromARGB(255, 151, 205, 255)
                                : Color.fromARGB(255, 128, 214, 116),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth:
                                    MediaQuery.of(context).size.width - 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      "${" ${state.taskList[index].description!}\n"} ${state.taskList[index].dateTask.toString().replaceAll(".000Z", "")}${state.taskList[index].completedBy == "-" ? "" : "\n Выполнил:" + state.taskList[index].completedBy!}"),
                                  

                                  IconButton(
                                        onPressed: () {
                                          
                                          Navigator.pushNamed(context, "/GroupAtachments");
                                          AppEnv.selectedGroupTask=state.taskList[index].id.toString();
                                        },
                                        icon: Icon(Icons.attach_file)),

                                    IconButton(
                                        onPressed: () {
                                          
                                          Navigator.pushNamed(context, "/CommentsPage", arguments:scrArg.adminID);
                                          AppEnv.selectedGroupTask=state.taskList[index].id.toString();
                                        },
                                        icon: Icon(Icons.comment)),
                                  
                                  
                                  
                                  if (scrArg.adminID == AppEnv.userId) ...{
                                    IconButton(
                                        onPressed: () {
                                          BlocProvider.of<GroupTasksBloc>(
                                                  context)
                                              .add(GroupTasksDeleteEvent(
                                                  id: state.taskList[index].id!,
                                                  date: DateFormat("yyyy-MM-dd").format(selectedDateTime),
                                                  Time: selectedTime.hour.toString().padLeft(2, '0')+":"+selectedTime.minute.toString().padLeft(2, '0')+":00",
                                                  description: descriptionController.text));
                                        },
                                        icon:
                                            Icon(Icons.delete_forever_outlined))
                                  } else if (state
                                          .taskList[index].completedBy ==
                                      "-") ...{
                                    IconButton(
                                        onPressed: () {
                                          BlocProvider.of<GroupTasksBloc>(
                                                  context)
                                              .add(CompleteTaskEvent(
                                                  index: index,
                                                  id: state.taskList[index].id!,
                                                  date: DateFormat("yyyy-MM-dd").format(selectedDateTime),
                                                  Time: selectedTime.hour.toString()+":"+selectedTime.minute.toString()+":00",
                                                  description: descriptionController.text));
                                        },
                                        icon: Icon(Icons.check_box_outlined))
                                  }
                                  
                                ],
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
        BlocProvider.of<GroupTasksBloc>(context)
            .add(GroupTasksSearchEvent(query: value));
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
