import 'package:chat_app/SetupExercises/editExerciseCard.dart';
import 'package:chat_app/SetupExercises/editExerciseModel.dart';
import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditExercises extends StatefulWidget {

  @override
  _EditExercisesState createState() => _EditExercisesState();
}

class _EditExercisesState extends State<EditExercises> {

  List listOfFormKey = [];
  // final _formKey = GlobalKey<FormState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TextEditingController> listOfTitleEditingController = [];
  List<TextEditingController> listOfStepsEditingController = [];
  List<TextEditingController> listOfDetailsEditingController = [];
  AutovalidateMode autoValidateModeOnUserInteraction = AutovalidateMode.onUserInteraction;
  AutovalidateMode autoValidateModeDisabled = AutovalidateMode.disabled;
  List listsDoc = [];
  List<List> listForListOfSteps = [];
  List<List> listForListOfDetails = [];
  int count = 0;
  List<TextEditingController> list = [];

  // void getListsFromFirestore() async {
  //   await _firestore.collection("setupExercises").get().then((value) {
  //     setState(() {
  //       listsDoc = value.docs;
  //     });
  //
  //
  //     for(int i = 0; i < listsDoc.length; i++){
  //       setState(() {
  //         listOfTitleEditingController.add(TextEditingController(text: listsDoc[i]["title"]));
  //       });
  //
  //     }
  //
  //     for(int i = 0; i < listsDoc.length; i++){
  //       setState(() {
  //         listForListOfSteps.add(listsDoc[i]["listOfSteps"]);
  //       });
  //     }
  //
  //     for(int i = 0; i < listsDoc.length; i++){
  //       for(int j = 0; j < listForListOfSteps[i].length; j++){
  //         setState(() {
  //           listOfStepsEditingController.add(TextEditingController(text: listsDoc[i]["listOfSteps"][j]));
  //         });
  //       }
  //     }
  //
  //     // for(int i = 0; i < listForListOfSteps.length; i++){
  //     //   setState(() {
  //     //     listOfStepsEditingController.add(TextEditingController(text: listForListOfSteps[i]));
  //     //   });
  //     // }
  //
  //     // for(int i = 0; i < listForListOfSteps[i].length; i++){
  //     //   for(int j = 0; j < i; j++){
  //     //     setState(() {
  //     //       listOfStepsEditingController.add(TextEditingController(text: listForListOfSteps[i][j]));
  //     //     });
  //     //   }
  //     // }
  //     // print(listOfStepsEditingController.toString());
  //
  //     for(int i = 0; i < listsDoc.length; i++){
  //       setState(() {
  //         listForListOfDetails.add(listsDoc[i]["listOfDetails"]);
  //       });
  //       // for(int j = 0; j < listForListOfDetails[i].length; j++){
  //       //   setState(() {
  //       //     listOfDetailsEditingController.add(TextEditingController(text: listForListOfDetails[i][j]));
  //       //   });
  //       // }
  //     }
  //   });
  // }
  //
  // @override
  // void initState() {
  //   getListsFromFirestore();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Exercises"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _firestore.collection("setupExercises").snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final records = snapshot.data.docs;
              // print(records.length);
              List<Widget> listOfWidget = [];

