import 'package:chat_app/MentalHealthTest/Screen/first_time.dart';
import 'package:chat_app/Screens/patientHomePage.dart';
import 'package:flutter/material.dart';

//The 3rd page of MentalHealthTest after finished answering all questions
class CompleteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox.fromSize(
            size: size,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => FirstTime()));
                          },
                          child: Text('Try Again?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal.shade400,
                          ),
                        ),
                        SizedBox(width: 50,),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
