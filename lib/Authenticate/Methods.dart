import 'package:chat_app/Authenticate/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Methods {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> createAccount(String email, String password) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
          email: email, password: password)).user;

      await user.sendEmailVerification();
      print("Email Verification Sent");

      if (user != null) {
        print("Account created Succesfull");

        await _firestore.collection('users').doc(_auth.currentUser.uid).set({
          "name": email,
          // "email": email,
          "gender": null,
          "contact": null,
          "condition": null,
          "records": null,
          "status": null,
          "accountType": "Patient",
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

  Future<User> logIn(String email, String password, String account) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
          email: email, password: password)).user;

      if (user.emailVerified) {
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
      await _auth.signOut().then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      });
    } catch (e) {
      print("error");
    }
  }

}

