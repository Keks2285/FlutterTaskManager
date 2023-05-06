import 'package:dartz/dartz.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/notify.dart';


class NotifyRepo{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static List<PendingNotificationRequest> allNotifies=[];

   getNotyifications() async{
    final List<PendingNotificationRequest> pendingNotifications =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();

final DateTime now = DateTime.now();

for (PendingNotificationRequest pendingNotification in pendingNotifications) {
  if (DateTime.parse(pendingNotification.payload!).compareTo(DateTime.now())<0 ) {
    await flutterLocalNotificationsPlugin.cancel(pendingNotification.id);
  }
}
    allNotifies  = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  //   for (PendingNotificationRequest pendingNotification in pendingNotifications) {
  //   final String id = pendingNotification.id.toString();
  //   final String title = pendingNotification.title!;
  //   final String body = pendingNotification.body!;
  //   final DateTime scheduledDate = pendingNotification.scheduledDate;

  //   print('id: $id, title: $title, body: $body, payload: $payload, scheduledDate: $scheduledDate');
  // }
    //allNotifies.clear();
    // final dbPath = await getDatabasesPath();
    // final db = await openDatabase(join(dbPath, 'taskDB.db'));
    // final List<Map<String, dynamic>> maps = await db.query('notifications');
    // allNotifies = List.generate(maps.length, (i) {
    //   return Notify(
    //     id: maps[i]['id'],
    //     title: maps[i]['title'],
    //     body: maps[i]['body'],
    //     date_time: maps[i]['scheduled_date_time'],
    //   );
    // });
    // var a=allNotifies;
  }


  // Future deleteNitification(int id)async{
  //   allNotifies.removeWhere((notify) => notify.id == id);
  //   final dbPath = await getDatabasesPath();
  //   final db = await openDatabase(join(dbPath, 'taskDB.db'));
  //   await db.delete(
  //   'notifications',
  //   where: 'id = ?',
  //   whereArgs: [id],
  // );
  // }

}



