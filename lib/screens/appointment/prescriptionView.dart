import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/appointment.dart';

class PrescriptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Appointment appointment = ModalRoute.of(context)!.settings.arguments as Appointment;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(appointment.duid).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        return Scaffold(
          backgroundColor: Colors.greenAccent[100],
          appBar: AppBar(
            leading: BackButton(
              color: Colors.green[900],
            ),
            backgroundColor: Colors.greenAccent[400],
            title: Text(
              'Prescription',
              style: TextStyle(
                fontFamily: 'Formal',
                fontSize: 17,
                color: Colors.green[900],
              ),
            ),
            elevation: 2,
          ),

          body: Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Doctor: ${snapshot.requireData.get('name')}',
                  style: TextStyle(
                      fontFamily: 'Formal',
                      fontSize: 20
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Disease Details: ${appointment.disease}',
                  style: TextStyle(
                    fontFamily: 'Formal',
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 10,),
                Divider(),
                SizedBox(height: 10,),
                Text(
                  'Prescription:\n',
                  style: TextStyle(
                    fontFamily: 'Formal',
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${appointment.prescription.replaceAll(' || ', '\n')}',
                  style: TextStyle(
                    fontFamily: 'Formal',
                    fontSize: 14,
                    height: 1.6
                  ),
                )

              ],
            ),
          ),
        );
      }
    );
  }
}