              List<EditExerciseCard> recordCards = [];
              for(var record in records) {
                EditExerciseRecord recordObject = EditExerciseRecord(
                    steps: record["listOfSteps"],
                    details: record["listOfDetails"],
                    title: record["title"],
                    docId: record.id,
                );

                recordCards.add(EditExerciseCard(
                  record: recordObject,
                ));
              }
              //   list.add(TextEditingController(text: record["title"]));
              //   listForListOfSteps.add(record["listOfSteps"]);
              //   listForListOfDetails.add(record["listOfDetails"]);
              //   listOfStepsEditingController.add(TextEditingController());
              //   listOfDetailsEditingController.add(TextEditingController());
              //   // for(int i = 0; i < record["listOfSteps"].length; i++){
              //   //   listOfStepsEditingController.add(TextEditingController(text: record["listOfSteps"][i]));
              //   //   listOfDetailsEditingController.add(TextEditingController(text: record["listOfDetails"][i]));
              //   //   listOfStepsEditingController.forEach((element) {
              //   //     element.dispose();
              //   //   });
              //   //   listOfDetailsEditingController.forEach((element) {
              //   //     element.dispose();
              //   //   });
              //   // }
              //   for(int i = 0; i < record["listOfSteps"].length; i++){
              //     listOfStepsEditingController[i].text = record["listOfSteps"][i];
              //   }
              // }
              //
              // for(int i= 0; i < records.length; i ++){
              //   var record = records[i].data;
              //   listOfFormKey.add(Key("formKey_${i}"));
              //   listOfWidget.add(Form(
              //     key: listOfFormKey[i],
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: ExpansionTile(
              //         maintainState: true,
              //         // initiallyExpanded: true,
              //         title: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: TextFormField(
              //             decoration: decoText.copyWith(
              //               labelText: "Title of Exercise",
              //             ),
              //             // onSaved: (newValue) {
              //             //   setState(() {
              //             //     listOfTitleEditingController[index].text = newValue;
              //             //   });
              //             // },
              //             controller: list[i],
              //             // onChanged: (value) {
              //             //   setState(() {
              //             //     listOfTitleEditingController[index].text = value;
              //             //   });
              //             // },
              //             autovalidateMode: list[i].text.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
              //             validator: (value) {
              //               if(value.isEmpty){
              //                 return "Required. Can't be empty";
              //               } else {
              //                 return null;
              //               }
              //             },
              //           ),
              //         ),
              //         children: [
              //           ListView.builder(
              //             shrinkWrap: true,
              //             physics: NeverScrollableScrollPhysics(),
              //             itemCount: listForListOfSteps[i].length,
              //             itemBuilder: (context, index) {
              //               return  Column(
              //                 children: [
              //                   Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: TextFormField(
              //                       decoration: decoText.copyWith(
              //                         labelText: "Name for the Step",
              //                       ),
              //                       // onSaved: (newValue) {
              //                       //   setState(() {
              //                       //     listOfStepsEditingController[index].text = newValue;
              //                       //   });
              //                       // },
              //                       controller: listOfStepsEditingController[index],
              //                       // onChanged: (value) {
              //                       //   setState(() {
              //                       //     listOfStepsEditingController[index].text = value;
              //                       //   });
              //                       // },
              //                       // autovalidateMode: listOfStepsEditingController[index].text.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
              //                       validator: (value) {
              //                         if(value.isEmpty){
              //                           return "Required. Can't be empty";
              //                         } else {
              //                           return null;
              //                         }
              //                       },
              //                     ),
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: TextFormField(
              //                       decoration: decoText.copyWith(
              //                         labelText: "Detailed Instructions for the Step Above",
              //                       ),
              //                       controller: listOfDetailsEditingController[index],
              //                       // onSaved: (newValue) {
              //                       //   setState(() {
              //                       //     listOfDetailsEditingController[index].text = newValue;
              //                       //   });
              //                       // },
              //                       maxLines: null,
              //                     ),
              //                   ),
              //                 ],
              //               );
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),);
              //   count++;
              //   // listOfStepsEditingController.forEach((element) {
              //   //   element.clear();
              //   // });
              //   // listOfDetailsEditingController.forEach((element) {
              //   //   element.clear();
              //   // });
              // }
              return Column(
                children: recordCards,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      // body: SingleChildScrollView(
      //   child: ListView.builder(
      //     shrinkWrap: true,
      //     physics: NeverScrollableScrollPhysics(),
      //     itemCount: listsDoc.length,
      //     itemBuilder: (context, index) {
      //       // listOfTextEditingController.add(TextEditingController());
      //       listOfFormKey.add(Key("formKey_$index"));
      //     return Form(
      //       key: listOfFormKey[index],
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ExpansionTile(
      //           maintainState: true,
      //           // initiallyExpanded: true,
      //           title: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: TextFormField(
      //               decoration: decoText.copyWith(
      //                 labelText: "Title of Exercise",
      //               ),
      //               onSaved: (newValue) {
      //                 setState(() {
      //                   listOfTitleEditingController[index].text = newValue;
      //                 });
      //               },
      //               controller: listOfTitleEditingController[index],
      //               // onChanged: (value) {
      //               //   setState(() {
      //               //     listOfTitleEditingController[index].text = value;
      //               //   });
      //               // },
      //               autovalidateMode: listOfTitleEditingController[index].text.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
      //               validator: (value) {
      //                 if(value.isEmpty){
      //                   return "Required. Can't be empty";
      //                 } else {
      //                   return null;
      //                 }
      //               },
      //             ),
      //           ),
      //           children: [
      //             ListView.builder(
      //               shrinkWrap: true,
      //               physics: NeverScrollableScrollPhysics(),
      //               itemCount: listForListOfSteps[index].length,
      //               itemBuilder: (context, index) {
      //                 return  Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: TextFormField(
      //                     decoration: decoText.copyWith(
      //                       labelText: "Name for the Step",
      //                     ),
      //                     onSaved: (newValue) {
      //                       setState(() {
      //                         listOfStepsEditingController[index].text = newValue;
      //                       });
      //                     },
      //                     controller: listOfStepsEditingController[index],
      //                     // onChanged: (value) {
      //                     //   setState(() {
      //                     //     listOfStepsEditingController[index].text = value;
      //                     //   });
      //                     // },
      //                     autovalidateMode: listOfStepsEditingController[index].text.isEmpty ? autoValidateModeDisabled : autoValidateModeOnUserInteraction,
      //                     validator: (value) {
      //                       if(value.isEmpty){
      //                         return "Required. Can't be empty";
      //                       } else {
      //                         return null;
      //                       }
      //                     },
      //                   ),
      //                 );
      //               },
      //             ),
      //             // ListView.builder(
      //             //   shrinkWrap: true,
      //             //   physics: NeverScrollableScrollPhysics(),
      //             //   itemCount: listForListOfDetails[index].length,
      //             //   itemBuilder: (context, index) {
      //             //     return Padding(
      //             //       padding: const EdgeInsets.all(8.0),
      //             //       child: TextFormField(
      //             //         decoration: decoText.copyWith(
      //             //           labelText: "Detailed Instructions for the Step Above",
      //             //         ),
      //             //         controller: listOfDetailsEditingController[index],
      //             //         onSaved: (newValue) {
      //             //           setState(() {
      //             //             listOfDetailsEditingController[index].text = newValue;
      //             //           });
      //             //         },
      //             //         maxLines: null,
      //             //       ),
      //             //     );
      //             //   },
      //             // ),
      //           ],
      //         ),
      //       ),
      //     );
      //     },
      //   ),
      // ),
    );
  }
}
