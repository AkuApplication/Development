import 'package:chat_app/AssigningExercises/exerciseCard.dart';
import 'package:chat_app/AssigningExercises/exerciseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckListOfExercises extends StatefulWidget {

  @override
  _CheckListOfExercisesState createState() => _CheckListOfExercisesState();
}

class _CheckListOfExercisesState extends State<CheckListOfExercises> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double progressValue = 0.0;
  double addedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checklist of Assigned Exercises"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: LinearProgressIndicator(
                    color: Colors.teal,
                    backgroundColor: Colors.grey,
                    minHeight: 20.0,
                    value: progressValue,
                  ),
                ),
              ),
              StreamBuilder(
                stream: _firestore.collection("assignedExercises").doc(_auth.currentUser.uid).collection("recordsOfExercises").snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    final records = snapshot.data.docs;

                    List<ExerciseCard> exerciseCards = [];
                    List<Widget> emptyWidgets = [];
                    double exerciseValue = 1.0;

                    for (var empty in records) {
                      emptyWidgets.add(Container());
                    }

                    addedValue = (exerciseValue / emptyWidgets.length);

                    print(progressValue);

                    for (var record in records) {
                      Exercise recordObject = Exercise(
                        firstExercise: record["first"]["exerciseChosen"],
                        secondExercise: record["second"]["exerciseChosen"],
                        thirdExercise: record["third"]["exerciseChosen"],
                        fourthExercise: record["fourth"]["exerciseChosen"],
                        fifthExercise: record["fifth"]["exerciseChosen"],
                        progressValue: addedValue,
                        timestamp: record["time"],
                      );

                      exerciseCards.add(ExerciseCard(
                        record: recordObject,
                      ));

                    }
                    //
                    return Column(
                      children: exerciseCards,
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
