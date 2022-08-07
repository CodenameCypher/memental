import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/user.dart';
import 'package:memental/screens/authenticate/authentication.dart';
import 'package:provider/provider.dart';
import 'package:memental/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel?>(context);
    // listen to auth changes and show home/authenticate
    return user != null ? Home(userModel: user) : Authenticate();
  }
}
