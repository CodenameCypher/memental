import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memental/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:memental/screens/reminders/ReminderDataSource.dart';

class Calendar_View extends StatefulWidget {
  const Calendar_View({Key? key}) : super(key: key);

  @override
  State<Calendar_View> createState() => _ReminderState();
}

class _ReminderState extends State<Calendar_View> {
  @override
  Widget build(BuildContext context) {
    final List<Appointment> appointments = Provider.of<List<Appointment>>(context);
    final List<Appointment> reminders = [];
    appointments.forEach((element) {
      print(element.subject);
      if(element.subject.split(', ').elementAt(0) == FirebaseAuth.instance.currentUser!.uid){
        element.subject = element.subject.split(', ').elementAt(1);
        reminders.add(element);
      }
    });

    return reminders.length == 0 ?  LoadingScreen() : Scaffold(
      body: SfCalendar(
        view: CalendarView.day,
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