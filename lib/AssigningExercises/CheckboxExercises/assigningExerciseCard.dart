import 'dart:async';

import 'package:chat_app/AssigningExercises/CheckboxExercises/assigningExerciseModel.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/assigningExercisesHomePage.dart';
import 'package:chat_app/ManageNotes/notes_app/screens/constants.dart';
import 'package:chat_app/MentalHealthTest/testRecords/recordModel.dart';
import 'package:chat_app/assets/CheckboxFormField.dart';
import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssigningExerciseCard extends StatefulWidget {
  final AssigningExerciseRecord record;
  final String chosenUserData;
  List<bool> listOfBool = [];

  AssigningExerciseCard({this.record, this.chosenUserData});

  @override
  _AssigningExerciseCardState createState() => _AssigningExerciseCardState();
}

class _AssigningExerciseCardState extends State<AssigningExerciseCard> {

  // final _formKey = GlobalKey<FormState>();
  List<TextEditingController> listOfTitleEditingController = [];
  int count = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController stepController;
  TextEditingController detailsController;
  AutovalidateMode autoValidateModeOnUserInteraction = AutovalidateMode.onUserInteraction;
  AutovalidateMode autoValidateModeDisabled = AutovalidateMode.disabled;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> newListOfSteps = [];
  List<String> newListOfDetails = [];
  StreamSubscription listenForChanges;
  bool isAssigned = false;

  @override
  Widget build(BuildContext context) {
    // DateTime dateTime = record.title.toDate();

    // listOfTitleEditingController.add(TextEditingController(text: widget.record.title));
    // count++;
    // print(count);
    titleController.text = widget.record.title;
    // print(listOfBool.length);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        maintainState: true,
        // initiallyExpanded: true,
        leading: CheckboxFormField(
          initialValue: isAssigned,
          onSaved: (newValue) {
            setState(() {
              widget.listOfBool.add(newValue);
            });
          },
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: decoText.copyWith(
              labelText: "Title of Exercise",
            ),
            readOnly: true,
            controller: titleController,
          ),
        ),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.record.steps.length,
            itemBuilder: (context, index) {
              stepController = TextEditingController();
              stepController.text = widget.record.steps[index];
              detailsController = TextEditingController();
              detailsController.text = widget.record.details[index];
              return  Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: decoText.copyWith(
                        labelText: "Name for the Step",
                      ),
                      readOnly: true,
                      controller: stepController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: decoText.copyWith(
                        labelText: "Detailed Instructions for the Step Above",
                      ),
                      readOnly: true,
                      controller: detailsController,
                      maxLines: null,
                    ),
                  ),
                ],
              );
            },
          ),
          // ElevatedButton(
          //   child: Text("Assign"),
          //   onPressed: () {
          //     listOfBool.clear();
          //     _formKey.currentState.save();
          //     print(listOfBool.length);
          //     print(listOfBool.toString());
          //   },
          // ),
        ],
      ),
    );
  }
}
