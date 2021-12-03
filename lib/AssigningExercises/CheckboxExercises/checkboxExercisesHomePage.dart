import 'package:flutter/material.dart';

class CheckboxExercisesHomePage extends StatefulWidget {
  @override
  _CheckboxExercisesHomePageState createState() => _CheckboxExercisesHomePageState();
}

class _CheckboxExercisesHomePageState extends State<CheckboxExercisesHomePage> {
  List<dynamic> selectedList = []; // For Meditation
  List<dynamic> selectedList1 = []; // For Anxiety Management
  List<dynamic> selectedList2 = []; // For BPD Management
  List<dynamic> selectedList3 = []; // For Depression Management
  List<dynamic> selectedList4 = []; // For PTSD Management

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) =>
              //             Meditation(selectedList, (List<dynamic> updatedList) {
              //           setState(() {
              //             selectedList = updatedList;
              //           });
              //         }),
              //       ),
              //     );
              //   },
              //   child: Text("Proceed for Meditation"),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) =>
              //             Anxiety(selectedList1, (List<dynamic> updatedList) {
              //           setState(() {
              //             selectedList1 = updatedList;
              //           });
              //         }),
              //       ),
              //     );
              //   },
              //   child: Text("Proceed for Anxiety Management"),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => BPD(
              //             selectedList2,
              //                 (List<dynamic> updatedList) {
              //               setState(() {
              //                 selectedList2 = updatedList;
              //               });
              //             }
              //         ),
              //       ),
              //     );
              //   },
              //   child: Text("Proceed for Bipolar Disorder (BPD) Management"),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => Depression(
              //             selectedList3,
              //                 (List<dynamic> updatedList) {
              //               setState(() {
              //                 selectedList3 = updatedList;
              //               });
              //             }
              //         ),
              //       ),
              //     );
              //   },
              //   child: Text("Proceed for Depression Management"),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => PTSD(
              //             selectedList4,
              //                 (List<dynamic> updatedList) {
              //               setState(() {
              //                 selectedList4 = updatedList;
              //               });
              //             }
              //         ),
              //       ),
              //     );
              //   },
              //   child: Text("Proceed for PTSD Management"),
              // ),
              // This is for Mahdi
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text('Record Log'),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
