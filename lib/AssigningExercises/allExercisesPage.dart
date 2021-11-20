import 'package:chat_app/AssigningExercises/BreathingExercise/exercisePage.dart';
import 'package:chat_app/AssigningExercises/BreathingExercise/models.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/checkboxExercisesHomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllExercises extends StatefulWidget {

  @override
  _AllExercisesState createState() => _AllExercisesState();
}

class _AllExercisesState extends State<AllExercises> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("All Exercises"),
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
              onTap: () async {
                var prefs = await SharedPreferences.getInstance();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TimerApp(settings: CustomSettings(prefs), prefs: prefs,)));
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
                      'Breathing Exercise',
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
                      builder: (context) => CheckboxExercisesHomePage(),
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
                      'Question Exercise',
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
