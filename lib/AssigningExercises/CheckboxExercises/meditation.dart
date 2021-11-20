import 'package:flutter/material.dart';

class Meditation extends StatefulWidget {
  // Meditation(this.selectedList, this.callback);
  //
  // // Passing the list from parent widget i.e, MyHomeWidget
  // // Initially the list will be empty
  // // We will update the list in parent whenever checkboxes change
  // final List<dynamic> selectedList;
  //
  // // Creating a callback function to save state(update list) in
  // // MyHomeWidget
  // final void Function(List<dynamic>) callback;

  @override
  _MeditationState createState() => _MeditationState();
}

class _MeditationState extends State<Meditation> {
  // List of exercises
  Map<String, dynamic> _exercise = {
    "responseCode": "1",
    "responseBody": [
      {"id": "1", "exercise": "Take a seat."},
      {"id": "2", "exercise": "Set a time limit."},
      {"id": "3", "exercise": "Notice your body."},
      {"id": "4", "exercise": "Feel your breath"},
      {"id": "5", "exercise": "Notice when your mind has wandered."},
      {"id": "6", "exercise": "Be kind to your wandering mind."},
      {"id": "7", "exercise": "Close with kindness."},
    ],
    "responseTotalResult": 7
  };

  // List of the explanation for the exercises
  Map<String, dynamic> _details = {
    "responseCode": "1",
    "responseBody": [
      {
        "id": "1",
        "details": "Find place to sit that feels clam and quite to you."
      },
      {
        "id": "2",
        "details":
            "If you're just beginning, it can help to chose a short time, such as 5 or 10 minutes."
      },
      {
        "id": "3",
        "details":
            "You can sit in a chair with your feet on the floor, you can sit loosely cross-legged, you can kneel - all are fine. Just make sure you're stable and in a position you can stay in for a while."
      },
      {
        "id": "4",
        "details":
            "Follow the sensation of your breath as it goes in and it goes out."
      },
      {
        "id": "5",
        "details":
            "Inevitably, your attention will leave the breath and wander to other places. When you get around to noticing that your mind has wandered—in a few seconds, a minute, five minutes—simply return your attention to the breath."
      },
      {
        "id": "6",
        "details":
            "Don’t judge yourself or obsess over the content of the thoughts you find yourself lost in. Just come back."
      },
      {
        "id": "7",
        "details":
            "When you’re ready, gently lift your gaze (if your eyes are closed, open them). Take a moment and notice any sounds in the environment. Notice how your body feels right now. Notice your thoughts and emotions."
      },
    ],
    "responseTotalResult": 7
  };

  // // To make sure the checkbox are checked even after we leave the page
  // void _onCategorySelected(bool selected, categoryId) {
  //   if (selected == true) {
  //     setState(() {
  //       widget.selectedList.add(categoryId);
  //     });
  //   } else {
  //     setState(() {
  //       widget.selectedList.remove(categoryId);
  //     });
  //   }
  //   // Callback to save the updated selectedList to MyHomeWidget list
  //   widget.callback(widget.selectedList);
  // }

  List<dynamic> historyList = [];

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
            // value: widget.selectedList
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
