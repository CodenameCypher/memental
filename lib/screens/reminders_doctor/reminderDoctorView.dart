import 'package:flutter/material.dart';
import 'package:memental/screens/reminders_doctor/calendarDoctor_view.dart';
import 'package:provider/provider.dart';
import 'package:memental/services/appointmentDatabase.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ReminderDoctor extends StatelessWidget {
  const ReminderDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Appointment>>.value(
        value: AppointmentDatabase().doctorAppointmentsCalendar,
        initialData: [],
      child: CalendarDoctor_View(),
    );
  }
}
