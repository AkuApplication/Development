import 'package:chat_app/ManageNotes/notes_app/screens/constants.dart';
import 'package:chat_app/MentalHealthTest/testRecords/recordModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordCard extends StatelessWidget {
  final Record record;

  RecordCard({this.record});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = record.timestamp.toDate();

    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: kLargeMargin,
          vertical: kSmallMargin
      ),
      child: ExpansionTile(
        title: Text("Recorded at " + DateFormat.yMEd().add_jms().format(dateTime),),
        children: [
          Container(
            width: 600,
            height: 600,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: record.questions.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text("Question ${index + 1}: " + record.questions[index], textAlign: TextAlign.center,),
                      Text("Answer ${index + 1}: " + record.answers[index],textAlign: TextAlign.center,),
                      SizedBox(height: 20,)
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
