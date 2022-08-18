import 'package:flutter/material.dart';
import 'package:memental/model/appointment.dart';
import 'package:memental/screens/appointment_doctors/appointmentDoctor_List.dart';
import 'package:memental/services/appointmentDatabase.dart';
import 'package:provider/provider.dart';

class AppointmentsDoctor extends StatelessWidget {
  const AppointmentsDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Appointment>>.value(
      value: AppointmentDatabase().patientAppointments,
      initialData: [],
      child: AppointmentListDoctor(),
    );
  }
}
