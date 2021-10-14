import 'package:chat_app/MentalHealthTest/testRecords/recordCard.dart';
import 'package:chat_app/MentalHealthTest/testRecords/recordModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Screen for showing the records in Profile Page
class AllRecords extends StatefulWidget {

  @override
  _AllRecordsState createState() => _AllRecordsState();
}

class _AllRecordsState extends State<AllRecords> {

  //Getting related firebase instances to be able to interact with the Firebase features
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal.shade300,
        title: Text('All Records'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: _firestore.collection("records").doc(_auth.currentUser.uid).collection("record").snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                final records = snapshot.data.docs;

                List<RecordCard> recordCards = [];
                for (var record in records) {
                  Record recordObject = Record(
                    questions: record["record"]["questions"],
                    answers: record["record"]["answers"],
                    timestamp: record["time"]
                  );

                  recordCards.add(RecordCard(
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
      ),
    );
  }
}
