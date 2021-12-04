import 'package:chat_app/AssigningExercises/BreathingExercise/exercisePage.dart';
import 'package:chat_app/AssigningExercises/BreathingExercise/models.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/checkboxExercisesHomePage.dart';
import 'package:chat_app/MentalHealthTest/SetupPage/createMentalHealthTestPage.dart';
import 'package:chat_app/MentalHealthTest/SetupPage/editMentalHealthTestPage.dart';
import 'package:chat_app/SetupExercises/createExercisesPage.dart';
import 'package:chat_app/SetupExercises/editExercisesPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupMentalHealthTestPage extends StatefulWidget {

  @override
  _SetupMentalHealthTestPageState createState() => _SetupMentalHealthTestPageState();
}

class _SetupMentalHealthTestPageState extends State<SetupMentalHealthTestPage> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Mental Health Test Setup"),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          primary: false,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: size.aspectRatio / 0.5,
          physics: NeverScrollableScrollPhysics(),
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateMentalHealthTestPage(),));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.purple.shade100,
                elevation: 10.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.network(
                    //   'https://image.flaticon.com/icons/png/512/2928/2928158.png',
                    //   height: size.height / 10,
                    // ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'Create Mental Health Test',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditMentalHealthTest(),
                    )
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.orange.shade100,
                elevation: 10.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.network(
                    //   'https://image.flaticon.com/icons/png/512/4245/4245351.png',
                    //   height: size.height / 10,
                    // ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'Edit Mental Health Test',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
