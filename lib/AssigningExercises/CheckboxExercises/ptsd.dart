import 'package:flutter/material.dart';

class PTSD extends StatefulWidget {
  // PTSD(this.selectedList4, this.callback);
  //
  // // Passing the list from parent widget i.e, MyHomeWidget
  // // Initially the list will be empty
  // // We will update the list in parent whenever checkboxes change
  // final List<dynamic> selectedList4;
  //
  // // Creating a callback function to save state(update list) in
  // // MyHomeWidget
  // final void Function(List<dynamic>) callback;

  @override
  _PTSDState createState() => _PTSDState();
}

class _PTSDState extends State<PTSD> {
  // List of exercises
  Map<String, dynamic> _exercise = {
    "responseCode": "1",
    "responseBody": [
      {"id": "1", "exercise": "Practice mindfulness."},
      {"id": "2", "exercise": "Try aromatherapy."},
      {"id": "3", "exercise": "Brief activity."},
      {"id": "4", "exercise": "Try something new."},
    ],
    "responseTotalResult": 4
  };

  // List of the explanation for the exercises
  Map<String, dynamic> _details = {
    "responseCode": "1",
    "responseBody": [
      {
        "id": "1",
        "details":
            "Focus on your breathing by doing breathing exercises (Meditation), You can learn to be more mindful and aware of the present moment. When practicing mindfulness, you can become more cognizant of bodily sensations, thoughts and feelings and learn PTSD triggers."
      },
      {
        "id": "2",
        "details":
            "Try aromatherapy which includes essential oils such as rose, lavender, ylang-ylang, sage and chamomile, which are known for their calming properties."
      },
      {
        "id": "3",
        "details":
            "When you feel anxious, take a brisk walk or jog. Physical activity can also be a source of happiness and provide relief from flashbacks and negative views of the world."
      },
      {
        "id": "4",
        "details":
            "FInd a creative outlet by trying out something new by trying painting, journaling or sewing, Hobbies can provide relief from anxiety and irritability."
      },
    ],
    "responseTotalResult": 4
  };

  // // To make sure the checkbox are checked even after we leave the page
  // void _onCategorySelected(bool selected, categoryId) {
  //   if (selected == true) {
  //     setState(() {
  //       widget.selectedList4.add(categoryId);
  //     });
  //   } else {
  //     setState(() {
  //       widget.selectedList4.remove(categoryId);
  //     });
  //   }
  //   // Callback to save the updated selectedList to MyHomeWidget list
  //   widget.callback(widget.selectedList4);
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
            // value: widget.selectedList4
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
