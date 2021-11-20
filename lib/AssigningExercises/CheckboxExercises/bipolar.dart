import 'package:flutter/material.dart';

class BPD extends StatefulWidget {
  // BPD(this.selectedList2, this.callback);
  //
  // // Passing the list from parent widget i.e, MyHomeWidget
  // // Initially the list will be empty
  // // We will update the list in parent whenever checkboxes change
  // final List<dynamic> selectedList2;
  //
  // // Creating a callback function to save state(update list) in
  // // MyHomeWidget
  // final void Function(List<dynamic>) callback;

  @override
  _BPDState createState() => _BPDState();
}

class _BPDState extends State<BPD> {
  // List of exercises
  Map<String, dynamic> _exercise = {
    "responseCode": "1",
    "responseBody": [
      {"id": "1", "exercise": "Breath slowly."},
      {"id": "2", "exercise": "Ask questions."},
      {"id": "3", "exercise": "Note impressions."},
      {"id": "4", "exercise": "Reflect."},
      {"id": "5", "exercise": "Respond."},
    ],
    "responseTotalResult": 5
  };

  // List of the explanation for the exercises
  Map<String, dynamic> _details = {
    "responseCode": "2",
    "responseBody": [
      {
        "id": "1",
        "details":
            "Transition your body from a heightened state to a mindful one. Also, unclench your fists. Flex your tight shoulders. Do not lash out."
      },
      {
        "id": "2",
        "details":
            "This helps clarify the source of the stress/trigger as well as determine actionable steps. It\'s okay to ask yourself if it\'s worth being upsate"
      },
      {
        "id": "3",
        "details":
            "Write down your immediate impressions of the situation. Note anything that comes to mind. This helps with expression + processing."
      },
      {
        "id": "4",
        "details":
            "After some time has passed, consider whether you feel better or worse and what happens next."
      },
      {
        "id": "5",
        "details":
            "Can you make amends? Or do you need to move on? Make a firm, rational decision."
      },
    ],
    "responseTotalResult": 5
  };

  // // To make sure the checkbox are checked even after we leave the page
  // void _onCategorySelected(bool selected, categoryId) {
  //   if (selected == true) {
  //     setState(() {
  //       widget.selectedList2.add(categoryId);
  //     });
  //   } else {
  //     setState(() {
  //       widget.selectedList2.remove(categoryId);
  //     });
  //   }
  //   // Callback to save the updated selectedList to MyHomeWidget list
  //   widget.callback(widget.selectedList2);
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        padding: EdgeInsets.only(
            left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _exercise['responseTotalResult'],
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            value:false, //just temporarily to show assigning exercises
            // value: widget.selectedList2
            //     .contains(_exercise['responseBody'][index]['id']),
            onChanged: (selected) {
              // _onCategorySelected(
              //     selected, _exercise['responseBody'][index]['id']);
            },
            contentPadding: EdgeInsets.only(
                left: 10.0, top: 0.0, right: 10.0, bottom: 10.0),
            title: Text(
              _exercise['responseBody'][index]['exercise'],
              textAlign: TextAlign.justify,
            ),
            subtitle: Text(
              _details['responseBody'][index]['details'],
              textAlign: TextAlign.justify,
            ),
          );
        },
      ),
    );
  }
}
