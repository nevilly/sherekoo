
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:flutter/material.dart';

class EventCalender extends StatefulWidget {
  final double radius;
  const EventCalender({
    Key? key,
    required this.radius,
  }) : super(key: key);

  @override
  State<EventCalender> createState() => _EventCalenderState();
}

class _EventCalenderState extends State<EventCalender> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SfCalendar(
          backgroundColor: Colors.white,
          view: CalendarView.month,
          initialDisplayDate: DateTime.now(),
        ),
    
      ],
    );
  }
}
