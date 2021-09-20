import 'package:flutter/material.dart';

class Timetable extends StatefulWidget {

  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {

  // late DateTime _dateTime;
  // DateTime _dateTime;

  // String getText() {
  //   if (_dateTime == null) {
  //     return 'Select Date';
  //   } else {
  //     return '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}';
  //   }
  // }

  // late TimeOfDay time;
  TimeOfDay time;
  // late TimeOfDay picked;
  TimeOfDay picked;

  void initState() {
    super.initState();
    time = TimeOfDay.now();
  }

  Future <Null> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
        context: context,
        initialTime: time
    ));

    if (picked != null) {
      setState(() {
        time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff546585),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
            'Booking Slot',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NAME',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'Patient\'s Name',
              ),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 10.0,),
            Text(
              'REASON FOR APPOINTMENT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'e.g. Yearly check up',
              ),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 10.0,),
            Text(
              'THERAPIST IN CHECK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'Therapist\'s Name',
              ),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 10.0,),
            Text(
              'DATE & TIME SLOT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  // padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  // elevation: 0.0,
                  onPressed: () {
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(3000),
                    );
                  },
                  child: Text('Select Date'),
                ),
                SizedBox(width: 20.0,),
                ElevatedButton(
                  // padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  // elevation: 0.0,
                  onPressed: () {
                    selectTime(context);
                    print(time);
                  },
                  child: Text('${time.hour} : ${time.minute}'),
                ),
              ],
            ),
            SizedBox(height: 125.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  // padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                  onPressed: () { print('This will discard everything'); },
                  child: Text(
                    'Discard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  // color: Color(0xffDC143C),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20.0),
                  // ),
                ),
                SizedBox(width: 20.0,),
                ElevatedButton(
                  // padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                    onPressed: () { print('This will submit everything'); },
                  child: Text(
                      'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  // color: Color(0xff32CD32),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20.0),
                  // ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
