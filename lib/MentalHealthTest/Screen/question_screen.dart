import 'package:chat_app/MentalHealthTest/Screen/complete_screen.dart';
import 'package:chat_app/MentalHealthTest/components/Box.dart';
import 'package:chat_app/MentalHealthTest/models/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  // const QuestionScreen({Key key,
  //   @required this.questions,
  // }) : super(key: key);
  QuestionScreen({this.questions});

  List<Question> questions;

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentIndex = 0;
  // int _value = -1;
  // String _selectedOption = '';
  List<String> answers = [];
  List<String> justQuestions = [];
  List<Map> listOfRecords = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
  final currentQuestion = widget.questions[_currentIndex];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Box(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('QUESTION ' + currentQuestion.id, style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      currentQuestion.question,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Flexible(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final option = currentQuestion.options[index];
                         // return Row(
                           // children: <Widget>[
                           //  Radio(value: 1,
                           //    groupValue: _value,
                           //    onChanged: (value){
                           //    _value = value;
                           //    setState(() {});
                           //    },
                           //  ),
                           // Text(option),
                           // SizedBox(width: 10.0,),
                            // Text(option)
                          // ],);
                        return Card(
                          child: ListTile(
                            onTap: () async {
                              setState(() {
                                answers.insert(_currentIndex, option);
                                print(answers);
                                // _selectedOption = option;
                                if(_currentIndex < 9){
                                  _currentIndex++;
                                }
                                justQuestions.add(currentQuestion.question);
                              });

                              Future.delayed(Duration(milliseconds: 200), () {
                                if (answers.length == 10) {
                                  // print(answers);
                                  Map<String, dynamic> record = {
                                    "questions": justQuestions,
                                    "answers": answers
                                  };

                                  // answers.t
                                  // });

                                  // Question().uploadToFirebase(record);
                                  // print(justQuestions);
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (_) => CompleteScreen()));
                                }
                              });
                            },
                            title: Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                            ),
                            ),
                          ),
                        );
                      },
                        itemCount: currentQuestion.options.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

