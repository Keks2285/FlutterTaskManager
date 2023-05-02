import 'dart:io' as io;
import 'dart:html';
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../common/app_env.dart';
import '../../data/models/person_attacment.dart';
import 'package:manager_task_web/presentation/blocs/registration_bloc.dart';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../data/repositories/personAttacment_repo.dart';
import '../blocs/group_list_bloc.dart';
import '../blocs/person_attachments_bloc.dart';
import '../blocs/tasklist_bloc.dart';
import 'groupTasksPage.dart';

class PersonAttachmentsListPage extends StatefulWidget {
  @override
  State<PersonAttachmentsListPage> createState() =>
      _PersonAttachmentsListPageState();
}

class _PersonAttachmentsListPageState extends State<PersonAttachmentsListPage> {
  static PlatformFile? pickedFile;
  static UploadTask? uploadTask;
  static DownloadTask? downloadTask;

  Future downloadFile(String idTask, String fileName) async {
    try {
      final path = "personAttachments/${idTask}/${fileName}";
      final ref = FirebaseStorage.instance.ref().child(path);

      //Создайте ссылку на файл
      html.AnchorElement anchorElement =
          html.document.createElement('a') as AnchorElement;

      String url = await ref.getDownloadURL();
      anchorElement.target = "_blank";
      anchorElement.href = url;
      anchorElement.download = fileName;

      // Нажмите на ссылку, чтобы начать загрузку файла
      html.document.body!.children.add(anchorElement);
      anchorElement.click();
      html.document.body!.children.remove(anchorElement);
    } on FirebaseException catch (e) {}
  }

  Future deleteFile(String idTask, String fileName) async {
    try {
      final path = "personAttachments/${idTask}/${fileName}";
      final ref = FirebaseStorage.instance.ref().child(path);
      ref.delete();
      setState(() {
        PersonAtachmentsRepository.allAttachment
            .removeWhere((element) => element.filename == fileName);
      });
    } on FirebaseException catch (e) {}
  }

  Future uploadFile(String taskId) async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;

      pickedFile = result.files.first;
      final path = "personAttachments/${taskId}/${pickedFile!.name}";
      final ref = FirebaseStorage.instance.ref().child(path);
      var t = result.files.first.bytes;
      // ignore: iterable_contains_unrelated_type
      if (!PersonAtachmentsRepository.allAttachment
          .any((attachment) => attachment.filename == result.files.first.name))
        // ignore: curly_braces_in_flow_control_structures
        PersonAtachmentsRepository.allAttachment.add(PersonAtachment(
            filename: result.files.first.name,
            size: (result.files.first.size! / 1024).toString(),
            extension: result.files.first.extension ?? "undefinded"));
      setState(() {
        uploadTask = ref.putData(t!);
      });

      final snapshot = await uploadTask!.whenComplete(() {});
      setState(() {
        uploadTask = null;
      });
    } on FirebaseException catch (e) {}
  }

//final String taskID =(ModalRoute.of(context)?.settings.arguments).toString();

// Future<void> initAtachmentsRepo() async {
//  //var a = PersonAtachmentsRepository.allAttachment;
//  PersonAtachmentsRepository().LoadPersonAttachments(AppEnv.selectedPersonalTask).then((value)  {
//        setState(() {
//        });
//       });
//  setState(() {});
// }

  @override
  void initState() {
    //super.initState();
    PersonAtachmentsRepository()
        .LoadPersonAttachments(AppEnv.selectedPersonalTask)
        .then((value) {
      setState(() {});
    });
    //   initAtachmentsRepo().then(
    //   (value) {},
    // );
  }

  //int totalValueItems = 0;
  @override
  Widget build(BuildContext context) {
    //initAtachmentsRepo();

    //var a =PersonAtachmentsRepository.allAttachment;
    //PersonAtachmentsRepository().LoadPersonAttachments(taskID);
    //PersonAtachmentsRepository.allAttachment.clear();
    //PersonAtachmentsRepository().LoadPersonAttachments(taskID);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Attachments"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            PersonAtachmentsRepository.allAttachment.clear();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: PersonAtachmentsRepository.allAttachment.length,
              itemBuilder: (BuildContext context, int index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 4, 10, 0),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 173, 187, 201),
                        border: Border.all(color: Colors.black12, width: 2)),
                    child: Container(
                      height: 60,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width - 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.insert_drive_file),
                                  SizedBox(width: 10),
                                  Text(PersonAtachmentsRepository.allAttachment[index].filename ??""+" "
                                  +PersonAtachmentsRepository.allAttachment[index].size),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          downloadFile(
                                              AppEnv.selectedPersonalTask,
                                              PersonAtachmentsRepository
                                                  .allAttachment[index]
                                                  .filename!);
                                        });
                                      },
                                      icon: Icon(Icons.download)),
                                  IconButton(
                                      onPressed: () {
                                        deleteFile(
                                            AppEnv.selectedPersonalTask,
                                            PersonAtachmentsRepository
                                                .allAttachment[index]
                                                .filename!);
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
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
          if (uploadTask != null) buildProgress()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            uploadFile(AppEnv.selectedPersonalTask);
          });
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.file_present_outlined),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text('${(100 * progress).roundToDouble()}%',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          );
        } else {
          return const SizedBox(height: 50);
        }
      });

  //   Widget buildDownloadProgress()=>StreamBuilder(
  //   stream: downloadTask?.snapshotEvents,
  //   builder: (context, snapshot) {
  //     if(snapshot.hasData){
  //       final data = snapshot.data!;
  //       double progress = data.bytesTransferred/data.totalBytes;
  //       return  SizedBox(
  //         height: 50,
  //         child: Stack(
  //           fit: StackFit.expand,
  //           children: [
  //             LinearProgressIndicator(
  //               value: progress,
  //               backgroundColor: Colors.grey,
  //               color: Colors.green,
  //             ),
  //             Center(
  //               child: Text('${(100*progress).roundToDouble()}%', style: TextStyle(color: Colors.white)),
  //               )
  //             ],
  //           ),);
  //     }else{
  //       return const SizedBox(height: 50);
  //     }
  //   }

  // );

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
