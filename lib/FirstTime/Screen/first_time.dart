import 'package:chat_app/FirstTime/Screen/question_screen.dart';
import 'package:chat_app/FirstTime/models/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirstTime extends StatelessWidget {
  const FirstTime({Key key}) : super(key: key);

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
            Text('Get to know yourself better',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height: 50),
            SizedBox(
              child: Image(
                image: AssetImage('assets/images/logo.jpeg'),
                width: 250,
              ),
              height: 450,
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
                Navigator.push(
                  context, MaterialPageRoute(builder: (_) => QuestionScreen(
                  questions: question,
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
    );
  }
}