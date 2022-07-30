import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memental/services/auth.dart';
import 'package:memental/shared/constants.dart';
import 'package:memental/shared/loading.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading ? LoadingScreen() : Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[400],
        title: Text(
            'Memental',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: 'Fancy',
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Log In',
                style: TextStyle(
                  fontFamily: 'Formal',
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (v) => v!.isEmpty? 'Enter your email' : null,
                onChanged: (v){
                  setState(() {
                    this.email = v;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() {
                    this.password = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.green[900],
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        this.loading = true;
                      });
                      dynamic user = _auth.signIn(this.email, this.password);
                      if(user != null){
                        print('Sign in successful. UID: ${user.toString()}');
                      }else{
                        setState(() {
                          this.error = 'Could not sign in. Please try again!';
                          this.loading = false;
                        });
                      }
                    }
                  }
              ),
              TextButton(
                  onPressed: (){
                    widget.toggleView();
                  },
                  child: Text('Register as a new user?')
              ),
              Text(
                this.error,
                style: TextStyle(
                  color: Colors.red[900],
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
