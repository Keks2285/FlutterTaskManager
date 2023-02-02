import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:conduit/conduit.dart';
class AppService extends ApplicationChannel{
late final ManagedContext managedContext;

@override
  Future prepare() {
    final _persistentStore =_initDataBase();
     managedContext=ManagedContext(ManagedDataModel.fromCurrentMirrorSystem(), _persistentStore);
    // TODO: implement prepare
    return super.prepare();
  }





  @override
  // TODO: implement entryPoint
  Controller get entryPoint => Router();


  PersistentStore _initDataBase(){
    final username = Platform.environment['DB_USERNAME']??'postgres';
    final password = Platform.environment['DB_PASSWORD']??'1';
    final host = Platform.environment['DB_HOST']??'127.0.0.1';
    final port =int.parse(Platform.environment['DB_PORT']??'5432');
    final databaseName =Platform.environment['DB_NAME']??'taskDB';
    return PostgreSQLPersistentStore(username, password, host, port, databaseName);
  }

  
}