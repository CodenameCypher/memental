import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/appointment.dart';
import 'package:memental/screens/appointment_doctors/appointmentDoctor_card.dart';
import 'package:memental/shared/loading.dart';
import 'package:provider/provider.dart';

class AppointmentListDoctor extends StatefulWidget {
  const AppointmentListDoctor({Key? key}) : super(key: key);

  @override
  State<AppointmentListDoctor> createState() => _AppointmentListDoctorState();
}

class _AppointmentListDoctorState extends State<AppointmentListDoctor> {
  @override
  Widget build(BuildContext context) {
    final List<Appointment> appointments = Provider.of<List<Appointment>>(context);

    return appointments.length == 0 ? LoadingScreen() : ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index){
        if(appointments[index].duid == FirebaseAuth.instance.currentUser!.uid && !appointments[index].done) {
          return AppointmentCardDoctor(appointment: appointments[index]);
        }
        else{
          return SizedBox(height: 0,);
        }
      },
    );
  }
}
