import 'package:chat_app/Screens/Counsultation/notes_app/model/note.dart';
import 'package:chat_app/Screens/Counsultation/notes_app/screens/note_screen.dart';
import 'package:chat_app/Screens/Counsultation/notes_app/screens/notes_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  // This widget is the root of your application.
  String chosenUserData;
  Notes({this.chosenUserData});

  @override
  _NotesState createState() => _NotesState();
}


class _NotesState extends State<Notes> {

  @override
  void initState() {
    print("1");
    print(widget.chosenUserData);
    super.initState();
  }

  Note note;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: NotesScreen.routeName,
//      routes: {
//        NotesScreen.routeName: (context) => NotesScreen(),
//        NoteScreen.routeName: (context) => NoteScreen()
//      },

      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          NotesScreen.routeName: (context) => NotesScreen(chosenUserData: widget.chosenUserData),
          NoteScreen.routeName: (context) => NoteScreen(settings.arguments)
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
