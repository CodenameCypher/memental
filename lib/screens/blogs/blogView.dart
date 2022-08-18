import 'package:flutter/material.dart';
import 'package:memental/model/blog.dart';
import 'package:memental/screens/blogs/blogListView.dart';
import 'package:memental/services/blogDatabase.dart';
import 'package:provider/provider.dart';

class BlogView extends StatelessWidget {
  const BlogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.green[900]
        ),
        backgroundColor: Colors.greenAccent[400],
        title: Text(
          'Blogs',
          style: TextStyle(
            fontFamily: 'Formal',
            color: Colors.green[900],
          ),
        ),
        elevation: 2,
      ),
      body: StreamProvider<List<Blog>>.value(
        value: BlogDatabase().updatedBlogs,
        initialData: [],
        child: BlogListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/addBlog');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[700],
        splashColor: Colors.greenAccent,
      ),
    );
  }
}
