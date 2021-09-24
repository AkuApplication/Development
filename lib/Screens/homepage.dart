import 'dart:async';
import 'dart:math';

import 'package:chat_app/Authenticate/Methods.dart';
import 'package:chat_app/Screens/About/aboutpage.dart';
import 'package:chat_app/Screens/Counsultation/HomeScreen.dart';
import 'package:chat_app/Screens/Exercise/exercisepage.dart';
import 'package:chat_app/Screens/Profile/profilepage.dart';
import 'package:chat_app/Screens/Therapist/therapistspage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  // String _username;
  // String _account;
  // String _profileURL;
  //
  // HomePage(this._username, this._account, this._profileURL);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _wordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _username2;
  String _account2;
  String _profileURL2;

  void checkFirestore() async {
    await _firestore.collection("users").doc(_auth.currentUser.uid).get().then((value) {
      setState(() {
        _username2 = value.data()["name"];
        _account2 = value.data()["accountType"];
        _profileURL2 = value.data()["profileURL"];

      });

    });
  }

  void checkQuotes() async {
    await _firestore.collection("quotes").doc("words").get().then((value) {
      Timer.periodic(Duration(seconds: 3), (timer) {
        final random = new Random();
        int num = random.nextInt(value.data()["arrayOfWords"].length);
        _wordController.text = value.data()["arrayOfWords"][num];
      });
    });
  }

  @override
  void initState() {

    // _username2 = widget._username;
    // _account2 = widget._account;
    // _profileURl2 = widget._profileURL;
    checkFirestore();

    checkQuotes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: Text("Homepage"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => Methods().logOut(context))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          'Username: $_username2',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 0.30,
                          ),
                        ),
                        Text(
                          'Account Type: $_account2',
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
                  Container(
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                      child: (_profileURL2 == null) ? Icon(
                        Icons.account_circle,
                        size: 45.0,
                        color: Colors.black12,
                      ) : Image.network(_profileURL2),
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Profile(),));
                        print("This will redirect to Profile Page");
                      },
                    ),
                  )
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (_) => Profile()));
                  //     print('This will redirect to Profile Page');
                  //   },
                  //   child: Icon(
                  //     Icons.account_circle,
                  //     size: 45.0,
                  //     color: Colors.black12,
                  //   ),
                  // ),
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
