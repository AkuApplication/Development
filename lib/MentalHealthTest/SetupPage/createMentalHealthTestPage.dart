import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateMentalHealthTestPage extends StatefulWidget {

  @override
  _CreateMentalHealthTestPageState createState() => _CreateMentalHealthTestPageState();
}

class _CreateMentalHealthTestPageState extends State<CreateMentalHealthTestPage> {
  List<Widget> listOfTextFormFields;
  List<Widget> listOfWidgetAnswers;
  List<Widget> listOfButtonWidgets;

  List<String> listOfAnswer;
  List<String> listOfQuestion;
  List<String> listOfScore;
  List<List> listOfListAnswer = [];
  List<List> listOfListScore = [];
  List<List> listOfListQuestion = [];

  List<String> listOfDialog = [];
  List<String> backupListOfDialog = [];
  String dialog = "";

  String question = "";
  String answer = "";
  final _formKey = GlobalKey<FormState>();
  int count = 0;
  int k = 0;
  List<DropdownMenuItem<String>> scoreList;
  List<List> listOfScoreList = [];
  AutovalidateMode autoValidateModeOnUserInteraction = AutovalidateMode.onUserInteraction;
  AutovalidateMode autoValidateModeDisabled = AutovalidateMode.disabled;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<List> listOfWidgets = [];
  List<List> listOfFormFieldWidgets = [];
  List<List> listOfButtons = [];
  List<TextEditingController> listOfQuestionController = [];
  List<TextEditingController> listOfAnswerController = [];
  List<String> fromFirestoreScoreList = [];
  TextEditingController questionController;
  TextEditingController answerController;
  String score ;
  List<Map<String,dynamic>> listOfMap = [];
  Map<String, dynamic> mapped;
  Size size;
  int p = 0;

  @override
  void initState() {
    getFromFirestore();
    super.initState();
  }

