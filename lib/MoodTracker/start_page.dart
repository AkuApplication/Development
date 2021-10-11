import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Check-in',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey),
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 210.0,
                child: Image.asset('assets/q2.png'),
              ),
              Text(
                'Hello there, have a few minutes to reflect on how you\'ve felt today?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/page1');
                },
                child: Text('Let\'s do it'),
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
                child: Text('Not Now'),
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
      ),
    );
  }
}
