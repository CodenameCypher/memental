import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(appointment.duid).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData){
            return Padding(
                padding: EdgeInsets.only(top: 10),
                child: FlipCard(
                    fill: Fill.fillBack,
                    front: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white
                      ),
                      margin: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                      padding: EdgeInsets.fromLTRB(6.0, 12.0, 6.0, 12.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/1085/1085413.png'),
                        ),
                        title: Text(
                          'Appointment: ${snapshot.requireData.get('name')}',
                          style: TextStyle(
                              fontFamily: 'Formal'
                          ),
                        ),
                        subtitle: Text(
                          'Date: ${appointment.dateTime.day}/${appointment.dateTime.month}/${appointment.dateTime.year}\nSchedule: ${appointment.dateTime.hour}:${appointment.dateTime.minute}',
                          style: TextStyle(
                              fontFamily: 'Formal',
                              height: 1.7
                          ),

                        ),
                      ),
                    ),
                    back: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: appointment.dateTime.compareTo(DateTime.now()) < 0 ? Colors.red[300] : appointment.approval? Colors.greenAccent[200] : Colors.red[300],
                      ),
                      padding: EdgeInsets.fromLTRB(6.0, 13.0, 6.0, 12.0),
                      margin: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage('https://icons.veryicon.com/png/o/miscellaneous/icon-library-of-x-bacteria/appointment-4.png'),
                        ),
                        title: Text(
                          "Approved: ${appointment.approval? 'Yes' : 'No'}",
                          style: TextStyle(
                              fontFamily: 'Formal',
                              color: Colors.black
                          ),
                        ),
                        subtitle: Text(
                          'Disease: ${appointment.disease}\nOverdue: ${appointment.dateTime.compareTo(DateTime.now()) < 0? 'Yes' : 'No'}',
                          style: TextStyle(
                              fontFamily: 'Formal',
                              color: Colors.grey[800],
                              height: 1.4
                          ),
                        ),
                        trailing: appointment.approval == false ? SizedBox(height: 0,) : IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.phone)
                        ) ,
                      ),
                    ),
                  direction: FlipDirection.VERTICAL,
                )
            );
          }
          else{
            return SizedBox(height: 0,);
          }
        }
    );
  }
}
