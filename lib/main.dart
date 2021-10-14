import 'package:chat_app/Screens/loadingLogo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Making sure Firebase is initialized first before running app
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: LoadingLogo(),
    );
  }
}