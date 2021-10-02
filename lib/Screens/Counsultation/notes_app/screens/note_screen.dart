import 'package:chat_app/Screens/Counsultation/notes_app/model/note.dart';
import 'package:chat_app/Screens/Counsultation/notes_app/screens/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  static final String routeName = '/note';

  Note note; // Take from notes Stream

  QueryDocumentSnapshot chosenUserData;

  NoteScreen(Object arguments,
      {this.note,
      this.chosenUserData}); // Ammbil all Notes id, Notes Title and the Note it self + Chosen User Data atu

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  Note note;
  String titleString = '';
  String noteString = '';

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController controllerTitle;
  TextEditingController controllerNote;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    note = widget.note;
    if (note != null) {
      titleString = note.title;
      noteString = note.note;
    }

    controllerTitle =
        TextEditingController(text: note != null ? note.title : '');
    controllerNote = TextEditingController(text: note != null ? note.note : '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: Text(
          note != null ? 'Edit note' : 'Add note',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              saveClicked();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              _firestore
                  .collection('notesRoom')
                  .doc(widget.chosenUserData.get('uid'))
                  .collection('notes')
                  .doc(note.id)
                  .delete();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: kSmallMargin),
            child: TextField(
              controller: controllerTitle,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Title',
              ),
              onChanged: (value) {
                titleString = value;
              },
            ),
          ),
          SizedBox(
            height: kSmallMargin,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(kLargeMargin),
              child: TextField(
                controller: controllerNote,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(hintText: 'Note content'),
                onChanged: (value) {
                  noteString = value;
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void saveClicked() {
    if (note == null) {
      _firestore
          .collection('notesRoom')
          .doc(widget.chosenUserData.get("uid"))
          .collection('notes')
          .doc(note.id)
          .set({'title': titleString, 'note': noteString});
    } else {
      _firestore
          .collection('notesRoom')
          .doc(widget.chosenUserData.get("uid"))
          .collection('notes')
          .doc(note.id)
          .update({'title': titleString, 'note': noteString});
    }
  }
}
