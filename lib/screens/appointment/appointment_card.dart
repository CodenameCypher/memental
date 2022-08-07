import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
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
                  appointment.duid,
                  style: TextStyle(
                      fontFamily: 'Formal'
                  ),
                ),
                subtitle: Text(
                  'Schedule: '+appointment.dateTime.toString(),
                  style: TextStyle(
                      fontFamily: 'Formal',
                      height: 1.4
                  ),

                ),
              ),
            ),
            back: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              padding: EdgeInsets.fromLTRB(6.0, 13.0, 6.0, 12.0),
              margin: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/1085/1085413.png'),
                ),
                title: Text(
                  "Disease: ${appointment.disease}",
                  style: TextStyle(
                      fontFamily: 'Formal',
                      color: Colors.black
                  ),
                ),
                subtitle: Text(
                  'Prescription: ' + appointment.prescription,
                  style: TextStyle(
                      fontFamily: 'Formal',
                      color: Colors.grey[800],
                      height: 1.4
                  ),

                ),
              ),
            )
        )
    );
  }
}
