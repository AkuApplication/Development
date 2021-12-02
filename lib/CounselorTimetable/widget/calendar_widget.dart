import 'dart:math';

import 'package:chat_app/CounselorTimetable/model/event.dart';
import 'package:chat_app/CounselorTimetable/provider/event_provider.dart';
import 'package:chat_app/CounselorTimetable/widget/task_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

import '../model/event._data_source.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Event> takenFromFirestore = [];
  void getEventsFromFirestore() async {
    await _firestore.collection("timetable").get().then((value) {
      value.docs.forEach((element) {
        Timestamp timestampFrom = element["from"];
        Timestamp timestampTo = element["to"];
        Event event = Event(
          title: element["title"],
          description: element["description"],
          from: timestampFrom.toDate(),
          to: timestampTo.toDate(),
          isAllDay: element["isAllDay"],
        );

        final provider = Provider.of<EventProvider>(context, listen: false);
        // takenFromFirestore.forEach((element) {
        //   provider.addEvent(element);
        // });
        provider.addEvent(event);
      });
    });
  }

  @override
  void initState() {
    getEventsFromFirestore();
    print(takenFromFirestore.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);
        provider.setDate(details.date);
        showModalBottomSheet(
            context: context, builder: (context) => TasksWidget());
      },
    );
  }
}
