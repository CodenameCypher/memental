import 'package:flutter/material.dart';
import 'package:memental/screens/authenticate/register.dart';
import 'package:memental/screens/authenticate/signIn.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showRegister = true;
  void toggleView(){
    setState(() {
      this.showRegister = !this.showRegister;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showRegister? Register(toggleView: toggleView) : SignIn(toggleView: toggleView);
  }
}
