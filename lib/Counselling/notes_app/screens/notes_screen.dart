import 'package:chat_app/Counselling/notes_app/components/notes_stream.dart';
import 'package:chat_app/Counselling/notes_app/screens/note_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  static final String routeName = '/';
  String chosenUserData;
  NotesScreen({this.chosenUserData});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    print("2");
    print(widget.chosenUserData);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: Text('Notes'),
      ),
      body: ListView(
        children: <Widget>[NotesStream(chosenUserData: widget.chosenUserData)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NoteScreen.routeName);
        },
        backgroundColor: Colors.limeAccent,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}