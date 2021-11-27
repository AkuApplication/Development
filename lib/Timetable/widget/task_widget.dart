import 'package:chat_app/Timetable/model/event._data_source.dart';
import 'package:chat_app/Timetable/provider/event_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';

class TasksWidget extends StatefulWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return Center(
          child: Text(
        "No Events found!",
        style: TextStyle(color: Colors.black, fontSize: 24),
      ) // Text
          );
      // Center
    }

    return SfCalendar(
      view: CalendarView.timelineDay,
      dataSource: EventDataSource(provider.events),
      initialDisplayDate: provider.selectedDate,
      appointmentBuilder: appointmentBuilder,
      onTap: (details) {
        if (details.appointments == null) return;
        final event = details.appointments.first;
      },
      // SfCalendar
    ); // SfCalendarTheme
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ), // BoxDecoration
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ), // TextStyle
        ),
      ), //
    );
  }
}
