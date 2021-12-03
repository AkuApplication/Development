import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateExercisesPage extends StatefulWidget {
  @override
  _CreateExercisesPageState createState() => _CreateExercisesPageState();
}

class _CreateExercisesPageState extends State<CreateExercisesPage> {
  List<Widget> listOfTextFormFields = [];
  List<String> listOfDetails = [];
  List<String> listOfString = [];
  String title = "";
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
                    TextFormField(
                      decoration: decoText.copyWith(
                        labelText: "For What This Exercise Is? e.g For Anxiety",
                      ),
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                      autovalidateMode: title.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Required. Can't be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: listOfTextFormFields,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      child: Text("Create Exercise"),
                      onPressed: noInput ? null : () async {
                        // print(listOfText);
                        if(_formKey.currentState.validate()){
                          _formKey.currentState.save();

                          await _firestore.collection("setupExercises").add({
                            "title": title,
                            "listOfSteps": listOfString,
                            "listOfDetails": listOfDetails,
                          }).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("You have added an Exercise"),
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
                            listOfString.clear();
                            listOfDetails.clear();
                          });
                        },
                      ),
                      initiallyExpanded: true,
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: decoText.copyWith(
                            labelText: "Name for the Step",
                          ),
                          onSaved: (newValue) {
                            setState(() {
                              listOfString.add(newValue);
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: decoText.copyWith(
                              labelText: "Detailed Instructions for the Step Above",
                            ),
                            onSaved: (newValue) {
                              setState(() {
                                listOfDetails.add(newValue);
                              });
                            },
                            autovalidateMode: step.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
                            onChanged: (value) {
                              detail = value;
                            },
                            maxLines: null,
                          ),
                        ),
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