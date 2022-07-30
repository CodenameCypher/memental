import 'package:flutter/material.dart';
import 'package:memental/services/auth.dart';


class Home extends StatelessWidget {

  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[400],
        title: Text(
            'Memental',
          style: TextStyle(
            fontFamily: 'Fancy',
          ),
        ),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.person_rounded,
              color: Colors.green[900],
            ),
          ),
          IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
            icon: Icon(
                Icons.logout_rounded,
              color: Colors.green[900],
            ),
          ),
        ],
      ),
    );
  }
}
