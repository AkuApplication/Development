import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateMentalHealthTestPage extends StatefulWidget {
  @override
  _CreateMentalHealthTestPageState createState() => _CreateMentalHealthTestPageState();
}

class _CreateMentalHealthTestPageState extends State<CreateMentalHealthTestPage> {
  List<Widget> listOfTextFormFields = [];
  List<Widget> listOfCheckBoxAnswers = [];
  List<String> listOfAnswer = [];
  List<String> listOfQuestion = [];
  TextEditingController title = TextEditingController();
  String step = "";
  String detail = "";
  bool noInput = true;
  final _formKey = GlobalKey<FormState>();
  int count = 0;
  AutovalidateMode autoValidateModeOnUserInteraction = AutovalidateMode.onUserInteraction;
  AutovalidateMode autoValidateModeDisabled = AutovalidateMode.disabled;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
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
        title: Text("Setup Exercises"),
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
                        // print(listOfText);
                        if(_formKey.currentState.validate()){
                          _formKey.currentState.save();

                          await _firestore.collection("setupMentalHealthTest").add({
                            "id": FieldValue.increment(1),
                            "listOfQuestion": listOfQuestion,
                            "listOfAnswer": listOfAnswer,
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
                setState(() {
                  int num = count;
                  listOfTextFormFields.add(
                    ExpansionTile(
                      maintainState: true,
                      key: Key("id_$num"),
                      leading: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          setState(() {
                            listOfTextFormFields.removeWhere((element) => element.key == Key("id_$num"),);
                            listOfQuestion.clear();
                            listOfAnswer.clear();
                          });
                        },
                      ),
                      initiallyExpanded: true,
                      title: Padding(
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
                              step = value;
                            });
                          },
                          autovalidateMode: step.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
                          validator: (value) {
                            if(value.isEmpty){
                              return "Required. Can't be empty";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      children: [
                        ElevatedButton(
                          child: Text("Click for more checkboxes-like answer"),
                          onPressed: () {
                            listOfCheckBoxAnswers.add(
                              Row(
                                key: Key("id_$num"),
                                children: [
                                  IconButton(),
                                  CheckboxListTile(
                                    value: false,
                                    onChanged: (value) {

                                    },
                                    title: TextFormField(),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: TextFormField(
                        //     decoration: decoText.copyWith(
                        //       labelText: "Detailed Instructions for the Step Above",
                        //     ),
                        //     onSaved: (newValue) {
                        //       setState(() {
                        //         listOfAnswer.add(newValue);
                        //       });
                        //     },
                        //     autovalidateMode: step.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
                        //     onChanged: (value) {
                        //       detail = value;
                        //     },
                        //     maxLines: null,
                        //   ),
                        // ),
                      ],
                    ),
                  );
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