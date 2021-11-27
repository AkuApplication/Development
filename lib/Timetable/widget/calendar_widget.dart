import 'package:chat_app/Timetable/provider/event_provider.dart';
import 'package:chat_app/Timetable/widget/task_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

import '../model/event._data_source.dart';

class Calendarwidget extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
