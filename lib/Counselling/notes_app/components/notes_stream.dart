import 'package:chat_app/Counselling/notes_app/components/note_card.dart';
import 'package:chat_app/Counselling/notes_app/model/note.dart';
import 'package:chat_app/Counselling/notes_app/screens/note_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotesStream extends StatefulWidget {
  String chosenUserData;


  NotesStream({this.chosenUserData});

  @override
  _NotesStreamState createState() => _NotesStreamState();
}

class _NotesStreamState extends State<NotesStream> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    print("3");
    print(widget.chosenUserData);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection("notesRoom").doc(widget.chosenUserData)
          .collection('notes')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            backgroundColor: Colors.limeAccent,
          );
        }

        final notes = snapshot.data.docs;
        print("Notes $notes");
        // final notes = snapshot.data["arrayNote"];

        List<NoteCard> noteCards = [];
        for (var note in notes) {
          Note noteObject = Note(
              id: widget.chosenUserData,
              title: note["title"],
              note: note["note"],
              // title: note.data['title'],
              // note: note.data['note']);
          );
          noteCards.add(NoteCard(
            note: noteObject,
            onPressed: () {
              Navigator.pushNamed(context, NoteScreen.routeName,
                  arguments: noteObject);
            },
          ));
        }

        return Column(
          children: noteCards,
        );
      },
    );
  }
}
