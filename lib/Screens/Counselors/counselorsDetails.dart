import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//All of the Counsellor's Details
class Counselors extends StatefulWidget {
  @override
  _CounselorsState createState() => _CounselorsState();
}

class _CounselorsState extends State<Counselors> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List counselorList = [];

  void getDataFromFirestore() async {
    await _firestore.collection("users").where("accountType", isEqualTo: "Counselor").get().then((value) {
      setState(() {
        counselorList = value.docs.toList();
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
        backgroundColor: Colors.teal.shade300,
        title: Text('Counselors'),
      ),
      body: Stack(
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: Colors.teal.shade300,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36.0),
                bottomRight: Radius.circular(36.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(45.0),
            child: ListView.builder(
              itemCount: counselorList.length,
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
                              backgroundImage: NetworkImage(counselorList[index]["profileURL"]),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(counselorList[index]["name"]),
                          ],
                        ),
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        'Details for ${counselorList[index]["name"]}',
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
                                'Full Name: ${counselorList[index]["name"]}',
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
                                'Gender: ${counselorList[index]["gender"]}',
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
                                'Contact: ${counselorList[index]["contact"]}',
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
                                'Email: ${counselorList[index]["email"]}',
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
                                'Profession: ${counselorList[index]["profession"]}',
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
