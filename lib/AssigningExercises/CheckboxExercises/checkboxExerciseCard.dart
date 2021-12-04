import 'dart:async';

import 'package:chat_app/AssigningExercises/CheckboxExercises/checkboxExerciseModel.dart';
import 'package:chat_app/ManageNotes/notes_app/screens/constants.dart';
import 'package:chat_app/MentalHealthTest/testRecords/recordModel.dart';
import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckboxExerciseCard extends StatefulWidget {
  final CheckboxExerciseRecord record;

  CheckboxExerciseCard({this.record});

  @override
  _CheckboxExerciseCardState createState() => _CheckboxExerciseCardState();
}

class _CheckboxExerciseCardState extends State<CheckboxExerciseCard> {

  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> listOfTitleEditingController = [];
  // int count = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController stepController;
  TextEditingController detailsController;
  AutovalidateMode autoValidateModeOnUserInteraction = AutovalidateMode.onUserInteraction;
  AutovalidateMode autoValidateModeDisabled = AutovalidateMode.disabled;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> newListOfSteps = [];
  List<String> newListOfDetails = [];
  StreamSubscription listenForChanges;

  @override
  Widget build(BuildContext context) {
    // DateTime dateTime = record.title.toDate();

    // listOfTitleEditingController.add(TextEditingController(text: widget.record.title));
    // count++;
    // print(count);
    titleController.text = widget.record.title;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          maintainState: true,
          // initiallyExpanded: true,
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
          ],
        ),
      ),
    );
  }
}
