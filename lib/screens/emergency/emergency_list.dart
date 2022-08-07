import 'package:flutter/material.dart';
import 'package:memental/model/hospitals.dart';
import 'package:memental/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:memental/screens/emergency/emergency_card.dart';

class EmergencyList extends StatefulWidget {
  const EmergencyList({Key? key}) : super(key: key);

  @override
  State<EmergencyList> createState() => _EmergencyListState();
}

class _EmergencyListState extends State<EmergencyList> {
  @override
  Widget build(BuildContext context) {
    final hospitalList = Provider.of<List<Hospital>>(context);

    return hospitalList.length == 0? LoadingScreen() :ListView.builder(
        itemCount: hospitalList.length,
      itemBuilder: (context, index){
          return EmergencyCard(hospitalObject: hospitalList[index]);
      },
    );
  }
}
