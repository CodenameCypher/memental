import 'package:flutter/material.dart';
import 'package:memental/model/user.dart';
import 'package:memental/screens/doctors/doctors_card.dart';
import 'package:memental/shared/loading.dart';
import 'package:provider/provider.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    final List<UserModel> doctors = Provider.of<List<UserModel>>(context);

    return doctors.length == 0? LoadingScreen() : ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index){
        if(doctors[index].isActivated) {
          return DoctorsCard(doctor: doctors[index]);
        }
        else{
          return SizedBox(height: 0,);
        }
      },
    );
  }
}
