import 'package:chat_app/MentalHealthTest/SetupPage/editMentalHealthTestCard.dart';
import 'package:chat_app/MentalHealthTest/SetupPage/editMentalHealthTestModel.dart';
import 'package:chat_app/SetupExercises/editExerciseCard.dart';
import 'package:chat_app/SetupExercises/editExerciseModel.dart';
import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditMentalHealthTest extends StatefulWidget {

  @override
  _EditMentalHealthTestState createState() => _EditMentalHealthTestState();
}

class _EditMentalHealthTestState extends State<EditMentalHealthTest> {

  List listOfFormKey = [];
  // final _formKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Exercises"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _firestore.collection("setupMentalHealthTest").snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final records = snapshot.data.docs;

              List<EditMentalHealthTestCard> recordCards = [];
              for(var record in records) {
                EditMentalHealthTestRecord recordObject = EditMentalHealthTestRecord(
                    questions: record["listOfQuestion"],
                    answers: record["listOfAnswer"],
                    scores: record["listOfScore"],
                    lengthOfAnswers: record["lengthOfAnswers"],
                    docId: record.id,
                );

                recordCards.add(EditMentalHealthTestCard(
                  record: recordObject,
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
