// ignore_for_file: prefer_const_constructors

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:manager_task/data/repositories/notify_repo.dart';
import 'package:sqflite/sqflite.dart';
  import 'package:path/path.dart';
import 'package:timezone/timezone.dart' as tz;



class NotificationService{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final NotificationDetails notificationDetails =
      NotificationDetails(
        android: AndroidNotificationDetails(
          'task_mobile_channel_id',
          'Notify',
          channelDescription: 'Notify of task',
          importance: Importance.max,
          
          priority: Priority.high,
          showWhen: false,
        ),
    iOS: DarwinNotificationDetails()
  );


   Future showNotify()async=>{
    flutterLocalNotificationsPlugin.show(1, "title", "body", notificationDetails)
  };


  Future deleteNotify(int idNotify) async {
    await NotifyRepo().deleteNitification(idNotify);
    await flutterLocalNotificationsPlugin.cancel(idNotify);
  }


  Future<int> createNotify(DateTime scheduledDateTime, String title, String body) async {
  // открываем базу данных SQLite
  final dbPath = await getDatabasesPath();
  final db = await openDatabase(
    join(dbPath, 'taskDB.db'),
    onCreate: (db, version) {
      // создаем таблицу, если она еще не существует
      return db.execute(
        'CREATE TABLE notifications(id INTEGER PRIMARY KEY, title TEXT, body TEXT, payload TEXT, scheduled_date_time TEXT)',
      );
    },
    version: 1,
  );

  // создаем новую запись в таблице notifications
  final id = await db.insert(
    'notifications',
    {
      'title': title,
      'body': body,
      'scheduled_date_time': scheduledDateTime.toString(),
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  // закрываем базу данных
  await db.close();

  // создаем уведомление
  
  var a = notificationDetails;

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime.from(scheduledDateTime, tz.local) ,
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    payload: 'notification payload', 
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time
  );

  // возвращаем идентификатор вставленной записи
  return id;
}

}