import 'package:chat_app/MentalHealthTest/Screen/first_time.dart';
import 'package:chat_app/Notifications/notificationsMethods.dart';
import 'package:chat_app/Screens/patientHomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//The 3rd page of MentalHealthTest after finished answering all questions
class CompleteScreen extends StatefulWidget {

  @override
  _CompleteScreenState createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {

  SharedPreferences sharedPreferences;

  //Getting SharedPreferences instance
  void getPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  //Variables for the notifications value
  bool firstReminder;
  bool secondReminder;

  void firstNotification() async {
    setState(() {
      firstReminder = sharedPreferences.getBool("firstReminder") ?? true;
    });
    if(firstReminder ==  true){
      await CustomNotification().showNotificationForTODOChecklist();
    } else {
      await CustomNotification().cancelNotificationForTODO();
    }
  }

  void secondNotification() async {
    setState(() {
      secondReminder = sharedPreferences.getBool("secondReminder") ?? true;
    });
    if(secondReminder ==  true){
      await CustomNotification().showNotificationDaily();
    } else {
      await CustomNotification().cancelNotificationForMoodTracker();
    }
  }

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
                            firstNotification();
                            secondNotification();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(sharedPreferences: sharedPreferences,)));
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
