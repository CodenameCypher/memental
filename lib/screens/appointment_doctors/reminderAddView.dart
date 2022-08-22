import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:memental/model/appointment.dart';
import 'package:memental/services/reminderDatabase.dart';
import 'package:memental/shared/loading.dart';
import 'package:memental/model/reminder.dart';

class ReminderAdd extends StatefulWidget {
  const ReminderAdd({Key? key}) : super(key: key);

  @override
  State<ReminderAdd> createState() => _ReminderAddState();
}

class _ReminderAddState extends State<ReminderAdd> {

  String subject = '';
  DateTime dateTime = DateTime.now();

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
                  'Add reminder for ${snapshot.requireData.get('name')}',
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
                        labelText: "Reminder Subject",
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
                          this.subject = v;
                        });
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      onTap: (){
                        DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            theme: DatePickerTheme(
                                backgroundColor: Colors.greenAccent,
                                doneStyle: TextStyle(
                                  fontFamily: 'Formal',
                                  color: Colors.green[900],
                                ),
                                cancelStyle: TextStyle(
                                  fontFamily: 'Formal',
                                  color: Colors.red[900],
                                ),
                                itemStyle: TextStyle(
                                    fontFamily: 'Formal',
                                    fontSize: 12
                                )
                            ),
                            minTime: DateTime.now().add(Duration(days: 2)),
                            maxTime: DateTime.now().add(Duration(days: 9)),
                            onConfirm: (date){
                              setState(() {
                                this.dateTime = date;
                              });
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.en
                        );
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Date",
                        hintText: this.dateTime.toLocal().toString(),
                        prefixIcon: Icon(
                          Icons.date_range_outlined,
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
                    ),
                  ],
                ),
              ),

              floatingActionButton: FloatingActionButton(
                onPressed: () async{
                  Reminder reminder = Reminder(userUID: appointment.puid, subject: this.subject, startTime: this.dateTime, endTime: this.dateTime.add(Duration(minutes: 30)));
                  await ReminderDatabase().createReminder(reminder);
                  print('Reminder added');
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          elevation: 3,
                          title: Text('Reminder added!'),
                          content: Text('You have added an reminder for ${snapshot.requireData.get('name')}. Thank you.'),
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
