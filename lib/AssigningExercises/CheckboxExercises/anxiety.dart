import 'package:flutter/material.dart';

class Anxiety extends StatefulWidget {
  // Anxiety(this.selectedList1, this.callback);
  //
  // // Passing the list from parent widget i.e, MyHomeWidget
  // // Initially the list will be empty
  // // We will update the list in parent whenever checkboxes change
  // final List<dynamic> selectedList1;
  //
  // // Creating a callback function to save state(update list) in
  // // MyHomeWidget
  // final void Function(List<dynamic>) callback;

  @override
  _AnxietyState createState() => _AnxietyState();
}

class _AnxietyState extends State<Anxiety> {
  // List of exercises
  Map<String, dynamic> _exercise = {
    "responseCode": "1",
    "responseBody": [
      {"id": "1", "exercise": "Breath with the 4-7-8 technique."},
      {"id": "2", "exercise": "Get active."},
      {"id": "3", "exercise": "Run."},
      {"id": "4", "exercise": "Think about something funny."},
      {"id": "5", "exercise": "Do the 5-4-3-2-1 technique."},
    ],
    "responseTotalResult": 5
  };

  // List of the explanation for the exercises
  Map<String, dynamic> _details = {
    "responseCode": "1",
    "responseBody": [
      {
        "id": "1",
        "details":
            "Some people find 4-7-8 technique breathing particularly effective.\n\n 1) Breath in for 4 seconds.\n 2) Hold your breath for 7 seconds.\n 3) Exhale slowly for 8 seconds.\n 4) Repeat until you feel calmer."
      },
      {
        "id": "2",
        "details":
            "For starters, become more active around the house. You might not think of gardening, for example, as exercise — but an afternoon of tilling soil will give you many of the benefits you’re seeking. Walking your dog, doing home improvement projects, or even washing your car are all great ways to get moving."
      },
      {
        "id": "3",
        "details":
            "A quick burst of exercise that increases your heart rate is helpful in reducing anxiety. While doing any heavy exercises, it is also important to focus on your breathing. Last but not least, you may find a suitable place for you to shout at the top of your lungs."
      },
      {
        "id": "4",
        "details":
            "Visualize your favourite humorous moments, or your favourite jokes. This may include: \n\n 1) Read or watch cartoon.\n 2) Watch sitcoms and funny videos.\n 3) Watch cat or dog videos."
      },
      {
        "id": "5",
        "details":
            "This is also called the Grounding Technique. Here's how:\n\n1) Five. Look around and name five things you see. These can be objects, spots on the wall or a bird flying outside. The key is to count down those five things.\n\n 2) Four. Name four things you can touch. This can be the ground beneath your feet, the chair you’re sitting in, or your hair that you run your fingers through.\n\n3) Find three things you can hear. These can be external sounds, like a fan in the room, or internal sounds, like the sound of your breathing.\n\n4) Two. Note two things you can smell. Maybe that’s the perfume you’re wearing or the whatever it is that you’re holding.\n\n5) One. Notice something you can taste inside your mouth. Maybe the taste of your lips."
      },
    ],
    "responseTotalResult": 5
  };
  //
  // // To make sure the checkbox are checked even after we leave the page
  // void _onCategorySelected(bool selected, categoryId) {
  //   if (selected == true) {
  //     setState(() {
  //       widget.selectedList1.add(categoryId);
  //     });
  //   } else {
  //     setState(() {
  //       widget.selectedList1.remove(categoryId);
  //     });
  //   }
  //   // Callback to save the updated selectedList to MyHomeWidget list
  //   widget.callback(widget.selectedList1);
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
            // value: widget.selectedList1
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
