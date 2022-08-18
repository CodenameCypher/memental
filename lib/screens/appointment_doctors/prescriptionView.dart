import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/appointment.dart';
import 'package:memental/services/appointmentDatabase.dart';
import 'package:memental/shared/loading.dart';

class Prescribe extends StatefulWidget {
  const Prescribe({Key? key}) : super(key: key);

  @override
  State<Prescribe> createState() => _PrescribeState();
}

class _PrescribeState extends State<Prescribe> {

  String prescription = '';

  @override
  Widget build(BuildContext context) {
    Appointment appointment = ModalRoute.of(context)!.settings.arguments as Appointment;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(appointment.puid).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData){
            return Scaffold(
              backgroundColor: Colors.greenAccent[100],
              appBar: AppBar(
                leading: BackButton(
                  color: Colors.green[900],
                ),
                backgroundColor: Colors.greenAccent[400],
                title: Text(
                  'Prescribe ${snapshot.requireData.get('name')}',
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
                        'Patient: ${snapshot.requireData.get('name')}',
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
                    SizedBox(height: 30,),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Prescription",
                        prefixIcon: Icon(
                          Icons.edit_calendar_sharp,
                          color: Colors.green[900],
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2.0),
                        ),
                      ),
                      onChanged: (v){
                        setState(() {
                          this.prescription = v;
                        });
                      },
                    )
                  ],
                ),
              ),

              floatingActionButton: FloatingActionButton(
                onPressed: () async{
                  await AppointmentDatabase().updatePrescription(appointment, prescription);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          elevation: 3,
                          title: Text('Prescription added!'),
                          content: Text('You have added an prescription for ${snapshot.requireData.get('name')} for ${appointment.disease}. Thank you.'),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('OK')
                            )
                          ],
                        );
                      }
                  );
                },
                child: Icon(Icons.save_outlined),
                backgroundColor: Colors.green[700],
                splashColor: Colors.greenAccent,
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            );
          }
          else{
            return LoadingScreen();
          }
        }
    );
  }
}
