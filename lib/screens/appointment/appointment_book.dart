import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:memental/model/appointment.dart';
import 'package:memental/model/user.dart';
import 'package:memental/services/appointmentDatabase.dart';
import 'package:memental/shared/loading.dart';

class AppointmentBooking extends StatefulWidget {
  const AppointmentBooking({Key? key}) : super(key: key);

  @override
  State<AppointmentBooking> createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<AppointmentBooking> {

  String disease = '';
  DateTime date = DateTime.now();
  String update = '';
  bool loading = false;


  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    UserModel doctor = ModalRoute.of(context)!.settings.arguments as UserModel;
    return loading? LoadingScreen() : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        leading: BackButton(
          color: Colors.green[900],
        ),
        backgroundColor: Colors.greenAccent[400],
        title: Text(
          'Book Appointment',
          style: TextStyle(
            fontFamily: 'Formal',
            color: Colors.green[900],
          ),
        ),
        elevation: 2,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.greenAccent[400],
                  radius: 50,
                  child: Icon(
                    Icons.supervised_user_circle_outlined,
                    size: 20,
                    color: Colors.green[900],
                  ),
                  backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/1085/1085413.png'),
                ),
                SizedBox(height: 10,),
                Text(
                  doctor.name,
                  style: TextStyle(
                      fontFamily: 'Formal',
                      fontSize: 20
                  ),
                ),
                SizedBox(height: 6,),
                Text(
                  doctor.speciality,
                  style: TextStyle(
                    fontFamily: 'Formal',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Divider(),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: "Disease",
                    prefixIcon: Icon(
                      Icons.sick_outlined,
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
                      this.disease = v;
                    });
                  },
                ),
                SizedBox(height: 20,),
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
                              this.date = date;
                            });
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.en
                      );
                    },
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Date",
                    hintText: this.date.toLocal().toString(),
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
                Text(
                  update,
                  style: TextStyle(
                    fontFamily: 'Formal',
                    color: Colors.green[800],
                  ),
                )
              ],
            ),
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add Appointment',
        backgroundColor: Colors.green[700],
        splashColor: Colors.greenAccent,
        onPressed: () async {
          setState(() {
            loading = true;
          });
          Appointment appointment = Appointment(
              puid: FirebaseAuth.instance.currentUser!.uid,
              duid: doctor.uid,
              dateTime: this.date,
              prescription: '',
              approval: false,
              disease: this.disease,
              done: false,
          );
          await AppointmentDatabase().createAppointment(appointment);
          setState(() {
            loading = false;
          });
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  elevation: 3,
                  title: Text('Appointment Created!'),
                  content: Text('You have created an appointment on ${appointment.dateTime.day}/${appointment.dateTime.month}/${appointment.dateTime.year} at ${appointment.dateTime.hour}:${appointment.dateTime.minute} of ${doctor.name}. Thank you.'),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
