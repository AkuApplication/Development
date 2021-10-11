import 'package:chat_app/SystemAuthentication/LoginScreen.dart';
import 'package:chat_app/MentalHealthTest/Screen/first_time.dart';
import 'package:chat_app/Screens/doctorHomePage.dart';
import 'package:chat_app/Screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  //Getting related Firebase isntances to be able to interact with Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Initializing variables
  String _account;
  int _numOfLogins;

  void checkFirestore() async {
    try {
      await _firestore.collection("users").doc(_auth.currentUser.uid).get().then((value) {
        _account = value.data()["accountType"];
        _numOfLogins = value.data()["numOfLogins"];

        if(_account == "Patient"){
          print("going to patient 1");
          if(_numOfLogins < 1){
            print("going to first time 1");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => FirstTime(),));
          } else {
            print("going to patient homepage 1");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePage(),));
          }
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => HomePage(),));
        } else if (_account == "Doctor") {
          print("going to doctor 1");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DoctorHomePage(),));
        }

      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_auth.currentUser == null) {
      print("went to login 1");
      return LoginScreen();
    } else {
      if(_auth.currentUser.emailVerified){
        print("getting data from firestore 1");
        checkFirestore();
        //While checkFirestore is running, will return a loadingIndicator
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        print("back to login 1");
        return LoginScreen();
      }
    }
  }
}