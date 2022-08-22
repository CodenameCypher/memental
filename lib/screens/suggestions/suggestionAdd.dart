import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/blog.dart';
import 'package:memental/model/suggestion.dart';
import 'package:memental/services/blogDatabase.dart';
import 'package:memental/services/suggestionDatabase.dart';
import 'package:memental/shared/loading.dart';

class AddSuggestion extends StatefulWidget {
  const AddSuggestion({Key? key}) : super(key: key);

  @override
  State<AddSuggestion> createState() => _AddSuggestionState();
}

class _AddSuggestionState extends State<AddSuggestion> {
  String name = '';
  String type = '';
  String genre = '';
  String duration = '';
  String posterURL = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? LoadingScreen() : Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        leading: BackButton(
          color: Colors.green[900],
        ),
        backgroundColor: Colors.greenAccent[400],
        title: Text(
          'Add new item',
          style: TextStyle(
            fontFamily: 'Formal',
            fontSize: 15,
            color: Colors.green[900],
          ),
        ),
        elevation: 2,
      ),

      body: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(
                  Icons.title,
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
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Type",
                prefixIcon: Icon(
                  Icons.category_outlined,
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
                  this.type = v;
                });
              },
            ),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Genre",
                prefixIcon: Icon(
                  Icons.emergency_recording_outlined,
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
                  this.genre = v;
                });
              },
            ),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.number,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Average Duration (mins)",
                prefixIcon: Icon(
                  Icons.timer,
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
                  this.duration = v;
                });
              },
            ),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.number,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Poster URL",
                prefixIcon: Icon(
                  Icons.timer,
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
                  this.posterURL = v;
                });
              },
            ),
            SizedBox(height: 10,),
            Divider(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          setState(() {
            this.loading = true;
          });
          if(this.name != '' && this.type != '' && this.genre != '' && this.duration != ''){
            Suggestion b = Suggestion(
                name: this.name,
                type: this.type,
                genre: this.genre,
                duration: this.duration,
                urlPoster: this.posterURL == '' ? 'https://www.khacha.com.bd/wp-content/uploads/2022/02/suggestion-box-improve-business.jpg' : this.posterURL,
            );
            await SuggestionDatabase().createItem(b);
            setState(() {
              this.loading = false;
            });
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    elevation: 3,
                    title: Text('Suggestion Item Added'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text('OK')
                      )
                    ],
                  );
                }
            );
          }
          else{
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    elevation: 3,
                    content: Text('Suggestion Item name, type, genre or duration can\'t be empty!'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK')
                      )
                    ],
                  );
                }
            );
            setState(() {
              this.loading = false;
            });
          }
        },
        child: Icon(Icons.save_outlined),
        backgroundColor: Colors.green[700],
        splashColor: Colors.greenAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
