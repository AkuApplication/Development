import 'package:chat_app/ActivityLog/activityLogPage.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/assigningExercisesHomePage.dart';
import 'package:chat_app/AssigningExercises/allExercisesPage.dart';
import 'package:chat_app/CounselorTimetable/timetable.dart';
import 'package:chat_app/MentalHealthTest/SetupPage/createMentalHealthTestPage.dart';
import 'package:chat_app/MentalHealthTest/SetupPage/editMentalHealthTestPage.dart';
import 'package:chat_app/MentalHealthTest/SetupPage/setupMentalHealthTestPage.dart';
import 'package:chat_app/MoodTracker/start_page.dart';
import 'package:chat_app/Notifications/notificationSettingsPage.dart';
import 'package:chat_app/Notifications/notificationsMethods.dart';
import 'package:chat_app/ReportGeneration/homepage.dart';
import 'package:chat_app/Screens/loadingLogo.dart';
import 'package:chat_app/SetupExercises/createExercisesPage.dart';
import 'package:chat_app/SetupExercises/editExercisesPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

var prefs;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//Making sure Firebase is initialized first before running app
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  await CustomNotification().initialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((e) {
    e = runApp(MyApp());
  });
}

// First Page = Showing Logo for a brief moment then Authenticate
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: LoadingLogo()
    );
  }
}