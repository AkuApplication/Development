import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:flutter/material.dart';

class SetupExercisesPage extends StatefulWidget {
  @override
  _SetupExercisesPageState createState() => _SetupExercisesPageState();
}

class _SetupExercisesPageState extends State<SetupExercisesPage> {
  List<Widget> listOfTextFormFields = [];
  List<Text> listOfText = [];
  List<TextEditingController> listOfController = [];
  List<String> listOfString = [];
  String title;
  bool noInput = true;
  final _formKey = GlobalKey<FormState>();
  int count = 0;

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {
                        print(listOfText);
                        print(listOfTextFormFields.length);
                        print(listOfText.length);

                        // listOfString.clear();
                        //
                        // for(int i = 0; i < listOfText.length; i++) {
                        //   setState(() {
                        //     String data = listOfText[i].data;
                        //     listOfString.add(data);
                        //   });
                        // }
                        //
                        // print(listOfString);
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
                  // listOfText.add(Text("", key: Key("id_$num"),));
                  int num = count;
                  // count++;
                  // listOfController.add(TextEditingController());
                  listOfText.add(Text("", key: Key("id_$num"),));
                  listOfTextFormFields.add(
                    Column(
                      key: Key("id_$num"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: decoText.copyWith(
                              labelText: "Name for the Step",
                            ),
                            // controller: listOfController[num],
                            onChanged: (value) {
                              setState(() {
                                listOfText.where((element) => element.key == Key("id_$num")).forEach((element) {
                                  setState(() {
                                    // element.text = value;
                                  });
                                });
                                // value = listOfController[num].text;
                                // listOfController[num].text = value;
                                // listOfText[count] = Text(value, key: Key("id_$count"),);
                              });

                              if(value.isEmpty) {
                                setState(() {
                                  noInput = true;
                                });
                              } else {
                                setState(() {
                                  noInput = false;
                                });
                              }
                            },
                            validator: (value) {
                              if(value.isEmpty){
                                return "Required. Can't be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        ElevatedButton(
                          child: Text("Remove"),
                          onPressed: () {
                            setState(() {
                              listOfTextFormFields.removeWhere((element) => element.key == Key("id_$num"),);
                              // listOfController.removeWhere((element) => element.value == listOfController[num].value);
                              // listOfController.remove(listOfController[countForControl]);
                              listOfText.removeWhere((element) => element.key == Key("id_$num"),);
                              // num--;
                              // count--;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                  count++;
                  print(count);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// TextFormField(
//   decoration: decoText.copyWith(
//     labelText: "How many steps do you want in this Exercise?",
//   ),
//   onChanged: (value) {
//     int num;
//
//     if(value.contains(RegExp('[0-9]'))) {
//       listOfTextFormFields.clear();
//       listOfController.clear();
//       listOfText.clear();
//
//       setState(() {
//         num = int.parse(value);
//         for(int i = 0; i < num; i++) {
//           labelTextForStep = "Short Name for Step " + (i+1).toString() + " e.g Take a walk";
//           listOfController.add(TextEditingController());
//           listOfText.add("");
//           listOfTextFormFields.add(
//             ExpansionTile(
//               key: Key("i_$i"),
//               leading: IconButton(
//                 icon: Icon(Icons.cancel),
//                 onPressed:  () {
//                   setState(() {
//                     listOfController[i].clear();
//                     listOfTextFormFields.removeWhere((element) => element.key == Key("i_$i"));
//                     print(i);
//                     // labelTextForStep = "Short Name for Step " + (i+1).toString() + " e.g Take a walk";
//                   });
//                 },
//               ),
//               title: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: decoText.copyWith(
//                     labelText: labelTextForStep,
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       listOfText[i] = value;
//                     });
//
//                     if(value.isEmpty) {
//                       setState(() {
//                         noInput = true;
//                       });
//                     } else {
//                       setState(() {
//                         noInput = false;
//                       });
//                     }
//                   },
//                   validator: (value) {
//                     if(value.isEmpty){
//                       return "Required. Can't be empty";
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//               ),
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextFormField(
//                     decoration: decoText.copyWith(
//                       labelText: "More Detailed Instructions for Step " + (i+1).toString(),
//                     ),
//                     onChanged: (value) {
//                       value = listOfController[i].text;
//                     },
//                     controller: listOfController[i],
//                     maxLines: null,
//                   ),
//                 ),
//               ],
//               initiallyExpanded: true,
//             ),
//           );
//         }
//       });
//     } else {
//       setState(() {
//         listOfTextFormFields.clear();
//         listOfController.clear();
//         listOfText.clear();
//       });
//       return null;
//     }
//   },
// ),

// //for adding FormField
// setState(() {
// int num = i;
// // listOfController.add(Text("", key: Key("controller_$num"),));
// // listOfText.add(Text("", key: Key("text_$num"),));
// // listOfString.add("");
// listOfController.add(Text("", key: Key("i_$num"),));
// listOfText.add(Text("", key: Key("i_$num"),));
// listOfTextFormFields.add(Column(key: Key("i_$num"), children: [
// // Text("Hello"),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: TextFormField(
// decoration: decoText.copyWith(
// labelText: "Short Name for Step " + (num+1).toString() + " e.g Take a walk",
// ),
// onChanged: (value) {
// setState(() {
// // listOfString[num] = value;
// listOfText[num] = Text(value, key: Key("i_$num"),);
// });
//
// if(value.isEmpty) {
// setState(() {
// noInput = true;
// });
// } else {
// setState(() {
// noInput = false;
// });
// }
// },
// validator: (value) {
// if(value.isEmpty){
// return "Required. Can't be empty";
// } else {
// return null;
// }
// },
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: TextFormField(
// decoration: decoText.copyWith(
// labelText: "More Detailed Instructions for Step " + (num+1).toString(),
// ),
// onChanged: (value) {
// listOfController[num] = Text(value, key: Key("i_$num"),);
// },
// maxLines: null,
// ),
// ),
// ElevatedButton(
// child: Text("Remove"),
// onPressed: () {
// setState(() {
// // print(listOfText);
// // listOfText.removeAt(num);
// // print(listOfText);
// // listOfString.removeWhere((element) => element. == listOfString[num]);
// listOfTextFormFields.removeWhere((element) => element.key == Key("i_$num"));
// listOfController.removeWhere((element) => element.key == Key("i_$num"));
// listOfText.removeWhere((element) => element.key == Key("i_$num"));
// if(listOfText.length == 0) {
// setState(() {
// noInput = true;
// });
// } else {
// setState(() {
// noInput = false;
// });
// }
// if(listOfTextFormFields.length == 0) {
// setState(() {
// listOfTextFormFields.clear();
// listOfText.clear();
// listOfController.clear();
// listOfString.clear();
// });
// } else {
// return null;
// }
// i = i - 1;
// });
// },
// ),
// ],));
// });
// // i = i + 1;
// // print(i);
// // i++;
// // print(i);
// // setState(() {
// //   listOfTextFormFields.clear();
// //   listOfController.clear();
// //   listOfText.clear();
// // });
// //
// // print(i);
// // setState(() {
// //   int num = i;
// //   listOfController.add(TextEditingController());
// //   listOfText.add("");
// //   listOfTextFormFields.add(
// //     ExpansionTile(
// //       key: Key("i_$num"),
// //       leading: IconButton(
// //         icon: Icon(Icons.cancel),
// //         onPressed:  () {
// //           // listOfController.removeAt(num);
// //           setState(() {
// //             listOfController.removeAt(num);
// //             // listOfController.removeWhere((element) {
// //             //   return element.text == null;
// //             // });
// //             listOfTextFormFields.removeWhere((element) {
// //               return element.key == Key("i_$num");
// //             });
// //             // listOfText.removeAt(num);
// //             // listOfTextFormFields.clear();
// //             // print(i);
// //             // i = i--;
// //             // labelTextForStep = "Short Name for Step " + (i+1).toString() + " e.g Take a walk";
// //           });
// //         },
// //       ),
// //       title: Padding(
// //         padding: const EdgeInsets.all(8.0),
// //         child: TextFormField(
// //           decoration: decoText.copyWith(
// //             labelText: labelTextForStep,
// //           ),
// //           onChanged: (value) {
// //             setState(() {
// //               listOfText[i] = value;
// //             });
// //
// //             if(value.isEmpty) {
// //               setState(() {
// //                 noInput = true;
// //               });
// //             } else {
// //               setState(() {
// //                 noInput = false;
// //               });
// //             }
// //           },
// //           validator: (value) {
// //             if(value.isEmpty){
// //               return "Required. Can't be empty";
// //             } else {
// //               return null;
// //             }
// //           },
// //         ),
// //       ),
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: TextFormField(
// //             decoration: decoText.copyWith(
// //               labelText: "More Detailed Instructions for Step " + (i+1).toString(),
// //             ),
// //             onChanged: (value) {
// //               value = listOfController[i].text;
// //             },
// //             controller: listOfController[i],
// //             maxLines: null,
// //           ),
// //         ),
// //       ],
// //       initiallyExpanded: true,
// //     ),
// //   );
// // });
// i = i + 1;
// // print(i);
// print(listOfTextFormFields.length);
// print(listOfController.length);
// print(listOfText.length);
// // print(listOfString);