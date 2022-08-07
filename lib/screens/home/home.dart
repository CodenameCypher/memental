import 'package:memental/screens/home/doctorActivation.dart';
import 'package:memental/screens/home/doctorHome.dart';
import 'package:flutter/material.dart';
import 'package:memental/screens/home/patientHome.dart';
import 'package:memental/model/user.dart';

class Home extends StatefulWidget {
  UserModel userModel;
  Home({required this.userModel});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    if(widget.userModel.isActivated){
      return widget.userModel.role == 'Doctor' ? DoctorHome() : PatientHome();
    }
    else{
      return DoctorActivation();
    }
  }
}
