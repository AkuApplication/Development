import 'package:chat_app/Screens/homepage.dart';
import 'package:flutter/material.dart';

class CompleteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You are all done!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              SizedBox(
                child: Image(
                  image: AssetImage('lib/assets/images/logo.jpeg'),
                  width: 250,
                ),
                height: 450,
              ),
              SizedBox(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text('Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal.shade400,
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
