import 'package:chat_app/ManageNotes/notes_app/model/note.dart';
import 'package:chat_app/ManageNotes/notes_app/screens/constants.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final Function onPressed;

  NoteCard({this.note, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: kLargeMargin, vertical: kSmallMargin),
        child: ListTile(
          title: Text(note.title),
          subtitle: Text(note.note),
        ),
      ),
    );
  }
}
