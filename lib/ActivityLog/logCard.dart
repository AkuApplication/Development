import 'package:chat_app/ActivityLog/logModel.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/anxiety.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/bipolar.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/depression.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/meditation.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/ptsd.dart';
import 'package:chat_app/ManageNotes/notes_app/screens/constants.dart';
import 'package:chat_app/MentalHealthTest/testRecords/recordModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogCard extends StatefulWidget {
  final Log record;

  LogCard({this.record});

  @override
  _LogCardState createState() => _LogCardState();
}

class _LogCardState extends State<LogCard> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String accountType;
  List<Widget> listOfWidgets = [];

  @override
  void initState() {
    checkFirestore();
    checkingAssignedExercises();
    super.initState();
  }

  void checkFirestore() async {
    await _firestore.collection("users").doc(_auth.currentUser.uid).get().then((value) {
      setState(() {
        accountType = value["accountType"];
      });
    });
  }

  void checkingAssignedExercises() {
    widget.record.assignedExercises.forEach((element) {
      if(element["first"]["exerciseChosen"] == true){
        listOfWidgets.add(ExpansionTile(title: Text("For Anxiety"), children: [Anxiety()],));
      }
      if(element["second"]["exerciseChosen"] == true){
        listOfWidgets.add(ExpansionTile(title: Text("For Bipolar"), children: [BPD()],));
      }
      if(element["third"]["exerciseChosen"] == true){
        listOfWidgets.add(ExpansionTile(title: Text("For Depression"), children: [Depression()],));
      }
      if(element["fourth"]["exerciseChosen"] == true){
        listOfWidgets.add(ExpansionTile(title: Text("For Meditation"), children: [Meditation()],));
      }
      if(element["fifth"]["exerciseChosen"] == true){
        listOfWidgets.add(ExpansionTile(title: Text("For PTSD"), children: [PTSD()],));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTimeStarted = widget.record.timeStarted.toDate();
    DateTime dateTimeEnded = widget.record.timeEnded.toDate();
    final size = MediaQuery.of(context).size;
    // double progress;
    // List<Widget> listOfWidgets = [];
    // if(record.firstExercise == true){
    //   listOfWidgets.add(Container());
    // }
    // if(record.secondExercise == true){
    //   listOfWidgets.add(Container());
    // }
    // if(record.thirdExercise == true){
    //   listOfWidgets.add(Container());
    // }
    // if(record.fourthExercise == true){
    //   listOfWidgets.add(Container());
    // }
    // if(record.fifthExercise == true){
    //   listOfWidgets.add(Container());
    // }
    //
    // // print(listOfWidgets.length);
    //
    // progress = record.progressValue / listOfWidgets.length;
    //
    // // print(progress);
    //
    // listOfWidgets.clear();
    //
    // // print(listOfWidgets.length);
    //
    // if(record.firstExercise == true){
    //   listOfWidgets.add(ExpansionTile(title: Text("For Anxiety"), children: [Anxiety()],));
    // }
    // if(record.secondExercise == true){
    //   listOfWidgets.add(ExpansionTile(title: Text("For Bipolar"), children: [BPD()],));
    // }
    // if(record.thirdExercise == true){
    //   listOfWidgets.add(ExpansionTile(title: Text("For Depression"), children: [Depression()],));
    // }
    // if(record.fourthExercise == true){
    //   listOfWidgets.add(ExpansionTile(title: Text("For Meditation"), children: [Meditation()],));
    // }
    // if(record.fifthExercise == true){
    //   listOfWidgets.add(ExpansionTile(title: Text("For PTSD"), children: [PTSD()],));
    // }
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: kLargeMargin,
          vertical: kSmallMargin
      ),
      child: ExpansionTile(
        title: Text("Recorded at " + DateFormat.yMEd().add_jms().format(dateTimeStarted),),
        children: [
          Text("Type of Session: " + widget.record.type),
          Text(accountType == "Patient" ? "Counselor: " + widget.record.otherUser : "Patient: " + widget.record.otherUser),
          Text("Session Started at: " + DateFormat.yMEd().add_jms().format(dateTimeStarted)),
          Text("Session Ended at: " + DateFormat.yMEd().add_jms().format(dateTimeEnded)),
          ExpansionTile(
            title: Text("Conversation Records"),
            children: [
              Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.record.otherUser, textAlign: TextAlign.start,),
                  )),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_auth.currentUser.displayName, textAlign: TextAlign.end,),
                  )),
                ],
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.record.conversationRecords.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> map =
                  widget.record.conversationRecords[index];
                  return Container(
                    width: size.width,
                    alignment: map['sendby'] == _auth.currentUser.displayName
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: map['sendby'] == _auth.currentUser.displayName ? Colors.teal.shade300 : Colors.blue,
                      ),
                      child: Text(
                        map['message'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );;
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Assigned Exercises"),
            children: listOfWidgets,
          )
        ],
      ),
    );
  }
}
