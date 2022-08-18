import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:memental/screens/reminders/ReminderDataSource.dart';

class CalendarDoctor_View extends StatefulWidget {
  const CalendarDoctor_View({Key? key}) : super(key: key);

  @override
  State<CalendarDoctor_View> createState() => _ReminderState();
}

class _ReminderState extends State<CalendarDoctor_View> {
  @override
  Widget build(BuildContext context) {
    final List<Appointment> appointments = Provider.of<List<Appointment>>(context);
    final List<Appointment> reminders = [];
    appointments.forEach((element) { 
      if(element.subject == FirebaseAuth.instance.currentUser!.uid){
        reminders.add(element);
      }
    });

    return Scaffold(
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 6,
        dataSource: ReminderDataSource(reminders),
        headerStyle: CalendarHeaderStyle(
          textAlign: TextAlign.center,
          backgroundColor: Colors.green[100],
          textStyle: TextStyle(
            fontFamily: 'Formal',
            fontSize: 16
          )
        ),
        showWeekNumber: true,
        allowAppointmentResize: false,
      ),
    );
  }
}