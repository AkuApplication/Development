import 'package:chat_app/CounselorTimetable/event_editing_page.dart';
import 'package:chat_app/CounselorTimetable/provider/event_provider.dart';
import 'package:chat_app/CounselorTimetable/widget/calendar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Timetable extends StatefulWidget {
  static final String title = "Calendar Events App";

  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _account;

  @override
  void initState() {
    checkFirestore();
    super.initState();
  }

  //Getting data from Firestore
  void checkFirestore() async {
    await _firestore.collection("users").doc(_auth.currentUser.uid).get().then((value) {
      setState(() {
        _account = value.data()["accountType"];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(Timetable.title),
          centerTitle: true,
        ),
        body: CalendarWidget(),
        floatingActionButton: _account == "Counselor" ? FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.teal.shade500,
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EventEditingPage())))
        : Container(),
      ),
    );
  }
}

// class MainPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: Text(Timetable.title),
//           centerTitle: true,
//         ),
//         body: CalendarWidget(),
//         floatingActionButton: FloatingActionButton(
//             child: Icon(Icons.add, color: Colors.white),
//             backgroundColor: Colors.teal.shade500,
//             onPressed: () => Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => EventEditingPage()))),
//       );
// }
