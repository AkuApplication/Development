import 'dart:async';

import 'package:chat_app/ManageNotes/notes_app/screens/constants.dart';
import 'package:chat_app/MentalHealthTest/SetupPage/editMentalHealthTestModel.dart';
import 'package:chat_app/MentalHealthTest/testRecords/recordModel.dart';
import 'package:chat_app/SetupExercises/editExerciseModel.dart';
import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditMentalHealthTestCard extends StatefulWidget {
  final EditMentalHealthTestRecord record;

  EditMentalHealthTestCard({this.record});

  @override
  _EditMentalHealthTestCardState createState() => _EditMentalHealthTestCardState();
}

class _EditMentalHealthTestCardState extends State<EditMentalHealthTestCard> {

  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> listOfTitleEditingController = [];
  // int count = 0;
  TextEditingController scoreController;
  TextEditingController questionController;
  TextEditingController answerController;
  AutovalidateMode autoValidateModeOnUserInteraction = AutovalidateMode.onUserInteraction;
  AutovalidateMode autoValidateModeDisabled = AutovalidateMode.disabled;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> newListOfQuestions = [];
  List<String> newListOfAnswers = [];
  List<String> newListOfScores = [];
  StreamSubscription listenForChanges;
  List<DropdownMenuItem<dynamic>> scoreList;
  List<List> listOfScoreList = [];
  List<List> listOfAnswerList = [];
  List items = [];
  List scoreString = [];
  List<TextEditingController> answerString = [];
  List<Widget> listWidget;
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

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
              await _firestore.collection("setupMentalHealthTest").doc(widget.record.docId).delete();
            },
          ),
          title: Text("Mental Health Test No.${widget.record.docId}"),
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.record.questions.length,
              itemBuilder: (context, index) {
                questionController = TextEditingController();
                questionController.text = widget.record.questions[index];
                return  Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: decoText.copyWith(
                          labelText: "Question",
                        ),
                        onSaved: (newValue) {
                          setState(() {
                           newListOfQuestions.add(newValue);
                          });
                        },
                        controller: questionController,
                        autovalidateMode: questionController.text.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
                        validator: (value) {
                          if(value.isEmpty){
                            return "Required. Can't be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            ElevatedButton(
              child: Text("Edit Mental Health Test"),
              onPressed: () async {
                if(_formKey.currentState.validate()){
                  _formKey.currentState.save();

                  await _firestore.collection("setupMentalHealthTest").doc(widget.record.docId).update({
                    "listOfQuestion": newListOfQuestions,
                    "listOfAnswer": newListOfAnswers,
                    "listOfScore": newListOfScores,
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
