import 'package:chat_app/MentalHealthTest/Screen/question_screen.dart';
import 'package:chat_app/MentalHealthTest/models/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/MentalHealthTest/models/question.dart';

class FirstTime extends StatefulWidget {

  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  @override
  void initState() {
    super.initState();
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
                Text('Get to know yourself better',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  child: Image(
                    image: AssetImage('lib/assets/images/logo.jpeg'),
                    width: size.width / 1.5,
                  ),
                  height: size.height / 1.5,
                ),
                // StreamBuilder<QuerySnapshot>(
                //   stream: FirebaseFirestore.instance
                //     .collection('questions')
                //     .snapshots(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       return Center(child: CircularProgressIndicator(),
                //       );
                //     }
                //
                //     final questionDocs = snapshot.data.docs;
                //
                //     final questions = questionDocs.map((e) => Question.fromQueryDocumentSnapshot(e)).toList();
                //
                //     return SizedBox(
                //       height: 50,
                //       width: 350,
                //       child: ElevatedButton(
                //         onPressed: () {
                //           Navigator.push(
                //             context, MaterialPageRoute(builder: (_) => QuestionScreen(
                //             questions: questions,
                //           ),
                //           ),
                //           );
                //         },
                //         child: Text('Next',
                //           style: TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         style: ElevatedButton.styleFrom(
                //           primary: Colors.teal.shade400,
                //         ),
                //       ),
                //     );
                //   },
                // ),
              SizedBox(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    // await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).update({
                    //   "records": [
                    //     {
                    //       "questions": [
                    //         "test"
                    //       ]
                    //     }
                    //   ]
                    //
                    // });
                    // Question().getJustQuestions(allQuestion: allQuestion);
                    // Question().uploadToFirebase();
                    Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => QuestionScreen(
                      questions: allQuestion,
                    ),
                    ),
                    );
                  },
                  child: Text('Next',
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
        ),
      ),
    );
  }
}
