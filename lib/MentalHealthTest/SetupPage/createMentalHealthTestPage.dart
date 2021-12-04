import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateMentalHealthTestPage extends StatefulWidget {
  @override
  _CreateMentalHealthTestPageState createState() => _CreateMentalHealthTestPageState();
}

class _CreateMentalHealthTestPageState extends State<CreateMentalHealthTestPage> {
  List<Widget> listOfTextFormFields = [];
  List<Widget> listOfCheckBoxAnswers;
  List<List<Widget>> listOfList = [];
  List<String> listOfAnswer = [];
  List<String> listOfQuestion = [];
  List<String> listOfScore = [];
  List<String> listOfDialog = [];
  List<String> backupListOfDialog = [];
  String question = "";
  String answer = "";
  bool noInput = true;
  final _formKey = GlobalKey<FormState>();
  final _dialogKey = GlobalKey<FormState>();
  int count = 0;
  int a = 0;
  List<DropdownMenuItem<dynamic>> scoreList = [];
  AutovalidateMode autoValidateModeOnUserInteraction = AutovalidateMode.onUserInteraction;
  AutovalidateMode autoValidateModeDisabled = AutovalidateMode.disabled;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String dialog = "";
  String score = "";
  List listOfMaps;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(listOfTextFormFields.length == 0){
      setState(() {
        noInput = true;
      });
    } else {
      setState(() {
        noInput = false;
      });
    }

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
                    Column(
                      children: listOfTextFormFields,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      child: Text("Create Mental Health Test"),
                      onPressed: noInput ? null : () async {
                        if(_formKey.currentState.validate()){
                          listOfAnswer.clear();
                          listOfScore.clear();
                          listOfQuestion.clear();
                          // setState(() {
                          //   backupListOfDialog = listOfDialog;
                          // });
                          // listOfDialog.clear();
                          print(backupListOfDialog.length);

                          _formKey.currentState.save();

                          print(listOfDialog.length);
                          print(backupListOfDialog.length);

                          // Map<String, dynamic> mapped;
                          List<Map<String, dynamic>> listOfMapped = [];
                          List<Map<String, dynamic>> listOf2ndMapped = [];

                          // listOfQuestion.map((e) {
                          //   Map<String,dynamic> test = {
                          //     "question": e,
                          //   };
                          // });
                          Map<String, dynamic> mapped;

                          listOfQuestion.forEach((element1) {
                            int b = a;
                            for(int i = 0; i < backupListOfDialog[b].length; i++){
                              setState(() {
                                mapped = {
                                  "questions": null,
                                  "answers": listOfAnswer[i],
                                };
                              });
                              listOf2ndMapped.add(mapped);
                            }
                            // listOfAnswer.forEach((element2) {
                            //   setState(() {
                            //     mapped = {
                            //       "questions": null,
                            //       "answers": element2,
                            //     };
                            //   });
                            //   listOf2ndMapped.add(mapped);
                            // });
                            listOf2ndMapped.forEach((element) {
                              element.update("questions", (value) => element1);
                              listOfMapped.add(element);
                            });
                            a++;
                          });

                          listOfDialog.clear();
                          print(backupListOfDialog.length);
                          // listOfMapped.add(mapped);
                          // setState(() {
                          //   listOfMapped.add(mapped);
                          // });

                          await _firestore.collection("setupMentalHealthTest").add({
                            "id": FieldValue.increment(1),
                            "mappedQuestions": listOfMapped,
                            "listOfQuestion": listOfQuestion,
                            "listOfAnswer": listOfAnswer,
                            "listOfScore": listOfScore,
                            "lengthOfAnswers": dialog,
                          }).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("You have added a Mental Health Test"),
                              ),
                            );
                          });

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
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    content: Form(
                      key: _dialogKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: decoText.copyWith(
                            labelText: "Number Of Answers",
                          ),
                          onSaved: (newValue) {
                            setState(() {
                              listOfDialog.add(newValue);
                              backupListOfDialog.add(newValue);
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              dialog = value;
                            });
                          },
                          autovalidateMode: dialog.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
                          validator: (value) {
                            if(value.isEmpty){
                              return "Required. Can't be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          if(_dialogKey.currentState.validate()){
                            _dialogKey.currentState.save();
                            Navigator.pop(context);
                            setState(() {
                              int num = count;
                              listOfCheckBoxAnswers = [];
                              listOfList.add(listOfCheckBoxAnswers);
                              scoreList.clear();
                              listOfTextFormFields.add(
                                Column(
                                  key: Key("id_$num"),
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            setState(() {
                                              listOfTextFormFields.removeWhere((element) => element.key == Key("id_$num"),);
                                              listOfQuestion.clear();
                                              listOfAnswer.clear();
                                              listOfScore.clear();
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
                                                  listOfQuestion.add(newValue);
                                                });
                                              },
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
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: int.parse(dialog),
                                      itemBuilder: (context, index) {
                                        scoreList.add(DropdownMenuItem(child: Text("$index") ,value: "$index",));

                                        return Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  decoration: decoText.copyWith(
                                                    labelText: "Question's Answer",
                                                  ),
                                                  onSaved: (newValue) {
                                                    setState(() {
                                                      listOfAnswer.add(newValue);
                                                    });
                                                  },
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
                                              width: size.width / 3,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: DropdownButtonFormField(
                                                  decoration: decoText.copyWith(
                                                    labelText: "Score",
                                                  ),
                                                  // value: score,
                                                  items: scoreList,
                                                  onSaved: (newValue) {
                                                    if(newValue == null){
                                                      setState(() {
                                                        listOfScore.add("0");
                                                      });
                                                    } else {
                                                      setState(() {
                                                        listOfScore.add(newValue);
                                                      });
                                                    }
                                                  },
                                                  onChanged: (value) {
                                                    // setState(() {
                                                    //   score = value;
                                                    // });
                                                  },
                                                  // autovalidateMode: score.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
                                                  // validator: (value) {
                                                  //   return value[index] = "assign a score";
                                                  //   return "Assign a score";
                                                  // },
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                              count++;
                            });
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
                  );
                },);
              },
            ),
          ),
        ],
      ),
    );
  }
}