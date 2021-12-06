import 'package:chat_app/AssigningExercises/CheckboxExercises/assigningExerciseCard.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/assigningExerciseModel.dart';
import 'package:chat_app/SetupExercises/editExerciseCard.dart';
import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AssigningExercisesHomePage extends StatefulWidget {
  final String chosenUserData;
  // final formKey = GlobalKey<FormState>();

  AssigningExercisesHomePage({this.chosenUserData});

  @override
  _AssigningExercisesHomePageState createState() => _AssigningExercisesHomePageState();
}

class _AssigningExercisesHomePageState extends State<AssigningExercisesHomePage> {

  List listOfFormKey = [];
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TextEditingController> listOfTitleEditingController = [];
  List<TextEditingController> listOfStepsEditingController = [];
  List<TextEditingController> listOfDetailsEditingController = [];
  AutovalidateMode autoValidateModeOnUserInteraction = AutovalidateMode.onUserInteraction;
  AutovalidateMode autoValidateModeDisabled = AutovalidateMode.disabled;
  List listsDoc = [];
  List<List> listForListOfSteps = [];
  List<List> listForListOfDetails = [];
  int count = 0;
  List<TextEditingController> list = [];

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
        child: StreamBuilder(
          stream: _firestore.collection("setupExercises").snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final records = snapshot.data.docs;
              // print(records.length);
              List<Widget> listOfWidget = [];

              List<AssigningExerciseCard> recordCards = [];
              for(var record in records) {
                AssigningExerciseRecord recordObject = AssigningExerciseRecord(
                    steps: record["listOfSteps"],
                    details: record["listOfDetails"],
                    title: record["title"],
                    docId: record.id,
                );

                recordCards.add(AssigningExerciseCard(
                  record: recordObject,
                  chosenUserData: widget.chosenUserData,
                ));
              }
              return Column(
                children: recordCards,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
