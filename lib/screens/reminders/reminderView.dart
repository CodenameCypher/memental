import 'package:flutter/material.dart';
import 'package:memental/screens/reminders/calendar_view.dart';
import 'package:memental/services/reminderDatabase.dart';
import 'package:provider/provider.dart';
import 'package:memental/services/appointmentDatabase.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Reminder extends StatelessWidget {
  const Reminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Appointment>>.value(
        value: ReminderDatabase().activeReminders,
        initialData: [],
      child: Calendar_View(),
    );
  }
}
