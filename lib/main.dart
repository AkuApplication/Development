import 'package:chat_app/Authenticate/Autheticate.dart';
import 'package:chat_app/TherapistTimetable/timetable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/Profile/profilepage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// First Page = Authenticate Dulu

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Timetable(),
    );
  }
}
