import 'package:chat_app/SystemAuthentication/LoginScreen.dart';
import 'package:chat_app/MentalHealthTest/Screen/first_time.dart';
import 'package:chat_app/Screens/counselorHomePage.dart';
import 'package:chat_app/Screens/patientHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  int _numOfLogins;

  //Getting data from Firestore
  void checkFirestore() async {
    await _store.collection("users").doc(_auth.currentUser.uid).get().then((value) {
      _account = value.data()["accountType"];

      if(_account == "Patient"){
        _numOfLogins = value.data()["numOfLogins"];
        if(_numOfLogins < 1){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstTime(),));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
        }
      } else if (_account == "Counselor") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DoctorHomePage(),));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_auth.currentUser == null) {
      return LoginScreen();
    } else {
      if(_auth.currentUser.emailVerified){
        checkFirestore();
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