import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app/AssigningExercises/BreathingExercise/models.dart';
import 'package:chat_app/AssigningExercises/BreathingExercise/utils.dart';
import 'package:chat_app/AssigningExercises/BreathingExercise/widgets/durationpicker.dart';
import 'package:chat_app/AssigningExercises/BreathingExercise/screen/settings_screen.dart';
import 'package:chat_app/AssigningExercises/BreathingExercise/screen/workout_screen.dart';

class TabataScreen extends StatefulWidget {
  final CustomSettings settings;
  final SharedPreferences prefs;
  final Function onSettingsChanged;

  TabataScreen({
    this.settings,
    this.prefs,
    this.onSettingsChanged,
  });

  @override
  State<StatefulWidget> createState() => _TabataScreenState();
}

class _TabataScreenState extends State<TabataScreen> {
  Tabata _tabata = defaultTabata;

  @override
  initState() {
    var json = widget.prefs.getString('tabata');
    if (json != null) {
      _tabata = Tabata.fromJson(jsonDecode(json));
    }
    super.initState();
  }

  _onTabataChanged() {
    setState(() {});
    _saveTabata();
  }

  _saveTabata() {
    widget.prefs.setString('tabata', jsonEncode(_tabata.toJson()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: Text('Breathing Exercise'),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(widget.settings.silentMode
                  ? Icons.volume_off
                  : Icons.volume_up),
              onPressed: () {
                widget.settings.silentMode = !widget.settings.silentMode;
                widget.onSettingsChanged();
                var snackBar = SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text(
                        'Silent mode ${!widget.settings.silentMode ? 'de' : ''}activated'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              tooltip: 'Toggle silent mode',
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                      settings: widget.settings,
                      onSettingsChanged: widget.onSettingsChanged),
                ),
              );
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Reps'),
            subtitle: Text('${_tabata.reps}'),
            leading: Icon(Icons.repeat),
            onTap: () {
              int _value = _tabata.reps;
              showDialog<int>(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      title: Text('Repetition of Exercise'),
                      content: NumberPicker(
                        value: _value,
                        minValue: 1,
                        maxValue: 10,
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('CANCEL'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(_value),
                          child: Text('OK'),
                        )
                      ],
                    );
                  });
                },
              ).then((reps) {
                if (reps == null) return;
                _tabata.reps = reps;
                _onTabataChanged();
              });
            },
          ),
          Divider(
            height: 10,
          ),
          ListTile(
            title: Text('Starting Countdown'),
            subtitle: Text(formatTime(_tabata.startDelay)),
            leading: Icon(Icons.timer),
            onTap: () {
              showDialog<Duration>(
                context: context,
                builder: (BuildContext context) {
                  return DurationPickerDialog(
                    initialDuration: _tabata.startDelay,
                    title: Text('Countdown before starting exerciset'),
                  );
                },
              ).then((startDelay) {
                if (startDelay == null) return;
                _tabata.startDelay = startDelay;
                _onTabataChanged();
              });
            },
          ),
          ListTile(
            title: Text('Breath In'),
            subtitle: Text(formatTime(_tabata.exerciseTime)),
            leading: Icon(Icons.timer),
            onTap: () {
              showDialog<Duration>(
                context: context,
                builder: (BuildContext context) {
                  return DurationPickerDialog(
                    initialDuration: _tabata.exerciseTime,
                    title: Text('Inhale time'),
                  );
                },
              ).then((exerciseTime) {
                if (exerciseTime == null) return;
                _tabata.exerciseTime = exerciseTime;
                _onTabataChanged();
              });
            },
          ),
          ListTile(
            title: Text('Breath Out'),
            subtitle: Text(formatTime(_tabata.restTime)),
            leading: Icon(Icons.timer),
            onTap: () {
              showDialog<Duration>(
                context: context,
                builder: (BuildContext context) {
                  return DurationPickerDialog(
                    initialDuration: _tabata.restTime,
                    title: Text('Exhale time'),
                  );
                },
              ).then((restTime) {
                if (restTime == null) return;
                _tabata.restTime = restTime;
                _onTabataChanged();
              });
            },
          ),
          Divider(height: 10),
          ListTile(
            title: Text(
              'Total Time',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(formatTime(_tabata.getTotalTime())),
            leading: Icon(Icons.timelapse),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WorkoutScreen(
                      settings: widget.settings, tabata: _tabata)));
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).primaryTextTheme.button?.color,
        tooltip: 'Start Workout',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}