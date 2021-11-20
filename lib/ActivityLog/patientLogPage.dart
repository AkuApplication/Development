import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientLogPage extends StatefulWidget {

  @override
  _PatientLogPageState createState() => _PatientLogPageState();
}

class _PatientLogPageState extends State<PatientLogPage> {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PatientLogPage"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: _firestore.collection("activityLog").doc(_auth.currentUser.uid).collection("sessions").snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  final records = snapshot.data.docs;

                  // List<RecordCard> recordCards = [];
                  // for (var record in records) {
                  //   Record recordObject = Record(
                  //       questions: record["record"]["questions"],
                  //       answers: record["record"]["answers"],
                  //       timestamp: record["time"]
                  //   );
                  //
                  //   recordCards.add(RecordCard(
                  //     record: recordObject,
                  //   ));
                  // }

                  return Column(
                    // children: recordCards,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          )
      ),
    );
  }
}
