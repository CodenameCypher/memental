import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memental/model/hospitals.dart';

class HospitalDatabase{
  // collection/database reference
  final CollectionReference<Object?> hospitalDatabase = FirebaseFirestore.instance.collection('hospitals');

  Stream<List<Hospital>> get hospitals{
    return hospitalDatabase.snapshots().map(_hospitalConverter);
  }

  List<Hospital> _hospitalConverter(QuerySnapshot s){
    return s.docs.map((e){
      return Hospital(uid: e.id, hospital_name: e.get('hospital_name') ?? '', location: e.get('location') ?? '', number: e.get('number') ?? '', fare: e.get('fare') ?? '', availability: e.get('availability') ?? '');
    }).toList();
  }
}