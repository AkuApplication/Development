import 'dart:async';
import 'dart:math';

import 'package:chat_app/AssigningExercises/allExercisesPage.dart';
import 'package:chat_app/MoodTracker/start_page.dart';
import 'package:chat_app/Notifications/notificationSettingsPage.dart';
import 'package:chat_app/Notifications/notificationsMethods.dart';
import 'package:chat_app/SystemAuthentication/Methods.dart';
import 'package:chat_app/Screens/About/aboutPage.dart';
import 'package:chat_app/Counselling/HomeScreen.dart';
import 'package:chat_app/ProfileManagement/PatientProfile/profilePage.dart';
import 'package:chat_app/Screens/Counselors/allCounselorsDetails.dart';
import 'package:chat_app/CounselorTimetable/timetable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  HomePage({this.sharedPreferences});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Getting related Firebase instances to be able to interact with Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Initializing variables
  final _wordController = TextEditingController();
  String _username2;
  String _account2;
  String _profileURL2;

  // //Variables for the notifications value
  // bool firstReminder;
  // bool secondReminder;
  //
  // void firstNotification() async {
  //   setState(() {
  //     firstReminder = widget.sharedPreferences.getBool("firstReminder") ?? true;
  //   });
  //   if(firstReminder ==  true){
  //     await CustomNotification().showNotificationForTODOChecklist();
  //   } else {
  //     await CustomNotification().cancelNotificationForTODO();
  //   }
  // }
  //
  // void secondNotification() async {
  //   setState(() {
  //     secondReminder = widget.sharedPreferences.getBool("secondReminder") ?? true;
  //   });
  //   if(secondReminder ==  true){
  //     await CustomNotification().showNotificationEveryMinute();
  //   } else {
  //     await CustomNotification().cancelNotificationForMoodTracker();
  //   }
  // }

  //Method for stopping notifications when logged out
  void stopAllNotifications() async {
    await widget.sharedPreferences.clear().then((value) async {
      await CustomNotification()
          .cancelNotificationForTODO()
          .then((value) async {
        await CustomNotification().cancelNotificationForMoodTracker();
      });
    });
  }
  // //Method for stopping notifications when logged out
  // void stopSecondNotifications() async {
  //
  // }

  //Getting data from Firestore and inserting it to a new variable to be displayed at the screen
  void checkFirestore() async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        _username2 = value.data()["name"];
        _account2 = value.data()["accountType"];
        _profileURL2 = value.data()["profileURL"];
      });
    });
  }

  //Getting Quotes from Firestore to be displayed periodically and its changing
  void checkQuotes() async {
    await _firestore.collection("quotes").doc("words").get().then((value) {
      Timer.periodic(Duration(seconds: 3), (timer) {
        final random = new Random();
        int num = random.nextInt(value.data()["arrayOfWords"].length);
        _wordController.text = value.data()["arrayOfWords"][num];
      });
    });
  }

  //Updating the numOfLogins of the user everytime the user reached this page
  void addNumOfLogins() async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser.uid)
        .update({"numOfLogins": FieldValue.increment(1)});
  }

  //Getting SharedPreferences instance
  // void getPref() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  // }

  //Initial state of the page
  @override
  void initState() {
    // getPref();
    addNumOfLogins();
    checkFirestore();
    checkQuotes();
    // firstNotification();
    // secondNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: Text("Patient Homepage"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationSettingsPage(
                    sharedPreferences: widget.sharedPreferences,
                  ),
                )),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Methods().logOut(context);
              stopAllNotifications();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: size.height / 0.8,
            width: size.width,
            margin: EdgeInsets.symmetric(
                vertical: size.height / 50, horizontal: size.width / 30),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Username: $_username2',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w200,
                                      letterSpacing: 0.30,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Account Type: $_account2',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w200,
                                      letterSpacing: 0.30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: size.width / 8,
                          height: size.height / 8,
                          child: GestureDetector(
                            child: (_profileURL2 == null)
                                ? Icon(
                                    Icons.account_circle,
                                    size: 45.0,
                                    color: Colors.black12,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(_profileURL2),
                                  ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(),
                                  ));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.height / 5,
                  child: Card(
                    color: Colors.blue.shade300,
                    elevation: 10.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        decoration: InputDecoration(
                            isDense: true, border: InputBorder.none),
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
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    primary: false,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: size.aspectRatio / 0.5,
                    children: [
                      InkWell(
                        // Tap to move to Counseling HomeScreen
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.teal.shade100,
                          elevation: 10.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://image.flaticon.com/icons/png/512/1651/1651707.png',
                                height: size.height / 10,
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Counseling',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllExercises()));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.purple.shade100,
                          elevation: 10.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://image.flaticon.com/icons/png/512/2928/2928158.png',
                                height: size.height / 10,
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Exercises',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Counselors(),
                              ));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.red.shade100,
                          elevation: 10.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://image.flaticon.com/icons/png/512/1971/1971437.png',
                                height: size.height / 10,
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Therapists',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StartPage(),
                              ));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.lightBlue.shade200,
                          elevation: 10.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://cdn-icons-png.flaticon.com/512/3062/3062575.png',
                                height: size.height / 10,
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Mood Tracker',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => About(),
                              ));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.orange.shade100,
                          elevation: 10.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://image.flaticon.com/icons/png/512/4245/4245351.png',
                                height: size.height / 10,
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'About',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Timetable(),
                              ));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.grey.shade300,
                          elevation: 10.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://cdn-icons-png.flaticon.com/512/2693/2693507.png',
                                height: size.height / 10,
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Timetable',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}