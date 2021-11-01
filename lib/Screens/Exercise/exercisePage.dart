import 'package:chat_app/Screens/Exercise/screen/tabata_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app/Screens/Exercise/models.dart';

//The start of the Exercise page
class TimerApp extends StatefulWidget {
  final CustomSettings settings;
  final SharedPreferences prefs;

  TimerApp({this.settings, this.prefs});

  @override
  State<StatefulWidget> createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  _onSettingsChanged() {
    setState(() {});
    widget.settings.save();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabata Timer',
      theme: ThemeData(
        primarySwatch: widget.settings.primarySwatch,
        brightness:
            widget.settings.nightMode ? Brightness.dark : Brightness.light,
      ),
      home: TabataScreen(
        settings: widget.settings,
        prefs: widget.prefs,
        onSettingsChanged: _onSettingsChanged,
      ),
    );
  }
}
