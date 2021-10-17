import 'package:chat_app/ManageNotes/notes_app/model/note.dart';
import 'package:chat_app/ManageNotes/notes_app/screens/note_screen.dart';
import 'package:chat_app/ManageNotes/notes_app/screens/notes_screen.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  // This widget is the start of Manage Notes function.
  String chosenUserData;
  Notes({this.chosenUserData});

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  Note note;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: NotesScreen.routeName,
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          NotesScreen.routeName: (context) => NotesScreen(chosenUserData: widget.chosenUserData),
          NoteScreen.routeName: (context) => NoteScreen(settings.arguments, chosenUserData: widget.chosenUserData,)
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
