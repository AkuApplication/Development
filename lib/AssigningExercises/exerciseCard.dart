import 'package:chat_app/AssigningExercises/CheckboxExercises/anxiety.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/bipolar.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/depression.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/meditation.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/ptsd.dart';
import 'package:chat_app/ManageNotes/notes_app/screens/constants.dart';
import 'package:chat_app/MentalHealthTest/testRecords/recordModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'exerciseModel.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise record;

  ExerciseCard({this.record});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = record.timestamp.toDate();
    final size = MediaQuery.of(context).size;
    double progress;
    List<Widget> listOfWidgets = [];
    if(record.firstExercise == true){
      listOfWidgets.add(Container());
    }
    if(record.secondExercise == true){
      listOfWidgets.add(Container());
    }
    if(record.thirdExercise == true){
      listOfWidgets.add(Container());
    }
    if(record.fourthExercise == true){
      listOfWidgets.add(Container());
    }
    if(record.fifthExercise == true){
      listOfWidgets.add(Container());
    }

    // print(listOfWidgets.length);

    progress = record.progressValue / listOfWidgets.length;

    // print(progress);

    listOfWidgets.clear();

    // print(listOfWidgets.length);

    if(record.firstExercise == true){
      listOfWidgets.add(ExpansionTile(title: Text("For Anxiety"), children: [Anxiety()],));
    }
    if(record.secondExercise == true){
      listOfWidgets.add(ExpansionTile(title: Text("For Bipolar"), children: [BPD()],));
    }
    if(record.thirdExercise == true){
      listOfWidgets.add(ExpansionTile(title: Text("For Depression"), children: [Depression()],));
    }
    if(record.fourthExercise == true){
      listOfWidgets.add(ExpansionTile(title: Text("For Meditation"), children: [Meditation()],));
    }
    if(record.fifthExercise == true){
      listOfWidgets.add(ExpansionTile(title: Text("For PTSD"), children: [PTSD()],));
    }
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: kLargeMargin,
          vertical: kSmallMargin
      ),
      child: ExpansionTile(
        title: Text("Recorded at " + DateFormat.yMEd().add_jms().format(dateTime),),
        children: listOfWidgets,
      ),
    );
  }
}
