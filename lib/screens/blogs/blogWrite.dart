import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/blog.dart';
import 'package:memental/services/blogDatabase.dart';
import 'package:memental/shared/loading.dart';

class NewBlog extends StatefulWidget {
  const NewBlog({Key? key}) : super(key: key);

  @override
  State<NewBlog> createState() => _NewBlogState();
}

class _NewBlogState extends State<NewBlog> {
  String title = '';
  String content = '';
  String category = '';
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
          'What\'s on your mind?',
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
                labelText: "Title",
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
                  this.title = v;
                });
              },
            ),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Category",
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
                  this.category = v;
                });
              },
            ),
            SizedBox(height: 10,),
            Divider(),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Content",
                prefixIcon: Icon(
                  Icons.content_paste_outlined,
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
                  this.content = v;
                });
              },
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          setState(() {
            this.loading = true;
          });
          if(this.title != '' && this.category != '' && this.content != ''){
            Blog b = Blog(
                writer_uid: FirebaseAuth.instance.currentUser!.uid,
                title: title,
                content: content,
                posted: DateTime.now(),
                category: this.category);
            await BlogDatabase().createBlog(b);
            setState(() {
              this.loading = false;
            });
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    elevation: 3,
                    title: Text('Blog Added'),
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
                    content: Text('Blogs title, content or category can\'t be empty!'),
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
