import 'package:chat_app/Screens/Counsultation/notes_app/components/note_card.dart';
import 'package:chat_app/Screens/Counsultation/notes_app/model/note.dart';
import 'package:chat_app/Screens/Counsultation/notes_app/screens/note_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotesStream extends StatefulWidget {
  QueryDocumentSnapshot chosenUserData;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  NotesStream({this.chosenUserData});

  @override
  _NotesStreamState createState() => _NotesStreamState();
}

class _NotesStreamState extends State<NotesStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget._firestore
          .collection('notesRoom')
          .doc(widget.chosenUserData.get("uid"))
          .collection('notes')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            backgroundColor: Colors.limeAccent,
          );
        }

        final notes = snapshot.data.docs;

        // String doc_id = snapshot.data.DocumentId;

        List<NoteCard> noteCards = [];

        for (var note in notes) {
          // print(snapshot.data.DocumentId);
          Note noteObject = Note(
              id: widget.chosenUserData.get('uid'),
              title: note['title'],
              note: note['note']);
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
