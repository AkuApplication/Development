import 'dart:async';
import 'dart:math';

import 'package:chat_app/Authenticate/Methods.dart';
import 'package:chat_app/Screens/About/aboutpage.dart';
import 'package:chat_app/Screens/Counsultation/HomeScreen.dart';
import 'package:chat_app/Screens/Exercise/exercisepage.dart';
import 'package:chat_app/Screens/Profile/profilepage.dart';
import 'package:chat_app/Screens/Therapist/therapistpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _wordController = TextEditingController();

  List<String> _words = [
    "You do make a different in this world.",
    "Give yourself some credit how far you’ve come.",
    "Keep taking time for yourself until you’re you again."
  ];

  Map<String, dynamic> userDisplayname;

  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void currentUser() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    await _firestore
        .collection('users')
        .where("name", isEqualTo: _auth.currentUser.displayName)
        // .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        // for (int i = 0; i < value.docs.length; i++) {
        //   userMap = value.docs[i].data();
        //   var userLength = value.docs.length;
        // }
        userDisplayname = value.docs[0].data();
      });
    });
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      final random = new Random();
      int num = random.nextInt(_words.length);
      _wordController.text = _words[num];
      // print(wordController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: Text("Homepage"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => logOut(context))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                // color: Color(0xFF337B6E),
                borderRadius: BorderRadius.circular(10.0),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.3),
                //     spreadRadius: 5.0,
                //     blurRadius: 7.0,
                //     offset: Offset(0, 3),
                //   ),
                // ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          'Username: Patient #1',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 0.30,
                          ),
                        ),
                        Text(
                          'Account Type: Patient',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Profile()));
                      print('This will redirect to Profile Page');
                    },
                    child: Icon(
                      Icons.account_circle,
                      size: 45.0,
                      color: Colors.black12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              height: 180,
              child: Card(
                color: Colors.blue.shade300,
                elevation: 10.0,
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    decoration: InputDecoration(isDense: true),
                    maxLines: 2,
                    controller: _wordController,
                    enabled: false,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ),
              // Card(
              //   child: TextField(
              //     maxLines: 1,
              //     controller: _wordController,
              //     enabled: false,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: "Quote",
              //     ),
              //     textAlign: TextAlign.center,
              //     textAlignVertical: TextAlignVertical.center,
              //   ),
              // ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: [
                  InkWell(
                    // Tap to move to Counsultation/Homescreen
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomeScreen()));
                      print('This will redirect to Counseling Page');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.teal.shade100,
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://image.flaticon.com/icons/png/512/1651/1651707.png',
                              height: 100,
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              'Counseling',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => exercise(timerApp)));

                      // MaterialPageRoute(builder: (_) => exercise()));
                      print('This will redirect to Exercise Page');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.purple.shade100,
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://image.flaticon.com/icons/png/512/2928/2928158.png',
                              height: 100,
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              'Exercise',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Therapists()));
                      print('This will redirect to Therapist Page');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.red.shade100,
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://image.flaticon.com/icons/png/512/1971/1971437.png',
                              height: 100,
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              'Therapist',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => About()));
                      print('This will redirect to About Page');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.orange.shade100,
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://image.flaticon.com/icons/png/512/4245/4245351.png',
                              height: 100,
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              'About',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
