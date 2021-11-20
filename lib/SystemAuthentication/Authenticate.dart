import 'package:chat_app/Notifications/notificationsMethods.dart';
import 'package:chat_app/SystemAuthentication/LoginScreen.dart';
import 'package:chat_app/MentalHealthTest/Screen/first_time.dart';
import 'package:chat_app/Screens/counselorHomePage.dart';
import 'package:chat_app/Screens/patientHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  //Getting related Firebase instances to be able to interact with Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  //Initializing variables
  String _account;
  String _phone;
  int _numOfLogins;
  SharedPreferences sharedPreferences;

  //Getting SharedPreferences instance
  void getPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  //Getting data from Firestore
  void checkFirestore() async {
    await _store.collection("users").doc(_auth.currentUser.uid).get().then((value) {
      _account = value.data()["accountType"];
      _phone = value.data()["contact"];

      if(_account == "Patient"){
        _numOfLogins = value.data()["numOfLogins"];
        if(_numOfLogins < 1){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstTime(),));
        } else {
          firstNotification();
          secondNotification();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(sharedPreferences: sharedPreferences,),));
        }
      } else if (_account == "Counselor") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DoctorHomePage(),));
      }
    });
  }

  //Variables for the notifications value
  bool firstReminder;
  bool secondReminder;

  void firstNotification() async {
    setState(() {
      firstReminder = sharedPreferences.getBool("firstReminder") ?? true;
    });
    if(firstReminder ==  true){
      await CustomNotification().showNotificationForTODOChecklist();
    } else {
      await CustomNotification().cancelNotificationForTODO();
    }
  }

  void secondNotification() async {
    setState(() {
      secondReminder = sharedPreferences.getBool("secondReminder") ?? true;
    });
    if(secondReminder ==  true){
      await CustomNotification().showNotificationDaily();
    } else {
      await CustomNotification().cancelNotificationForMoodTracker();
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_auth.currentUser == null) {
      return LoginScreen();
    } else {
      if(_auth.currentUser.emailVerified){
        checkFirestore();
        // if(_auth.currentUser.phoneNumber == _phone){
        //
        // } else {
        //   return LoginScreen();
        // }

        //While checkFirestore is running, will return a loadingIndicator
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return LoginScreen();
      }
    }
  }
}