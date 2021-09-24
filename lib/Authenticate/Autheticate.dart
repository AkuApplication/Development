import 'package:chat_app/Authenticate/LoginScreen.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String _account;
  String _name;
  String _profileURL;

  void checkFirestore() async {
    try {
      await _firestore.collection("users").doc(_auth.currentUser.uid).get().then((value) {
        _account = value.data()["accountType"];
        // _name = value.data()["name"];
        // _profileURL = value.data()["profileURL"];

        // _profileURL = await _storage.ref().child("logo.jpeg").getDownloadURL();
        // print(_profileURL);

        if(_account == "Patient"){
          print("going to patient 1");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomePage(),));
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