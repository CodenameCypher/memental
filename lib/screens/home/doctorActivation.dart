import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorActivation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your account is not activated yet. Please log out and try again in a few moment!',
              style: TextStyle(
                fontFamily: 'Formal',
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            RaisedButton.icon(
              icon: Icon(
                Icons.logout,
                color: Colors.greenAccent[100],
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              label: Text(
                  'Log Out',
                style: TextStyle(
                  color: Colors.greenAccent[100]
                ),
              ),
              color: Colors.green[900],
            )
          ],
        ),
      ),
    );
  }
}
