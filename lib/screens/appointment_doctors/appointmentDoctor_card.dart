import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/appointment.dart';
import 'package:memental/services/appointmentDatabase.dart';

class AppointmentCardDoctor extends StatefulWidget {
  final Appointment appointment;
  AppointmentCardDoctor({required this.appointment});

  @override
  State<AppointmentCardDoctor> createState() => _AppointmentCardDoctorState();
}

class _AppointmentCardDoctorState extends State<AppointmentCardDoctor> {
  bool approved = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(widget.appointment.puid).snapshots(),
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
                        backgroundColor: widget.appointment.dateTime.compareTo(DateTime.now()) < 0? Colors.redAccent[100] : widget.appointment.approval ? Colors.green[300] : Colors.redAccent[200],
                        backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuf0-p761VAwfgbRh1g1f_uNcYdfaYMfpebYiev7E9V_LZOjEZpO86azPnav4RU4JUlaA&usqp=CAU'),
                      ),
                      title: Text(
                        'Appointment: ${snapshot.requireData.get('name')}',
                        style: TextStyle(
                            fontFamily: 'Formal'
                        ),
                      ),
                      subtitle: Text(
                        'Date: ${widget.appointment.dateTime.day}/${widget.appointment.dateTime.month}/${widget.appointment.dateTime.year}\nSchedule: ${widget.appointment.dateTime.hour}:${widget.appointment.dateTime.minute}',
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
                      color: widget.appointment.dateTime.compareTo(DateTime.now()) < 0? Colors.redAccent[100] : widget.appointment.approval ? Colors.green[300] : Colors.redAccent[200],
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
                        "Approved: ${widget.appointment.approval? 'Yes' : 'No'}",
                        style: TextStyle(
                            fontFamily: 'Formal',
                            color: Colors.black
                        ),
                      ),
                      subtitle: Text(
                        'Disease: ${widget.appointment.disease}\nOverdue: ${widget.appointment.dateTime.compareTo(DateTime.now()) < 0? 'Yes' : 'No'}',
                        style: TextStyle(
                            fontFamily: 'Formal',
                            color: Colors.grey[800],
                            height: 1.4
                        ),
                      ),
                      trailing: widget.appointment.dateTime.compareTo(DateTime.now()) < 0? Icon(Icons.update_outlined) : widget.appointment.approval ?
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/prescribe', arguments: widget.appointment);
                            },
                            icon: Icon(Icons.edit_calendar_sharp),
                            tooltip: 'Write Prescription',
                          ),
                          IconButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/addReminder', arguments: widget.appointment);
                            },
                            icon: Icon(Icons.more_time_rounded),
                            tooltip: 'Add Reminder',
                          )
                        ],
                      ) : IconButton(
                        icon: Icon(Icons.check_circle_outline),
                        tooltip: 'Approve',
                        alignment: Alignment.centerRight,
                        onPressed: () async {
                          await AppointmentDatabase().approveAppointment(widget.appointment);
                        },
                      ),
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
