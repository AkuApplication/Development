import 'package:chat_app/AssigningExercises/BreathingExercise/exercisePage.dart';
import 'package:chat_app/AssigningExercises/BreathingExercise/models.dart';
import 'package:chat_app/AssigningExercises/CheckboxExercises/checkboxExercisesHomePage.dart';
import 'package:chat_app/SetupExercises/createExercisesPage.dart';
import 'package:chat_app/SetupExercises/editExercisesPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupExercisesPage extends StatefulWidget {

  @override
  _SetupExercisesPageState createState() => _SetupExercisesPageState();
}

class _SetupExercisesPageState extends State<SetupExercisesPage> {

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
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateExercisesPage(),));
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
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/929/929256.png',
                      height: size.height / 10,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'Create Exercises',
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
                      builder: (context) => EditExercises(),
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
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/1827/1827175.png',
                      height: size.height / 10,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'Edit Exercises',
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
