import 'package:flutter/material.dart';
import 'package:memental/model/appointment.dart';
import 'package:memental/screens/appointment/appointment_list.dart';
import 'package:memental/services/appointmentDatabase.dart';
import 'package:provider/provider.dart';

class Appointments extends StatelessWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Appointment>>.value(
      value: AppointmentDatabase().patientAppointments,
      initialData: [],
      child: AppointmentList(),
    );
  }
}
