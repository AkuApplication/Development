import 'package:flutter/material.dart';

class page_one extends StatefulWidget {

  @override
  State<page_one> createState() => _page_oneState();
}

class _page_oneState extends State<page_one> {

  // So that after restart, no option is selected in prior.
  int _value = 7;

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
        child: Column(
          children: [
            CircleAvatar(
              child: Image.asset('assets/q3.gif'),
              backgroundColor: Colors.transparent,
              radius: 50.0,
            ),
            Text(
              'How are you feeling today?',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              title: Text(
                'joyful, happy, relaxed, silly, content, great',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              leading: Radio(
                value: 1,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = 1;
                  });
                },
                activeColor: Colors.teal,
              ),
            ),
            ListTile(
              title: Text('productive, active, energetic, motivated', style: TextStyle(
                color: Colors.orange,
              ),),
              leading: Radio(
                value: 2,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = 2;
                  });
                },
                activeColor: Colors.teal,
              ),
            ),
            ListTile(
              title: Text('average, normal, uneventful, good', style: TextStyle(
                color: Colors.amber,
              ),),
              leading: Radio(
                value: 3,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = 3;
                  });
                },
                activeColor: Colors.teal,
              ),
            ),
            ListTile(
              title: Text('sick, tired, lazy, dull, unmotivated, bored', style: TextStyle(
                color: Colors.green,
              ),),
              leading: Radio(
                value: 4,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = 4;
                  });
                },
                activeColor: Colors.teal,
              ),
            ),
            ListTile(
              title: Text('sad, lonely, numb, depressed, insecure', style: TextStyle(
                color: Colors.blue,
              ),),
              leading: Radio(
                value: 5,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = 5;
                  });
                },
                activeColor: Colors.teal,
              ),
            ),
            ListTile(
              title: Text('angry, frustrated, anxious, grumpy', style: TextStyle(
                color: Colors.purple,
              ),),
              leading: Radio(
                value: 6,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = 6;
                  });
                },
                activeColor: Colors.teal,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/page2');
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
