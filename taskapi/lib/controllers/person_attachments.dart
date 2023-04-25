import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:mime/mime.dart';
import 'dart:math' as math;


// class MyController extends ResourceController {
//   MyController() {
//     acceptedContentTypes = [ContentType("multipart", "form-data")];
//   }

 
// }

class AppPersonAttachmentsController extends ResourceController {
  //   MyController() {
//     acceptedContentTypes = [ContentType("multipart", "form-data")];
//   }
  AppPersonAttachmentsController(this.managedContext){
   // final boundary = generateRandomString(16);
    acceptedContentTypes = [ContentType("multipart", "form-data" )];
  }
  final ManagedContext managedContext;


String generateRandomString(int length) {
  final random = math.Random();
  final buffer = StringBuffer();
  for (var i = 0; i < length; i++) {
    buffer.writeCharCode(random.nextInt(26) + 97); // Add lowercase ASCII letters
  }
  return buffer.toString();
}

  

 @Operation.post()
  Future<Response> postForm() async {
    List<int>dataButes=[];
    //final body = await request!.body.decode();
    //final file = body.files['file'];
    //  await for(var data in ){
    //    dataButes.addAll(data);
    //  }



    final boundary = request?.raw.headers.contentType?.parameters["boundary"];
    final transformer = MimeMultipartTransformer(boundary!);
    final bodyBytes =await request!.body.decode<List<int>>();
    final bodyStream = Stream.fromIterable([bodyBytes]);
    final parts = await transformer.bind(bodyStream).toList();

    for (var part in parts) {
      final headers = part.headers;
      final content = await part.toList();

      // Получение имени файла из заголовков
      final disposition = headers['content-disposition'];
      final dispositionParams = HeaderValue.parse(disposition!);
      final filename = dispositionParams.parameters['filename'];

      // Создание пути сохранения файла
      final uploadDir = Directory('../../files'); // путь до папки загрузок
      if (!uploadDir.existsSync()) {
        uploadDir.createSync(recursive: true);
      }
      final savePath = '${uploadDir.path}/$filename';

      // Запись содержимого части в файл
      final file = File(savePath);
      await file.writeAsBytes(content.expand((x) => x).toList());

      // // Создание и сохранение в БД соответствующей записи
      // final attachment = AppPersonAttachment()
      //   ..filename = filename
      //   ..path = savePath;
      // await attachment.save();
    }

    return Response.ok({'message': 'Файл успешно загружен'});
  }
}