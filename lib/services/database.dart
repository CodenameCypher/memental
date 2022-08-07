import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memental/model/user.dart';

class DatabaseService{

  String uid = "";

  DatabaseService({this.uid = ""});

  // collection/database reference
  final CollectionReference<Object?> userDatabase = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String uid, String password, String name, String role, String number, String age, String speciality, String email, bool isActivated) async{
    return await userDatabase.doc(uid).set(
      {
        'name': name,
        'role': role,
        'email': email,
        'password':password,
        'number': number,
        'age':age,
        'speciality':speciality,
        'isActivated': isActivated,
      }
    );
  }

  Future<UserModel> getUserData(String uid) async{
    DocumentSnapshot s = await userDatabase.doc(uid).get();
    return UserModel(email: s.get('email'), password: s.get('password'), name: s.get('name'), role: s.get('role'), isActivated: s.get('isActivated'),number: s.get('number'), age: s.get('age'), speciality: s.get('speciality'), uid: s.id);
  }

  List<UserModel> _userModelFromFirebase(QuerySnapshot s){
    return s.docs.map((e){
      return UserModel(email: e.get('email') ?? " ", password: "", name: e.get('name') ?? " ", role: e.get('role') ?? " ", isActivated: e.get('isActivated') ?? false, uid: e.get('name') ?? " ", number: e.get('number'), age: e.get('age'), speciality: e.get('speciality'));
    }).toList();
  }


  // get mementalDB stream
  Stream<List<UserModel>> get userData{
    return userDatabase.snapshots().map(_userModelFromFirebase);
  }

  Stream<List<UserModel>> get doctors{
    return userDatabase.snapshots().map(_doctorsFromFirebase);
  }

  List<UserModel> _doctorsFromFirebase(QuerySnapshot s){
    return s.docs.map((e){
      if(e.get('role') == 'Doctor' && e.get('isActivated') == true){
        return UserModel(email: e.get('email') ?? " ", password: e.get('password') ?? " ", name: e.get('name') ?? " ", role: e.get('role') ?? " ", isActivated: e.get('isActivated') ?? false, uid: e.id, number: e.get('number'), age: e.get('age'), speciality: e.get('speciality'));
      }
      else{
        return UserModel(email: "N/A", password: " ", name: "N/A", role: " ", number: " ", age: " ", speciality: " ", isActivated: false, uid: uid);
      }
    }).toList();
  }
}