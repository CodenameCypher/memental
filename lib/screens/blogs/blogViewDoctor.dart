import 'package:flutter/material.dart';
import 'package:memental/model/blog.dart';
import 'package:memental/screens/blogs/blogListView.dart';
import 'package:memental/services/blogDatabase.dart';
import 'package:provider/provider.dart';

class BlogViewDoctor extends StatelessWidget {
  const BlogViewDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Blog>>.value(
      value: BlogDatabase().updatedBlogs,
      initialData: [],
      child: BlogListView(),
    );
  }
}
