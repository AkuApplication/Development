import 'package:chat_app/SystemAuthentication/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Methods {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> createAccount(String email, String password, String name, String gender) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
          email: email, password: password)).user;

      user.updateDisplayName(name);

      await user.sendEmailVerification();
      print("Email Verification Sent");

      if (user != null) {
        print("Account created Succesfull");

        await _firestore.collection('users').doc(_auth.currentUser.uid).set({
          "name": name,
          "email": email,
          "password": password,
          "gender": gender,
          "contact": null,
          "condition": null,
          // "records": null,
          "status": "Offline",
          "profileURL": "https://firebasestorage.googleapis.com/v0/b/aku-application-a7dda.appspot.com/o/logo.jpeg?alt=media&token=50035771-7905-43a3-8b51-256f71e506cf",
          "accountType": "Patient",
          "uid": _auth.currentUser.uid,
          "numOfLogins": 0
        });

        return user;
      } else {
        print("Account creation failed");
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> logIn(String email, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
          email: email, password: password)).user;

      if (user.emailVerified) {

        await _firestore.collection('users').doc(_auth.currentUser.uid).update({
          "status": "Online",
        });

        print("Email Verified and Login Successful");
        return user;
      } else {
        await user.sendEmailVerification();
        print("Email Verification Sent");
        print("Login Failed");
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future logOut(BuildContext context) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser.uid).update({
        "status": "Offline",
      });

      await _auth.signOut().then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      });
    } catch (e) {
      print("error");
    }
  }

}

