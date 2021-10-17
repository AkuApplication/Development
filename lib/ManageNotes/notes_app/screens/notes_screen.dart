import 'package:chat_app/ManageNotes/notes_app/components/notes_stream.dart';
import 'package:chat_app/ManageNotes/notes_app/screens/note_screen.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  static final String routeName = '/';
  String chosenUserData;
  NotesScreen({this.chosenUserData});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

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
