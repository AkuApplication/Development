import 'package:chat_app/MoodTracker/page_1.dart';
import 'package:chat_app/Screens/patientHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class page_three extends StatefulWidget {

  @override
  State<page_three> createState() => _page_threeState();
}

class _page_threeState extends State<page_three> {
  // The data fetched will be put inside these new variables
  int a = 0;
  int b = 0;
  int c = 0;
  int d = 0;
  String i = "";
  String j = "";
  String k = "";
  String l = "";

  // Instances // 3 different instances cuz I have 3 different documents
  final userRef1 = FirebaseFirestore.instance.collection('score');
  final userRef2 = FirebaseFirestore.instance.collection('score');
  final userRef3 = FirebaseFirestore.instance.collection('score');

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    await userRef1.doc('Document 1').get().then((value) => setState(() {
          a = value.data()['Mark1'];
        }));
    await userRef2.doc('Document 2').get().then((value) => setState(() {
          b = value.data()['Mark2'];
          c = value.data()['Mark3'];
          d = value.data()['Mark4'];
        }));
    await userRef3.doc('Document 3').get().then((value) => setState(() {
          i = value.data()['Comment1'];
          j = value.data()['Comment2'];
          k = value.data()['Comment3'];
          l = value.data()['Comment4'];
        }));
  }

  @override
  Widget build(BuildContext context) {
    //Calculation, Comment & Condition logic
    int score = a + b + c + d;
    String comment = "";

    if (score >= 48 && score <= 66) {
      comment = l; // For best condition
    }
    if ((score >= 41 && score <= 47) || (score >= 21 && score <= 27)) {
      comment = j; // For in-between condition; improving or regressing
    }
    if (score >= 28 && score <= 40) {
      comment = k; // For average condition
    }
    if (score >= 8 && score <= 20) {
      comment = i; //For bad condition
    }

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
              child: Image.asset('lib/assets/images/q6.gif'),
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
              height: 15.0,
            ),
            SizedBox(
              width: 280,
              child: Text(
                'Here are your feedbacks. Please be mindful that the following feedbacks only served as a guide, not actual diagnosis.',
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
              height: 15.0,
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Score: ' + score.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Feedback: ' + comment.toString(),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            ElevatedButton(
              onPressed: () {
                // This will let patient to take the test again
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page_one(),));
              },
              child: Text('Try Again'),
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
                Navigator.pop(context);
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
