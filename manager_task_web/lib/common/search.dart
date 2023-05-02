import 'package:flutter/material.dart';
import 'package:manager_task_web/data/models/task.dart';

import '../data/repositories/task_repo.dart';

class TaskSearch extends  SearchDelegate<ToDoTask>{
  String result="";
  final List<ToDoTask> searchTasks;
  TaskSearch(this.searchTasks);
  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query='';
        })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
     return 
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          close(context, ToDoTask(dateTask: DateTime.now(), description: "",tag:"#Учеба", id: 0));
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    
    
    final suggestons=searchTasks.where((element) {
      return element.description!.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: suggestons.length,
              itemBuilder: (BuildContext context, int index) {
                return Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        color:  Color.fromARGB(255, 151, 205, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              
                                 Text(
                                   
                                    "${"${suggestons.elementAt(index).description!}\n"} ${suggestons.elementAt(index).dateTask.toString().replaceAll(".000Z", "")}"),
                              
                              IconButton(
                                  onPressed: () async{
                                     await TaskRepo().Deletetask(suggestons.elementAt(index).id);
                                  },
                                  icon: Icon(Icons.delete_forever_outlined))
                            ],
                          ),
                        ),
                      ),
                );
              },
            );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestons=searchTasks.where((element) {
      return element.description!.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
             
              scrollDirection: Axis.vertical,
              itemCount: suggestons.length,
              
              itemBuilder: (BuildContext context, int index) {
                return Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        color:  Color.fromARGB(255, 151, 205, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              
                                 Text(
                                   
                                    "${"${suggestons.elementAt(index).description!}\n"} ${suggestons.elementAt(index).dateTask.toString().replaceAll(".000Z", "")}"),
                              
                              IconButton(
                                  onPressed: () async{
                                     await TaskRepo().Deletetask(suggestons.elementAt(index).id);
                                  },
                                  icon: Icon(Icons.delete_forever_outlined))
                            ],
                          ),
                        ),
                      ),
                );
              },
            );

  }

}