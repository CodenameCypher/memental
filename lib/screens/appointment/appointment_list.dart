import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/appointment.dart';
import 'package:memental/screens/appointment/appointment_card.dart';
import 'package:memental/shared/loading.dart';
import 'package:provider/provider.dart';

class AppointmentList extends StatefulWidget {
  const AppointmentList({Key? key}) : super(key: key);

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  Widget build(BuildContext context) {
    final List<Appointment> appointments = Provider.of<List<Appointment>>(context);

    return appointments.length == 0 ? LoadingScreen() : ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index){
        if(appointments[index].puid == FirebaseAuth.instance.currentUser!.uid && !appointments[index].done) {
          return AppointmentCard(appointment: appointments[index]);
        }
        else{
          return SizedBox(height: 0,);
        }
      },
    );
  }
}
