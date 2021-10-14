import 'package:flutter/material.dart';

class TimeTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Timetable'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            width: 400,
            child: GridView.count(
              padding: EdgeInsets.all(15.0),
              scrollDirection: Axis.horizontal,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
              childAspectRatio: 2 / 1,
              children: [
                Container(
                  color: Colors.greenAccent,
                  child: Text('MON'),
                ),
                Container(
                  color: Colors.redAccent,
                  child: Text('Appointment 1'),
                ),
                Container(
                  color: Colors.blueAccent,
                  child: Text('Appointment 2'),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Appointment 3'),
                ),
                Container(
                  color: Colors.greenAccent,
                  child: Text('TUE'),
                ),
                Container(
                  color: Colors.redAccent,
                  child: Text('Appointment 1'),
                ),
                Container(
                  color: Colors.blueAccent,
                  child: Text('Appointment 2'),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Appointment 3'),
                ),
                Container(
                  color: Colors.greenAccent,
                  child: Text('WED'),
                ),
                Container(
                  color: Colors.redAccent,
                  child: Text('Appointment 1'),
                ),
                Container(
                  color: Colors.blueAccent,
                  child: Text('Appointment 2'),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Appointment 3'),
                ),
                Container(
                  color: Colors.greenAccent,
                  child: Text('THU'),
                ),
                Container(
                  color: Colors.redAccent,
                  child: Text('Appointment 1'),
                ),
                Container(
                  color: Colors.blueAccent,
                  child: Text('Appointment 2'),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Appointment 3'),
                ),
                Container(
                  color: Colors.greenAccent,
                  child: Text('FRI'),
                ),
                Container(
                  color: Colors.redAccent,
                  child: Text('Appointment 1'),
                ),
                Container(
                  color: Colors.blueAccent,
                  child: Text('Appointment 2'),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Appointment 3'),
                ),
                Container(
                  color: Colors.greenAccent,
                  child: Text('SAT'),
                ),
                Container(
                  color: Colors.redAccent,
                  child: Text('Appointment 1'),
                ),
                Container(
                  color: Colors.blueAccent,
                  child: Text('Appointment 2'),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Appointment 3'),
                ),
                Container(
                  color: Colors.greenAccent,
                  child: Text('SUN'),
                ),
                Container(
                  color: Colors.redAccent,
                  child: Text('Appointment 1'),
                ),
                Container(
                  color: Colors.blueAccent,
                  child: Text('Appointment 2'),
                ),
                Container(
                  color: Colors.orange,
                  child: Text('Appointment 3'),
                ),
              ],
            ),
          ),
          Text('Insert button here'),
        ],
      ),
    );
  }
}
