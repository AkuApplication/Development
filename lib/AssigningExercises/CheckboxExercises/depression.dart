import 'package:flutter/material.dart';

class Depression extends StatefulWidget {
  // Depression(this.selectedList3, this.callback);
  //
  // // Passing the list from parent widget i.e, MyHomeWidget
  // // Initially the list will be empty
  // // We will update the list in parent whenever checkboxes change
  // final List<dynamic> selectedList3;
  //
  // // Creating a callback function to save state(update list) in
  // // MyHomeWidget
  // final void Function(List<dynamic>) callback;

  @override
  _DepressionState createState() => _DepressionState();
}

class _DepressionState extends State<Depression> {
  // List of exercises
  Map<String, dynamic> _exercise = {
    "responseCode": "1",
    "responseBody": [
      {"id": "1", "exercise": "Acceptance."},
      {"id": "2", "exercise": "Get a journal."},
      {"id": "3", "exercise": "Reach out."},
      {"id": "4", "exercise": "Comfort yourself."},
      {"id": "5", "exercise": "Rest."},
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
            "Practice mindfulness. Accept every thought you have. Accept that it is okay to feel down, and sad, nurture your inner child, pay attention to what your mind/body wants."
      },
      {
        "id": "2",
        "details":
            "Journal your thoughts, write everything down no matter how nonsensical it can be; scribble, draw, doodle, paint, anything that pops into mind, break the boundary of conforming to a system when expressing yourself."
      },
      {
        "id": "3",
        "details":
            "Call your friends, your loved ones, talk to them, hang out with them virtually, have activities to do together. Be present, savour every moment you spend with them."
      },
      {
        "id": "4",
        "details":
            "Comfort yourself, have a warm cup of coffee in your sweaters, listen to music, blast it out and sing, exercise; do things that make you feel good, even though you do not feel like it, take big tasks and break them into small steps."
      },
      {
        "id": "5",
        "details":
            "Have a short nap or a long healthy sleep. Let your mind and body get the rest they deserve. Give them time and let them heal."
      },
    ],
    "responseTotalResult": 5
  };

  // // To make sure the checkbox are checked even after we leave the page
  // void _onCategorySelected(bool selected, categoryId) {
  //   if (selected == true) {
  //     setState(() {
  //       widget.selectedList3.add(categoryId);
  //     });
  //   } else {
  //     setState(() {
  //       widget.selectedList3.remove(categoryId);
  //     });
  //   }
  //   // Callback to save the updated selectedList to MyHomeWidget list
  //   widget.callback(widget.selectedList3);
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
            // value: widget.selectedList3
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
