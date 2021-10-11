import 'package:flutter/material.dart';

class page_two extends StatefulWidget {

  @override
  State<page_two> createState() => _page_twoState();
}

class _page_twoState extends State<page_two> {
  // This is for the slider components
  var _value = 0.0;
  String info = '';
  var _value2 = 0.0;
  String info2 = '';
  var _value3 = 0.0;
  String info3 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Mood Tracker'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              child: Image.asset("assets/q5.gif"),
              backgroundColor: Colors.transparent,
              radius: 50.0,
            ),
            Text(
              'Why do you feel that way?',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),
            ),
            SizedBox(
              height: 15.0,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 2.0,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text(
                      'How often do you exercise?',
                      style: TextStyle(
                          letterSpacing: 0.1,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 5.0,
                    ),
                    child: Slider(
                      //Properties
                      min: 0.0,
                      max: 9.0,
                      divisions: 9,
                      activeColor: Colors.teal,
                      inactiveColor: Colors.grey,
                      label: info2,
                      value: _value2,
                      //Functions
                      onChanged: (newValue) {
                        setState(() {
                          _value2 = newValue;
                          if (_value2 == 0.0) {
                            info2 = 'I\'d rather not answer';
                          }
                          if (_value2 == 1.0) {
                            info2 = 'Never';
                          }
                          if (_value2 == 2.0) {
                            info2 = 'Rarely';
                          }
                          if (_value2 == 3.0) {
                            info2 = 'Seldom';
                          }
                          if (_value2 == 4.0) {
                            info2 = 'Occasionally';
                          }
                          if (_value2 == 5.0) {
                            info2 = 'Sometimes';
                          }
                          if (_value2 == 6.0) {
                            info2 = 'Frequently';
                          }
                          if (_value2 == 7.0) {
                            info2 = 'Normally';
                          }
                          if (_value2 == 8.0) {
                            info2 = 'Usually';
                          }
                          if (_value2 == 9.0) {
                            info2 = 'Always';
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 2.0,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text(
                      'How well did you sleep last night?',
                      style: TextStyle(
                          letterSpacing: 0.1,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 5.0,
                    ),
                    child: Slider(
                      //Properties
                      min: 0.0,
                      max: 6.0,
                      divisions: 6,
                      activeColor: Colors.teal,
                      inactiveColor: Colors.grey,
                      label: info,
                      value: _value,
                      //Functions
                      onChanged: (newValue) {
                        setState(() {
                          _value = newValue;
                          if (_value == 0.0) {
                            info = 'I\'d rather not answer';
                          }
                          if (_value == 1.0) {
                            info = 'Worst';
                          }
                          if (_value == 2.0) {
                            info = 'Worse';
                          }
                          if (_value == 3.0) {
                            info = 'Bad';
                          }
                          if (_value == 4.0) {
                            info = 'Good';
                          }
                          if (_value == 5.0) {
                            info = 'Better';
                          }
                          if (_value == 6.0) {
                            info = 'Best';
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 2.0,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text(
                      'How often do you consume healthy diet?',
                      style: TextStyle(
                          letterSpacing: 0.1,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 5.0,
                    ),
                    child: Slider(
                      //Properties
                      min: 0.0,
                      max: 9.0,
                      divisions: 9,
                      activeColor: Colors.teal,
                      inactiveColor: Colors.grey,
                      label: info3,
                      value: _value3,
                      //Functions
                      onChanged: (newValue) {
                        setState(() {
                          _value3 = newValue;
                          if (_value3 == 0.0) {
                            info3 = 'I\'d rather not answer';
                          }
                          if (_value3 == 1.0) {
                            info3 = 'Never';
                          }
                          if (_value3 == 2.0) {
                            info3 = 'Rarely';
                          }
                          if (_value3 == 3.0) {
                            info3 = 'Seldom';
                          }
                          if (_value3 == 4.0) {
                            info3 = 'Occasionally';
                          }
                          if (_value3 == 5.0) {
                            info3 = 'Sometimes';
                          }
                          if (_value3 == 6.0) {
                            info3 = 'Frequently';
                          }
                          if (_value3 == 7.0) {
                            info3 = 'Normally';
                          }
                          if (_value3 == 8.0) {
                            info3 = 'Usually';
                          }
                          if (_value3 == 9.0) {
                            info3 = 'Always';
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/page3');
              },
              child: Text('Proceed'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 10),
                primary: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print('This will redirect to home');
              },
              child: Text('Discard'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 10),
                primary: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
