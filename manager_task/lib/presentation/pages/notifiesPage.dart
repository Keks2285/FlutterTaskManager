import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:manager_task/common/search.dart';
import 'package:manager_task/data/models/task.dart';
import 'package:manager_task/data/repositories/task_repo.dart';
import 'package:manager_task/presentation/blocs/notify_bloc.dart';
import '../../common/app_env.dart';
import '../../core/services/notify_service.dart';
import '../../data/models/user.dart';
import 'package:manager_task/presentation/blocs/registration_bloc.dart';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';
import '../../data/repositories/groupTasks_repo.dart';
import '../../data/repositories/groups_repo.dart';
import '../../data/repositories/notify_repo.dart';
import '../blocs/group_tasks_bloc.dart';
import '../blocs/tasklist_bloc.dart';

class NotifiesPage extends StatefulWidget {
  @override
  State<NotifiesPage> createState() => _NotifiesPageState();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
DateTime selectedDateTime = DateTime.now().add(Duration(days: 1));
TimeOfDay selectedTime =
    TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

class _NotifiesPageState extends State<NotifiesPage> {
  bool stop = false;

  //bool isRedirected =false;
  //bool _searchBoolean = false;
  //int totalValueItems = 0;

  @override
  void initState() {
    //super.initState();
    NotifyRepo().getNotyifications().then((value) {
      setState(() {});
    });
    //   initAtachmentsRepo().then(
    //   (value) {},
    // );
  }

  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();
    final titleController = TextEditingController();
    Future<void> _showPicker(BuildContext context) async {
      await showDatePicker(
              context: context,
              initialDate: selectedDateTime,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 1095)))
          .then((value) => {
                if (value != null)
                  {
                    setState(() {
                      selectedDateTime = DateTime(value.year, value.month,
                          value.day, selectedTime.hour, selectedTime.minute);
                    })
                  }
              });

      selectedTime = await showTimePicker(
              context: context, initialTime: TimeOfDay.now()) ??
          selectedTime;

      setState(() {
        selectedDateTime = DateTime(
            selectedDateTime.year,
            selectedDateTime.month,
            selectedDateTime.day,
            selectedTime.hour,
            selectedTime.minute);
      });
    }

    //final int groupID=(ModalRoute.of(context)?.settings.arguments??0) as int;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              NotifyRepo.allNotifies.clear();
              Navigator.of(context).pop();
            },
          ),
          //title: _searchTextField(context),
          //title:  _searchTextField(),
          title:  Text("Уведомления"),
          actions: 
              [
                  
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
          Container(
            margin: EdgeInsets.fromLTRB(20, 2, 0, 2),
            child: TextFormField(
                controller: descriptionController,
                maxLength: 20,
                maxLines: 2,
                cursorWidth: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Введите описание",
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 2, 0, 2),
            child: TextFormField(
                controller: titleController,
                maxLength: 10,
                maxLines: 1,
                cursorWidth: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Введите заголовок",
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 2, 2),
            child: Row(
              children: [
                Text(DateFormat("yyyy-MM-dd").format(selectedDateTime) +
                    " " +
                    selectedTime.format(context)),
                IconButton(
                  icon: Icon(Icons.calendar_month_sharp),
                  onPressed: () {
                    _showPicker(context).then((value) {
                      setState(() {});
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 2, 20),
                  child: ElevatedButton(
                      child: Text("Добавить"),
                      onPressed: () {
                        DateTime scheduledDateTime = DateTime(
                          selectedDateTime.year,
                          selectedDateTime.month,
                          selectedDateTime.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                        DateTime s =
                            DateTime.now().add(const Duration(minutes: 2));
                        var a = scheduledDateTime.compareTo(s);


                        if(descriptionController.text.length<1 ||titleController.text.length<1){
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                    child: Text(
                                        "Заполните описание и заголовок"),
                                    height: 100,
                                    color: Colors.lightBlue);
                              });
                          return;
                        }
                        if (scheduledDateTime.compareTo(DateTime.now().add(const Duration(minutes: 2))) <0) {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                    child: Text(
                                        "Указаное время не подходит для уведомления, выберите более поздний момент"),
                                    height: 100,
                                    color: Colors.lightBlue);
                              });
                          return;
                        }

                        NotificationService().createNotify(scheduledDateTime,
                            titleController.text, descriptionController.text);

                        NotifyRepo().getNotyifications().then((value) {
                          setState(() {});
                        });
                        // BlocProvider.of<GroupTasksBloc>(context).add(
                        //       CreateGroupTaskEvent(
                        //           date: state.date,
                        //           Time: state.Time,
                        //           description: descriptionController.text,
                        //           groupId: scrArg.groupID));
                      }),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: NotifyRepo.allNotifies.length,
              itemBuilder: (BuildContext context, int index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      color: NotifyRepo.allNotifies[index].title == "-"
                          ? Color.fromARGB(255, 151, 205, 255)
                          : Color.fromARGB(255, 128, 214, 116),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width - 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                "${"${NotifyRepo.allNotifies[index].title!}\n ${NotifyRepo.allNotifies[index].body!}\n"} ${NotifyRepo.allNotifies[index].payload}"),
                            IconButton(
                                onPressed: () async {
                                  await flutterLocalNotificationsPlugin
                                      .cancel(NotifyRepo.allNotifies[index].id)
                                      .then((value) => setState(() {
                                            NotifyRepo.allNotifies.removeWhere(
                                                (notify) =>
                                                    notify.id ==
                                                    NotifyRepo
                                                        .allNotifies[index].id);
                                          }));
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
        ],
      ),
    );
  }

  Widget _searchTextField(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        // BlocProvider.of<GroupTasksBloc>(context)
        //     .add(GroupTasksSearchEvent(query: value));
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
