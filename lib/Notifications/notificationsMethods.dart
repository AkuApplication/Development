import 'package:chat_app/AssigningExercises/allExercisesPage.dart';
import 'package:chat_app/MoodTracker/start_page.dart';
import 'package:chat_app/Screens/About/aboutPage.dart';
import 'package:chat_app/Screens/loadingLogo.dart';
import 'package:chat_app/SystemAuthentication/SendEmailForResetPassword.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class CustomNotification{
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //Initializing the plugin when started run app
  Future<void> initialized() async {
    tz.initializeTimeZones();

    final AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");

    final InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: null,
      macOS: null,
      linux: null,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (payload) async {
      if(payload == "all"){
        print("launched");
        navigatorKey.currentState.push(MaterialPageRoute(builder: (context) => AllExercises(),));
      } else if(payload == "mood"){
        print("failed");
        navigatorKey.currentState.push(MaterialPageRoute(builder: (context) => StartPage(),));
      }
    },);

  }

  //Method on what happens after clicking on the notification
  void selectNotification(String payload) async {
    print("tapped");
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((value) async {
      if(value.didNotificationLaunchApp == true){
        print("launched");
      } else {
        print("failed");
      }
    });
    // return payload;
  }

  // Future<void> showPendingNotifications() async {
  //   List<PendingNotificationRequest> list = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  //   print("${list.length}");
  // }

  Future<void> showNotificationForTODOChecklist() async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails("0", "TODO CheckList Notification Reminder", visibility: NotificationVisibility.public, enableLights: true, ledOnMs: 3, ledOffMs: 3, ledColor: Color(008080), styleInformation: BigTextStyleInformation(""), importance: Importance.max, priority: Priority.max,  enableVibration: true);
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, "TODO Checklist", "Have you done the exercises/tests that was given to you by Counselor's name?", notificationDetails, payload: "all");
  }

  // Future<void> showNotificationForCheckingBackground() async {
  //   AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails("0", "TODO CheckList Notification Reminder", visibility: NotificationVisibility.public, enableLights: true, ledOnMs: 3, ledOffMs: 3, ledColor: Color(008080), styleInformation: BigTextStyleInformation(""));
  //   NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(4, "Background Check", "Have you done the exercises/tests that was given to you by Counselor's name?", notificationDetails,);
  // }

  // Future<void> showNotificationDaily() async {
  //   AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails("channelId", "channelName",);
  //   NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
  //
  //   await flutterLocalNotificationsPlugin.periodicallyShow(1, "daily title", "daily body", RepeatInterval.daily, notificationDetails, androidAllowWhileIdle: true,);
  // }

  Future<void> showNotificationDaily() async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails("channelId", "channelName",priority: Priority.max, visibility: NotificationVisibility.public, enableLights: true, ledOnMs: 3, ledOffMs: 3, ledColor: Color(008080), styleInformation: BigTextStyleInformation(""), importance: Importance.max, enableVibration: true);
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.periodicallyShow(3, "Mood Tracker", "Make sure to keep track of your mood today", RepeatInterval.daily, notificationDetails, androidAllowWhileIdle: true, payload: "mood");
  }

  Future<void> cancelNotificationForTODO() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  Future<void> cancelNotificationForMoodTracker() async {
    await flutterLocalNotificationsPlugin.cancel(3);
  }

  // Future<void> cancelAllNotification() async {
  //   await flutterLocalNotificationsPlugin.cancelAll();
  // }

  Future<void> scheduledNotification() async {
    var time = tz.TZDateTime.now(tz.local).add(Duration(seconds: 10));

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails("channelId", "channelName",);
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(2, "scheduled title", "scheduled body", time, notificationDetails, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,androidAllowWhileIdle: true);
  }

}