import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class page_three extends StatelessWidget {

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
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Image.asset('assets/q6.gif'),
              backgroundColor: Colors.transparent,
              radius: 50.0,
            ),
            Text(
              'Great Job!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            SizedBox(
              width: 280,
              child: Text(
                'What time would you like to be reminded to check in on your day everyday?',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text('This here will display time.'),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            ElevatedButton(
              onPressed: () {
                print('This will submit the logic');
              },
              child: Text('Submit'),
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