  void getFromFirestore() async {
    await _firestore.collection("setupMentalHealthTest").doc("onlyOne").get().then((value) {
      List list = value.data()["mapped"];
      list.forEach((element) {
        questionController = TextEditingController();
        listOfQuestionController.add(questionController);
        List secondList = element["question"];
        secondList.forEach((element) {
          listOfQuestionController[p].text = element;
          print(listOfQuestionController[p].text);
          p++;
        });
        List thirdList = element["listOfAnswer"];
      });

      // print(listOfQuestionController.length);
      //
      // List test;
      // list.forEach((element) {
      //   test = element["question"];
      // });
      // print(list.toString());
      // print(test);
      // Map<String, dynamic>
      // // List<dynamic> listed = [];
      // // value.data().forEach((key, value) {
      // //   print(value.toString()
      // // });
      // print(fromFirestore.toString());
      // print(questionController.text);
      // setState(() {
      //   questionController.text = fromFirestore["question"];
      // });
    });
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Mental Health Test"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listOfFormFieldWidgets.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Column(
                                children: listOfFormFieldWidgets[index]
                            ),
                            Column(
                                children: listOfWidgets[index]
                            ),
                            Column(
                              children: listOfButtons[index],
                            ),
                          ],
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text("Update Mental Health Test"),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          // listOfListQuestion.clear();
                          // listOfListAnswer.clear();
                          // listOfListScore.clear();
                          if(listOfMap.length == 0){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("No data has been inputted yet"),
                              ),
                            );
                          } else {
                            _formKey.currentState.save();

                            // listOfQuestion.map((e) {
                            //   "e": e,
                            // });
                            await _firestore.collection(
                                "setupMentalHealthTest").doc("onlyOne").set({
                              "mapped": listOfMap,
                            }).then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "You have updated the Mental Health Test"),
                                ),
                              );
                            });
                          }

                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please fill in the required fields"),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  int a = 0;
                  int num = count;
                  listOfQuestion = [];
                  listOfListQuestion.add(listOfQuestion);
                  listOfTextFormFields = [];
                  listOfFormFieldWidgets.add(listOfTextFormFields);
                  listOfWidgetAnswers = [];
                  listOfWidgets.add(listOfWidgetAnswers);
                  listOfFormFieldWidgets[num].add(
                    Column(
                      key: Key("id_$num"),
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                setState(() {
                                  listOfFormFieldWidgets[num].removeWhere((element) => element.key == Key("id_$num"));
                                  listOfWidgets[num].clear();
                                  listOfButtons[num].removeWhere((element) => element.key == Key("id_$num"));
                                  listOfListQuestion[num].clear();
                                  listOfListAnswer[num].clear();
                                  listOfListScore[num].clear();
                                  listOfMap.clear();
                                });
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: decoText.copyWith(
                                    labelText: "Question",
                                  ),
                                  onSaved: (newValue) {
                                    setState(() {
                                      listOfListQuestion[num].add(newValue);
                                      // listOfMap[num].update("question", (value){
                                      //   setState(() {
                                      //     value = newValue;
                                      //   });
                                      // });
                                    });
                                  },
                                  controller: questionController,
                                  onChanged: (value) {
                                    setState(() {
                                      question = value;
                                    });
                                  },
                                  autovalidateMode: question.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
                                  validator: (value) {
                                    if(value.isEmpty){
                                      return "Required. Can't be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                  listOfAnswer = [];
                  listOfListAnswer.add(listOfAnswer);
                  listOfScore = [];
                  listOfListScore.add(listOfScore);
                  listOfButtonWidgets = [];
                  listOfButtons.add(listOfButtonWidgets);
                  scoreList = [];
                  listOfScoreList.add(scoreList);
                  listOfButtons[num].add(
                    ElevatedButton(
                      key: Key("id_$num"),
                      child: Text("Add Answers"),
                      onPressed: () {
                        setState(() {
                          int j = k;
                          listOfScoreList[num].add(DropdownMenuItem(child: Text("$a"), value: "$a",));
                          listOfWidgets[num].add(
                            Row(
                              key: Key("id_$j"),
                              children: [
                                Container(
                                  width: size.width / 1.75,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      decoration: decoText.copyWith(
                                        labelText: "Answer",
                                      ),
                                      onSaved: (newValue) {
                                        setState(() {
                                          listOfListAnswer[num].add(newValue);
                                          // listOfMap[num].update("listOfAnswer", (value){
                                          //   setState(() {
                                          //     value = newValue;
                                          //   });
                                          // });
                                        });
                                      },
                                      // controller: answerController,
                                      onChanged: (value) {
                                        setState(() {
                                          answer = value;
                                        });
                                      },
                                      autovalidateMode: answer.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
                                      validator: (value) {
                                        if(value.isEmpty){
                                          return "Required. Can't be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width: size.width / 4,
                                  child: DropdownButtonFormField(
                                    decoration: decoText.copyWith(
                                        labelText: "Score",
                                    ),
                                    // value: score,
                                    items: listOfScoreList[num],
                                    onChanged: (value) {
                                      setState(() {
                                        score = value;
                                      });
                                    },
                                    onSaved: (newValue) {
                                      setState(() {
                                        listOfListScore[num].add(newValue);
                                        // listOfMap[num].update("listOfScore", (value){
                                        //   setState(() {
                                        //     value = newValue;
                                        //   });
                                        // });
                                      });
                                    },
                                    validator: (value) {
                                      if(value == null){
                                        return "Required";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    setState(() {
                                      listOfWidgets[num].removeWhere((element) => element.key == Key("id_$j"));
                                      // scoreList.removeWhere((element) => element.key == Key("id_$j"));
                                      listOfScoreList[num].removeLast();
                                      a--;
                                      // listOfQuestion.clear();
                                      // listOfAnswer.clear();
                                      // listOfScore.clear();
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                        a++;
                        k++;
                      },
                    ),
                  );
                  mapped = {
                    "question": listOfListQuestion[num],
                    "listOfAnswer": listOfListAnswer[num],
                    "listOfScore": listOfListScore[num],
                  };
                  listOfMap.add(mapped);
                  count++;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}