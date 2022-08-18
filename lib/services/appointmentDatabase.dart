import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memental/model/appointment.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sfcalendar;
import 'package:flutter/material.dart';

class AppointmentDatabase{

  final CollectionReference appointmentDatabase = FirebaseFirestore.instance.collection('appointments');

  Future createAppointment(Appointment appointment) async {
    String id = await appointmentDatabase.doc().id;
    return await appointmentDatabase.doc(id).set({
      'patient_uid' : appointment.puid,
      'doctor_uid' : appointment.duid,
      'disease' : appointment.disease,
      'prescription' : appointment.prescription,
      'datetime' : appointment.dateTime,
      'approval' : appointment.approval,
      'done' : appointment.done,
    });
  }

  Future updatePrescription(Appointment appointment, String presription) async {
    String p = DateTime.now().day.toString() + '/' + DateTime.now().month.toString() + '/' + DateTime.now().year.toString() + ' => ' + presription;
    return await appointmentDatabase.doc(appointment.uid).set({
      'patient_uid' : appointment.puid,
      'doctor_uid' : appointment.duid,
      'disease' : appointment.disease,
      'prescription' : appointment.prescription == '' ? p : appointment.prescription + ' || ' + p,
      'datetime' : appointment.dateTime,
      'approval' : appointment.approval,
      'done' : appointment.done,
    });
  }

  Future approveAppointment(Appointment appointment) async {
    return await appointmentDatabase.doc(appointment.uid).set({
      'patient_uid' : appointment.puid,
      'doctor_uid' : appointment.duid,
      'disease' : appointment.disease,
      'prescription' : appointment.prescription,
      'datetime' : appointment.dateTime,
      'approval' : true,
      'done' : appointment.done,
    });
  }

  Stream<List<Appointment>> get patientAppointments{
    return appointmentDatabase.snapshots().map(_activePatientAppointment);
  }

  Stream<List<sfcalendar.Appointment>>  get patientAppointmentsCalendar{
    return appointmentDatabase.snapshots().map(_activePatientAppointmentCalendar);
  }

  Stream<List<sfcalendar.Appointment>>  get doctorAppointmentsCalendar{
    return appointmentDatabase.snapshots().map(_activeDoctorAppointmentCalendar);
  }

  List<Appointment> _activePatientAppointment(QuerySnapshot s){
    return s.docs.map((e){
      Appointment appointment = Appointment(
          puid: e.get('patient_uid'),
          duid: e.get('doctor_uid'),
          dateTime: e.get('datetime').toDate(),
          prescription: e.get('prescription'),
          approval: e.get('approval'),
          disease: e.get('disease'),
          done: e.get('done'));
      appointment.uid = e.id;
      return appointment;
    }).toList();
  }

  List<sfcalendar.Appointment> _activePatientAppointmentCalendar(QuerySnapshot s){
    return s.docs.map((e){
      return sfcalendar.Appointment(
          startTime: e.get('datetime').toDate(),
          endTime: (e.get('datetime').toDate()).add(Duration(minutes: 30)),
          subject: '${e.get('patient_uid')}',
          color: Colors.red,
      );
    }).toList();
  }

  List<sfcalendar.Appointment> _activeDoctorAppointmentCalendar(QuerySnapshot s){
    return s.docs.map((e){
      return sfcalendar.Appointment(
        startTime: e.get('datetime').toDate(),
        endTime: (e.get('datetime').toDate()).add(Duration(minutes: 30)),
        subject: '${e.get('doctor_uid')}',
        color: Colors.red,
      );
    }).toList();
  }

}