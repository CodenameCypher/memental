import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/user.dart';
import 'package:memental/services/database.dart';
import 'package:memental/shared/loading.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String email = "";
  String password = "";
  String number = '';
  String age = '';

  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as UserModel;


    return loading? LoadingScreen() : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        leading: BackButton(
          color: Colors.green[900],
        ),
        backgroundColor: Colors.greenAccent[400],
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Formal',
            color: Colors.green[900],
          ),
        ),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            tooltip: 'Logout',
            icon: Icon(
              Icons.logout,
              color: Colors.green[900],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.greenAccent[400],
                radius: 20,
                child: Icon(
                    Icons.supervised_user_circle_outlined,
                  size: 20,
                  color: Colors.green[900],
                ),
              ),
              SizedBox(height: 10,),
              Text(
                  args.name,
                style: TextStyle(
                  fontFamily: 'Formal',
                  fontSize: 20
                ),
              ),
              SizedBox(height: 6,),
              Text(
                  args.email,
                style: TextStyle(
                    fontFamily: 'Formal',
                    fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Divider(),
              TextFormField(
                decoration: InputDecoration(
                  hintText: args.name,
                  labelText: "Name",
                  prefixIcon: Icon(
                    Icons.drive_file_rename_outline_outlined,
                    color: Colors.green[900],
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                  ),
                ),
                onChanged: (v){
                  setState(() {
                    this.name = v;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: args.email,
                    labelText: "Email",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.green[900],
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                  ),
                onChanged: (v){
                  setState(() {
                    this.email = v;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.password_outlined,
                      color: Colors.green[900],
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                  ),
                onChanged: (v){
                  setState(() {
                    this.password = v;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                readOnly: true,
                  decoration: InputDecoration(
                    hintText: args.role,
                    labelText: "Account Type",
                    prefixIcon: Icon(
                      Icons.merge_type_outlined,
                      color: Colors.green[900],
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                  ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                validator: (val) => val!.length < 11 && val.length > 0 ? 'Phone numbers should be 11 digits long' : null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: args.number,
                  labelText: "Phone Number",
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.green[900],
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                  ),
                ),
                onChanged: (v){
                  setState(() {
                    this.number = v;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: args.age,
                  labelText: "Age",
                  prefixIcon: Icon(
                    Icons.access_time_outlined,
                    color: Colors.green[900],
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                  ),
                ),
                onChanged: (v){
                  setState(() {
                    this.age = v;
                  });
                },
              ),
            ],
          ),
        )
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            loading = true;
          });
          if(_formKey.currentState!.validate()){
            await FirebaseAuth.instance.signOut();
            await FirebaseAuth.instance.signInWithEmailAndPassword(email: args.email, password: args.password);
            await FirebaseAuth.instance.currentUser!.updateEmail(this.email);
            await FirebaseAuth.instance.currentUser!.updatePassword(this.password);
            await DatabaseService().updateUserData(
                args.uid,
                this.password,
                this.name == "" || this.name == null ? args.name : this.name,
                args.role,
                this.number == "" || this.number == null ? args.number : this.number,
                this.age == "" || this.age == null ? args.age : this.age,
                args.speciality,
                this.email == "" || this.email == null ? args.email : this.email,
                args.isActivated
            );
            UserModel um = await DatabaseService().getUserData(args.uid.toString()); // updating and getting new user details
            Navigator.pushReplacementNamed(context, '/profile',arguments: um); // pushing replacement for the profile route for new details
          }
          setState(() {
            loading = false;
          });
        },
        tooltip: "Update Profile",
        backgroundColor: Colors.green[700],
        splashColor: Colors.greenAccent,
        child: Icon(
          color: Colors.white,
            Icons.update
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}

