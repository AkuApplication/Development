import 'package:chat_app/MentalHealthTest/Screen/complete_screen.dart';
import 'package:chat_app/MentalHealthTest/components/Box.dart';
import 'package:chat_app/MentalHealthTest/models/question.dart';
import 'package:flutter/material.dart';

//The 2nd page of MentalHealthTest where the questions will be displayed
class QuestionScreen extends StatefulWidget {
  QuestionScreen({this.questions});

  List<Question> questions;

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  //Initializing variables
  String _condition;
  int _currentIndex = 0;
  int _conditionCount = 0;
  List<String> answers = [];
  List<String> justQuestions = [];
  List<Map> listOfRecords = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //Getting one question each to be displayed
    final currentQuestion = widget.questions[_currentIndex];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            child: Box(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'QUESTION ' + currentQuestion.id,
                      style: TextStyle(
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: currentQuestion.options.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final option = currentQuestion.options[index];
                          return Card(
                            child: ListTile(
                              onTap: () async {
                                setState(() {
                                  answers.insert(_currentIndex, option);
                                  _conditionCount = _conditionCount + currentQuestion.gradeScore[index];

                                  if(_currentIndex < 9){
                                    _currentIndex++;
                                  }

                                  justQuestions.add(currentQuestion.question);
                                });

                                Future.delayed(Duration(milliseconds: 200), () {
                                  if (answers.length == 10) {
                                    Map<String, dynamic> record = {
                                      "questions": justQuestions,
                                      "answers": answers
                                    };

                                    if(_conditionCount <= 2) {
                                      setState(() {
                                        _condition = "Severe";
                                      });
                                    } else if (_conditionCount <= 4){
                                      setState(() {
                                        _condition = "Bad";
                                      });
                                    } else if (_conditionCount <= 6){
                                      setState(() {
                                        _condition = "Normal";
                                      });
                                    } else if (_conditionCount <= 8){
                                      setState(() {
                                        _condition = "Good";
                                      });
                                    } else if (_conditionCount <= 10){
                                      setState(() {
                                        _condition = "Excellent";
                                      });
                                    }

                                    Question().uploadToFirebase(record, _condition);
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CompleteScreen(),));
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

