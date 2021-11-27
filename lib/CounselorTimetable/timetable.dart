import 'package:chat_app/CounselorTimetable/event_editing_page.dart';
import 'package:chat_app/CounselorTimetable/provider/event_provider.dart';
import 'package:chat_app/CounselorTimetable/widget/calendar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Timetable extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final String title = "Calendar Events App";

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => EventProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData().copyWith(
            accentColor: Colors.teal.shade400,
            primaryColor: Colors.teal.shade400,
          ),
          // darkTheme: ThemeData.light().copyWith(
          //   scaffoldBackgroundColor: Colors.white,
          //   accentColor: Colors.teal.shade400,
          //   primaryColor: Colors.teal.shade400,
          // ),
          home: MainPage(),
        ),
      ); // Materia lApp
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(Timetable.title),
          centerTitle: true,
        ),
        body: Calendarwidget(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.teal.shade500,
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EventEditingPage()))),
      );
}
