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
  }
}



