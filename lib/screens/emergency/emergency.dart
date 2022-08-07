import 'package:flutter/material.dart';
import 'package:memental/model/hospitals.dart';
import 'package:memental/services/hospitalDatabase.dart';
import 'package:provider/provider.dart';
import 'package:memental/screens/emergency/emergency_list.dart';

class EmergencyHospitals extends StatelessWidget {
  const EmergencyHospitals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Hospital>>.value(
      value: HospitalDatabase().hospitals,
      initialData: [],
      child: EmergencyList(),
    );
  }
}
