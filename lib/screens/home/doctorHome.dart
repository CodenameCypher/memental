import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/user.dart';
import 'package:memental/services/auth.dart';
import 'package:memental/services/database.dart';
import 'package:memental/shared/loading.dart';


class DoctorHome extends StatefulWidget {

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  final _auth = AuthService();

  bool loading = false;
  int _currentIndex = 0;

  List<Widget> _widgetList = [
    Text('Hey, its home'),
    Text('Hey, its Doctors'),
    Text('Hey, its Appointments'),
    Text('Hey, its Calendar'),
    Text('Hey, its Emergency'),
  ];

  @override
  Widget build(BuildContext context) {
    return loading? LoadingScreen() : Scaffold(
      backgroundColor: Colors.greenAccent[100],


      appBar: AppBar(
        backgroundColor: Colors.greenAccent[400],
        title: Text(
          'Memental',
          style: TextStyle(
            fontFamily: 'Fancy',
            color: Colors.green[900],
          ),
        ),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () async{
              setState(() {
                loading = true;
              });
              UserModel um = await DatabaseService().getUserData(FirebaseAuth.instance.currentUser!.uid.toString());
              setState(() {
                loading = false;
              });
              Navigator.pushNamed(context, '/profile' , arguments: um);
            },
            tooltip: 'Profile',
            icon: Icon(
              Icons.person_rounded,
              color: Colors.green[900],
            ),
          ),
          IconButton(
            onPressed: () async {
              await _auth.signOut();
            },
            tooltip: 'Logout',
            icon: Icon(
              Icons.logout_rounded,
              color: Colors.green[900],
            ),
          ),
        ],
      ),



      body: Text('Its doctor home'),



      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add_alt),
              label: 'Doctors'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Appointments'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule_outlined),
              label: 'Reminders'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.emergency_outlined),
              label: 'Emergency'
          ),
        ],
        elevation: 25,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green[900],
        showUnselectedLabels: false,
        selectedFontSize: 12,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
