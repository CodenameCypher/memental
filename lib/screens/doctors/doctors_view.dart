import 'package:flutter/material.dart';
import 'package:memental/model/user.dart';
import 'package:memental/screens/doctors/doctors_listView.dart';
import 'package:memental/services/database.dart';
import 'package:provider/provider.dart';

class Doctors extends StatelessWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserModel>>.value(
        value: DatabaseService().doctors,
        initialData: [],
      child: DoctorList(),
    );
  }
}
