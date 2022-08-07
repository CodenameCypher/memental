import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/user.dart';
import 'package:memental/screens/appointment/appointment_book.dart';
import 'package:memental/screens/home/profile.dart';
import 'package:memental/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:memental/services/auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/profile': (context) => Profile(),
          '/appointment': (context) => AppointmentBooking(),
        },
      ),
    );
  }
}