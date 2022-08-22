import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memental/model/reminder.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sfcalendar;
import 'package:flutter/material.dart';

class ReminderDatabase{
  final CollectionReference reminderDatabase = FirebaseFirestore.instance.collection('reminders');

  Future createReminder(Reminder reminder) async{
    String id = await reminderDatabase.doc().id;
    return await reminderDatabase.doc(id).set({
      'userUID' : reminder.userUID,
      'subject' : reminder.subject,
      'startTime' : reminder.startTime,
      'endTime': reminder.endTime
    });
  }

  Stream<List<sfcalendar.Appointment>> get activeReminders{
    return reminderDatabase.snapshots().map(_activeRemindersAppointmentObject);
  }

  List<sfcalendar.Appointment> _activeRemindersAppointmentObject(QuerySnapshot s){
    return s.docs.map((e){
      return sfcalendar.Appointment(
        startTime: e.get('startTime').toDate(),
        endTime: e.get('endTime').toDate(),
        subject: '${e.get('userUID')}, ${e.get('subject')}',
        color: Colors.red,
      );
    }).toList();
  }
}