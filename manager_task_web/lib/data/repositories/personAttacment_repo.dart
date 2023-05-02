

//import 'dart:html';
import 'dart:io';
import 'dart:io' as io;
//import 'dart:html' as html;
import 'package:path_provider/path_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:manager_task_web/data/models/person_attacment.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class PersonAtachmentsRepository{
  static List<PersonAtachment> allAttachment=[];
  
    Future LoadPersonAttachments(String idTask) async {
      //allAttachment.clear();
      final path ="personAttachments/${idTask}/";
      final ref = FirebaseStorage.instance.ref().child(path);
      final list = await ref.listAll();

      if(list==null) return;
      for (var item in list.items) {
        var data =await item.getMetadata();
        String h =(data.size??0/1024).toString();
        allAttachment.add(
          PersonAtachment(
            filename: data.name, 
            size: h, 
            extension: data.contentType!)
          );
      }
      var a = allAttachment.first.filename!+allAttachment.first.size;
     
    }


      

    //     Future downloadFile(String idTask, String fileName) async {
    //   //allAttachment.clear();
    //   final path ="personAttachments/${idTask}/${fileName}";
    //   final ref = FirebaseStorage.instance.ref().child(path);
    //   String url = await ref.getDownloadURL();
    //   final httpsReference = FirebaseStorage.instance.refFromURL(url);
      
    // }


   

}