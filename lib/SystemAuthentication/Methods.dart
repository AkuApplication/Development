import 'package:chat_app/SystemAuthentication/LoginScreen.dart';
import 'package:chat_app/SystemAuthentication/formForOTP.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Methods {
  //Getting related Firebase instances to be able to interact with Firebase
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Method for creating a 'Patient' user account
  Future<User> createAccount(String email, String password, String name, String gender, String contact) async {
    User user = (await _auth.createUserWithEmailAndPassword(
        email: email, password: password)).user;

    //Updating the account displayName for when receiving email from Aku App
    user.updateDisplayName(name);

    //Send email for verification of the account
    await user.sendEmailVerification();

    //Verify phone number and link the phone number to the email account
    await _auth.verifyPhoneNumber(
        phoneNumber: contact,
        verificationCompleted: (phoneAuthCredential) async {
          // print("verification completed ${authCredential.smsCode}");
          // User user = FirebaseAuth.instance.currentUser;
          // setState(() {
          //   this.otpCode.text = authCredential.smsCode;
          // });
          if (phoneAuthCredential.smsCode != null) {
            try {
              // UserCredential credential =
              await user.linkWithCredential(phoneAuthCredential);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'provider-already-linked') {
                await _auth.signInWithCredential(phoneAuthCredential);
              }
            }
            // setState(() {
            //   isLoading = false;
            // });
            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
          }
        },
        verificationFailed: (error) {
          print(error.message);
          return error.message;
          // if (error.code == 'invalid-phone-number') {
          //   // showMessage("The phone number entered is invalid!");
          // }
        },
        codeSent: (verificationId, forceResendingToken) {
          FormForOTP().createState().verificationId = verificationId;
          print(forceResendingToken);
          print("code sent");
        },
        codeAutoRetrievalTimeout: (verificationId) {
          return null;
        },
    );

    //Setting the Patient User Data in Firestore
    await _firestore.collection('users').doc(_auth.currentUser.uid).set({
      "name": name,
      "email": email,
      "password": password,
      "gender": gender,
      "contact": contact,
      "condition": null,
      "status": "Offline",
      "profileURL": "https://firebasestorage.googleapis.com/v0/b/aku-application-a7dda.appspot.com/o/logo.jpeg?alt=media&token=50035771-7905-43a3-8b51-256f71e506cf",
      "accountType": "Patient",
      "uid": _auth.currentUser.uid,
      "numOfLogins": 0
    });

    return user;
  }

  //Method for logging in to the app after created an account
  Future<User> logIn(String email, String password) async {
    User user = (await _auth.signInWithEmailAndPassword(
        email: email, password: password)).user;

    if (user.emailVerified) {
      await _firestore.collection('users').doc(_auth.currentUser.uid).update({
        "status": "Online",
      });

      return user;
    } else {
      await user.sendEmailVerification();

      return user;
    }
  }

  //Method for logging out the current user
  Future logOut(BuildContext context) async {
    await _firestore.collection('users').doc(_auth.currentUser.uid).update({
      "status": "Offline",
    });

    await _auth.signOut().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }

  //TODO: decide if want to create admin or not
  // //Method for creating a 'Counselor' user account
  // Future<User> createCounselor(String email, String password, String name, String gender, BuildContext context) async {
  //   User user = (await _auth.createUserWithEmailAndPassword(
  //       email: email, password: password)).user;
  //
  //   //Updating the account displayName for when receiving email from Aku App
  //   user.updateDisplayName(name);
  //
  //   //Send email for verification of the account
  //   await user.sendEmailVerification();
  //
  //   //Setting the Patient User Data in Firestore
  //   await _firestore.collection('users').doc(_auth.currentUser.uid).set({
  //     "name": name,
  //     "email": email,
  //     "password": password,
  //     "gender": gender,
  //     "contact": "",
  //     "profession": "",
  //     "status": "Offline",
  //     "profileURL": "https://firebasestorage.googleapis.com/v0/b/aku-application-a7dda.appspot.com/o/logo.jpeg?alt=media&token=50035771-7905-43a3-8b51-256f71e506cf",
  //     "accountType": "Counselor",
  //     "uid": _auth.currentUser.uid,
  //   });
  //
  //   return user;
  // }

}

