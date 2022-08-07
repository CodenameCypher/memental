import 'package:flutter/material.dart';
import 'package:memental/model/user.dart';
import 'package:memental/services/auth.dart';
import 'package:memental/shared/constants.dart';
import 'package:memental/shared/loading.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';
  String role = '';
  String number = '';
  String age = '';
  String speciality = '';
  String error = '';
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading? LoadingScreen() : Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Registration',
                  style: TextStyle(
                    fontFamily: 'Formal',
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (v) => v!.isEmpty? 'Enter your name' : null,
                  onChanged: (v){
                    setState(() {
                      this.name = v;
                    });
                  },
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
                DropdownButtonFormField(
                  hint: Text('Role'),
                  decoration: textInputDecoration,
                  items: ['Doctor', 'Patient']
                      .map<DropdownMenuItem<String>>((String _value) => DropdownMenuItem<String>(
                      value: _value, // add this property an pass the _value to it
                      child: Text(_value,)
                  )).toList(),
                  onChanged: (val) => setState(() {
                      this.role = val.toString();
                  }),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration.copyWith(hintText: 'Phone Number'),
                  validator: (val) => val!.length < 11 ? 'A Phone Number should be 11 chars long' : null,
                  onChanged: (val) {
                    setState(() {
                      this.number = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: textInputDecoration.copyWith(hintText: 'Age'),
                  validator: (val) => val!.length < 1 ? 'Enter your age' : null,
                  onChanged: (val) {
                    setState(() {
                      this.age = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Medical Speciality'),
                  validator: (val) => this.role != 'Doctor' && val != 'N/A' ? 'This option is only for Doctors, type N/A' : null,
                  onChanged: (val) {
                    setState(() {
                      this.speciality = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.green[900],
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          this.loading = true;
                        });
                        UserModel? user = null;
                        if(this.role == 'Doctor') {
                           user = await _auth.register(this.email, this.password, this.name, this.role, this.number, this.age, this.speciality, false);
                        }else{
                           user = await _auth.register(this.email, this.password, this.name, this.role, this.number, this.age, this.speciality, true);
                        }
                        if(user == null){
                          setState(() {
                            this.error = 'Registration Failed. Please try again!';
                            this.loading = false;
                          });
                        }
                        else{
                          print('User created with ${user.name} and UID: ${user.uid}');
                        }
                      }
                    }
                ),
                TextButton(
                    onPressed: (){
                      widget.toggleView();
                    },
                    child: Text('Already have an account? Log in!')
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
      ),
    );
  }
}
