import 'package:chat_app/MentalHealthTest/testRecords/recordCard.dart';
import 'package:chat_app/MentalHealthTest/testRecords/recordModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Patients extends StatefulWidget {
  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List patientList = [];

  void getDataFromFirestore() async {
    await _firestore.collection("users").where("accountType", isEqualTo: "Patient").get().then((value) {
      setState(() {
        patientList = value.docs.toList();
      });
    });
  }

  @override
  void initState() {
    getDataFromFirestore();
    super.initState();
  }

   @override
  Widget build(BuildContext context) {
     // Provide us total height & width of our screen
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF337B6E),
        title: Text('Patients'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: Color(0xFF337B6E),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36.0),
                  bottomRight: Radius.circular(36.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(45.0),
            child: ListView.builder(
              itemCount: patientList.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(patientList[index]["profileURL"]),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(patientList[index]["name"]),
                          ],
                        ),
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        'Details for ${patientList[index]["name"]}',
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          letterSpacing: 0.5,
                          color: Colors.blueGrey,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                'Full Name: ${patientList[index]["name"]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 0.5,
                                  color: Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              SelectableText(
                                'Gender: ${patientList[index]["gender"]}}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 0.5,
                                  color: Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              SelectableText(
                                'Contact: ${patientList[index]["contact"]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 0.5,
                                  color: Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              SelectableText(
                                'Email: ${patientList[index]["email"]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 0.5,
                                  color: Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              SelectableText(
                                'Condition: ${patientList[index]["condition"]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 0.5,
                                  color: Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              SelectableText(
                                'No. of logins: ${patientList[index]["numOfLogins"]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 0.5,
                                  color: Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              SelectableText(
                                'Mental Health Test Records: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 0.5,
                                  color: Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                              StreamBuilder(
                                stream: _firestore.collection("records").doc(patientList[index]["uid"]).collection("record").snapshots(),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
