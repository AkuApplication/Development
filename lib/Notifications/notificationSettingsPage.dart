import 'dart:async';

import 'package:chat_app/ActivityLog/patientLogPage.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/anxiety.dart';
import 'package:chat_app/AssigningExercises/checklistExercises.dart';
import 'package:chat_app/AssigningExercises/counselorAssigningExercisesToPatient.dart';
import 'package:chat_app/AssigningExercises/exerciseModel.dart';
import 'package:chat_app/AssigningExercises/exerciseCard.dart';
import 'package:chat_app/Notifications/notificationsMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_maintained/sms.dart';

class NotificationSettingsPage extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  NotificationSettingsPage({this.sharedPreferences});

  @override
  _NotificationSettingsPageState createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Variables for the notifications value
  bool firstReminder;
  bool secondReminder;

  //Variables for picking which exercises to assign
  bool firstExercise = false;
  bool secondExercise = false;
  bool thirdExercise = false;
  bool fourthExercise = false;
  bool fifthExercise = false;

  @override
  void initState() {
    listenToSMS();
    // initNotif();
    firstNotification();
    secondNotification();
    super.initState();
  }

  // void initNotif() async {
  //   await CustomNotification().initialized(context);
  // }

  StreamSubscription listenerForSMS;

  void listenToSMS() {
    listenerForSMS = _firestore.collection("appointment").doc("date").snapshots().listen((event) {
      if(event.data()["set"] == true){
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Appointment is Set"),
          );
        },);
      } else if(event.data()["set"] == false){
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Patient just set a date for appointment. Do approve or reject it"),
          );
        });
      } else {
        return null;
      }
    });
  }

  void firstNotification() async {
    setState(() {
      firstReminder = widget.sharedPreferences.getBool("firstReminder") ?? true;
    });
    // if(firstReminder ==  true){
    //   await CustomNotification().showNotificationForTODOChecklist();
    // } else {
    //   await CustomNotification().cancelNotificationForTODO();
    // }
  }

  void secondNotification() async {
    setState(() {
      secondReminder = widget.sharedPreferences.getBool("secondReminder") ?? true;
    });
    // if(secondReminder ==  true){
    //   await CustomNotification().showNotificationEveryMinute();
    // } else {
    //   await CustomNotification().cancelNotificationForMoodTracker();
    // }
  }

  void sendDataToFirebaseForSMSListener() async {
    await _firestore.collection("appointment").doc("date").update({
      "set": true,
    });
  }

  void creatingDatabaseForListenerSMS() async {
    await _firestore.collection("appointment").doc("date").set({
      "set": false,
    });
  }

  void sendSMS() {
    SmsSender sender = SmsSender();
    // String address = "+6738851490"; //change sja nanti address to the contact in Firestore

    String address = "+6738851490";
    SmsMessage message = SmsMessage(address, 'Your appointment with (Counselor name) is set to be on ${DateTime.now()}'); //change some of the Strings to fit into it such as from Firestore the Counselor name and the timestamp
    message.onStateChanged.listen((state) {
      if (state == SmsMessageState.Sent) {
        print("SMS is sent!");
      } else if (state == SmsMessageState.Delivered) {
        print("SMS is delivered!");
      } else {
        print("SMS failed to sent");
      }
    });

    sender.sendSms(message);

    sendDataToFirebaseForSMSListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications Testing"),
      ),
      body: Center(
        child: ListView(
          children: [
            SwitchListTile(
              title: Text("Checklists for Exercises or Tests Notification Reminder"),
              value: firstReminder,
              onChanged: (value) async {
                setState(() {
                  firstReminder = value;
                });
                await widget.sharedPreferences.setBool("firstReminder", firstReminder);
                if(firstReminder ==  true){
                  await CustomNotification().showNotificationForTODOChecklist();
                } else {
                  await CustomNotification().cancelNotificationForTODO();
                }
              },
            ),
            SwitchListTile(
              title: Text('Mood Tracker Notification Reminder'),
              value: secondReminder,
              onChanged: (value) async {
                setState(() {
                  secondReminder = value;
                });
                await widget.sharedPreferences.setBool("secondReminder", secondReminder);
                if(secondReminder ==  true){
                  await CustomNotification().showNotificationDaily();
                } else {
                  await CustomNotification().cancelNotificationForMoodTracker();
                }
              },
            ),
            ElevatedButton(
              child: Text("Button for patient to set their appointment later on"),
              onPressed: () {
                creatingDatabaseForListenerSMS();
              },
            ),
            ElevatedButton(
              child: Text("Send Email about Appointment Date Set"),
              onPressed: () {
                // signedInToGoogleThenSendMail();
                sendSMS();
              },
            ),
            ElevatedButton(
              child: Text("Going to assign exercises to Patient as Counselor"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CounselorAssigningExercisesToPatient(),));
              },
            ),
            ElevatedButton(
              child: Text("Going to checklist of Exercises assigned to Patient"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckListOfExercises(),));
              },
            ),
            ElevatedButton(
              child: Text("Going to user ActivityLog"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PatientLogPage(),));
              },
            ),
            ElevatedButton(
              child: Text("Click this to know how it looks like when user just wants to do Anxiety Exercise without being assigned"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(appBar: AppBar(title: Text("Anxiety Exercises"),),body: Anxiety(),),));
              },
            ),
            // ElevatedButton(
            //   child: Text("Going to 2nd Version Exercise Assigned"),
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
            //   },
            // ),
            // CheckboxListTile(value: firstExercise, onChanged: (value) {
            //   setState(() {
            //     firstExercise = value;
            //   });
            // },),
            // CheckboxListTile(value: secondExercise, onChanged: (value) {
            //   setState(() {
            //     secondExercise = value;
            //   });
            // },),
            // CheckboxListTile(value: thirdExercise, onChanged: (value) {
            //   setState(() {
            //     thirdExercise = value;
            //   });
            // },),
            // CheckboxListTile(value: fourthExercise, onChanged: (value) {
            //   setState(() {
            //     fourthExercise = value;
            //   });
            // },),
            // CheckboxListTile(value: fifthExercise, onChanged: (value) {
            //   setState(() {
            //     fifthExercise = value;
            //   });
            // },),
            // StreamBuilder(
            //   stream: _firestore.collection("assignedExercises").doc("_auth.currentUser.uid").collection("recordsOfExercises").snapshots(),
            //   builder: (context, snapshot) {
            //     if(snapshot.hasData){
            //       final records = snapshot.data.docs;
            //
            //       List<ExerciseCard> exerciseCards = [];
            //       for (var record in records) {
            //         Exercise recordObject = Exercise(
            //             firstExercise: record["first"],
            //             secondExercise: record["second"],
            //             thirdExercise: record["third"],
            //             fourthExercise: record["fourth"],
            //             fifthExercise: record["fifth"],
            //             timestamp: record["time"],
            //         );
            //
            //         exerciseCards.add(ExerciseCard(
            //           record: recordObject,
            //         ));
            //
            //       }
            //       //
            //       return Column(
            //         children: exerciseCards,
            //       );
            //     } else {
            //       return CircularProgressIndicator();
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
