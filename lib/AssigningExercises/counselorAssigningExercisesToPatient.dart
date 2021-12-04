import 'package:chat_app/AssigningExercises/CheckboxExercises/anxiety.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/bipolar.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/depression.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/meditation.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/ptsd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CounselorAssigningExercisesToPatient extends StatefulWidget {
  final String chosenUserData;

  CounselorAssigningExercisesToPatient({this.chosenUserData});

  @override
  _CounselorAssigningExercisesToPatientState createState() => _CounselorAssigningExercisesToPatientState();
}

class _CounselorAssigningExercisesToPatientState extends State<CounselorAssigningExercisesToPatient> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Variables for picking which exercises to assign
  bool firstExercise = false;
  bool secondExercise = false;
  bool thirdExercise = false;
  bool fourthExercise = false;
  bool fifthExercise = false;

  //Method to send boolean value to database so that can be fetch later on Patient page of assigned exercises checklist
  void sendChosenExercisesToDatabase() async {
    await _firestore.collection("assignedExercises").doc(widget.chosenUserData).collection("recordsOfExercises").add({
      "first": {
        "exerciseChosen": firstExercise,
        "completed": false,
      },
      "second": {
        "exerciseChosen": secondExercise,
        "completed": false,
      },
      "third": {
        "exerciseChosen": thirdExercise,
        "completed": false,
      },
      "fourth": {
        "exerciseChosen": fourthExercise,
        "completed": false,
      },
      "fifth": {
        "exerciseChosen": fifthExercise,
        "completed": false,
      },
      "time": FieldValue.serverTimestamp(),
      "done": false,
      "by": _auth.currentUser.displayName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assigned Exercises"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Tick the box on the left side to assign those exercises to the patient. When you are done just tap the 'Assign' button",
            textAlign: TextAlign.center,),
            ListTile(
              leading: Checkbox(value: firstExercise, onChanged: (value) {
                setState(() {
                  firstExercise = value;
                });
              },),
              title: Anxiety(),
            ),
            ListTile(
              leading: Checkbox(value: secondExercise, onChanged: (value) {
                setState(() {
                  secondExercise = value;
                });
              },),
              title: BPD(),
            ),
            ListTile(
              leading: Checkbox(value: thirdExercise, onChanged: (value) {
                setState(() {
                  thirdExercise = value;
                });
              },),
              title: Depression(),
            ),
            ListTile(
              leading: Checkbox(value: fourthExercise, onChanged: (value) {
                setState(() {
                  fourthExercise = value;
                });
              },),
              title: Meditation(),
            ),
            ListTile(
              leading: Checkbox(value: fifthExercise, onChanged: (value) {
                setState(() {
                  fifthExercise = value;
                });
              },),
              title: PTSD(),
            ),
            ElevatedButton(
              child: Text("Assign"),
              onPressed: (firstExercise == false && secondExercise == false && thirdExercise == false && fourthExercise == false && fifthExercise == false) ? null : () {
                sendChosenExercisesToDatabase();
              },
            )
          ],
        ),
      ),
    );
  }
}
