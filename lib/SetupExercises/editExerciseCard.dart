import 'dart:async';

import 'package:chat_app/ManageNotes/notes_app/screens/constants.dart';
import 'package:chat_app/MentalHealthTest/testRecords/recordModel.dart';
import 'package:chat_app/SetupExercises/editExerciseModel.dart';
import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditExerciseCard extends StatefulWidget {
  final EditExerciseRecord record;

  EditExerciseCard({this.record});

  @override
  _EditExerciseCardState createState() => _EditExerciseCardState();
}

class _EditExerciseCardState extends State<EditExerciseCard> {

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
          leading: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () async {
              await _firestore.collection("setupExercises").doc(widget.record.docId).delete();
            },
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: decoText.copyWith(
                labelText: "Title of Exercise",
              ),
              // onSaved: (newValue) {
              //   setState(() {
              //     listOfTitleEditingController[index].text = newValue;
              //   });
              // },
              controller: titleController,
              // onChanged: (value) {
              //   setState(() {
              //     listOfTitleEditingController[index].text = value;
              //   });
              // },
              autovalidateMode: titleController.text.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
              validator: (value) {
                if(value.isEmpty){
                  return "Required. Can't be empty";
                } else {
                  return null;
                }
              },
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
                        onSaved: (newValue) {
                          setState(() {
                           newListOfSteps.add(newValue);
                          });
                        },
                        controller: stepController,
                        // onChanged: (value) {
                        //   setState(() {
                        //     listOfStepsEditingController[index].text = value;
                        //   });
                        // },
                        autovalidateMode: stepController.text.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
                        validator: (value) {
                          if(value.isEmpty){
                            return "Required. Can't be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: decoText.copyWith(
                          labelText: "Detailed Instructions for the Step Above",
                        ),
                        controller: detailsController,
                        autovalidateMode: detailsController.text.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
                        onSaved: (newValue) {
                          setState(() {
                            newListOfDetails.add(newValue);
                          });
                        },
                        maxLines: null,
                      ),
                    ),
                  ],
                );
              },
            ),
            ElevatedButton(
              child: Text("Edit Exercise"),
              onPressed: () async {
                if(_formKey.currentState.validate()){
                  _formKey.currentState.save();

                  await _firestore.collection("setupExercises").doc(widget.record.docId).update({
                    "title": titleController.text,
                    "listOfSteps": newListOfSteps,
                    "listOfDetails": newListOfDetails,
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("You have edited an Exercise"),
                      ),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please make sure everything is filled correctly"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
