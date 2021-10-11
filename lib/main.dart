import 'package:chat_app/MentalHealthTest/Screen/first_time.dart';
import 'package:chat_app/Screens/loadingLogo.dart';
import 'package:chat_app/SystemAuthentication/Autheticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//Making sure Firebase is initialized first before running app
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// First Page = Showing Logo for a brief moment then Authenticate
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingLogo(),
    );
  }
}