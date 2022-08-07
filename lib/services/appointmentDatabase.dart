import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memental/model/appointment.dart';

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

  Stream<List<Appointment>> get patientAppointments{
    return appointmentDatabase.snapshots().map(_activePatientAppointment);
  }

  List<Appointment> _activePatientAppointment(QuerySnapshot s){
    return s.docs.map((e){
      return Appointment(
          puid: e.get('patient_uid'),
          duid: e.get('doctor_uid'),
          dateTime: e.get('datetime').toDate(),
          prescription: e.get('prescription'),
          approval: e.get('approval'),
          disease: e.get('disease'),
          done: e.get('done'));
    }).toList();
  }

}