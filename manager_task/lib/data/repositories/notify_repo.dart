import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/notify.dart';


class NotifyRepo{

  static List<Notify> allNotifies=[];

   getNotyifications() async{
    //allNotifies.clear();
    final dbPath = await getDatabasesPath();
    final db = await openDatabase(join(dbPath, 'taskDB.db'));
    final List<Map<String, dynamic>> maps = await db.query('notifications');
    allNotifies = List.generate(maps.length, (i) {
      return Notify(
        id: maps[i]['id'],
        title: maps[i]['title'],
        body: maps[i]['body'],
        date_time: maps[i]['scheduled_date_time'],
      );
    });
    var a=allNotifies;
  }


  Future deleteNitification(int id)async{
    allNotifies.removeWhere((notify) => notify.id == id);
    final dbPath = await getDatabasesPath();
    final db = await openDatabase(join(dbPath, 'taskDB.db'));
    await db.delete(
    'notifications',
    where: 'id = ?',
    whereArgs: [id],
  );
  }

}



