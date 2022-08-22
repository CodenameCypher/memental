import 'package:flutter/material.dart';
import 'package:memental/model/blog.dart';
import 'package:memental/screens/blogs/blogCard.dart';
import 'package:memental/shared/loading.dart';
import 'package:provider/provider.dart';

class BlogListView extends StatefulWidget {
  const BlogListView({Key? key}) : super(key: key);

  @override
  State<BlogListView> createState() => _BlogListViewState();
}

class _BlogListViewState extends State<BlogListView> {



  @override
  Widget build(BuildContext context) {
    final List<Blog> blogs = Provider.of<List<Blog>>(context);
    return blogs.length == 0? LoadingScreen() : ListView.builder(
        itemCount: blogs.length,
      itemBuilder: (context, index){
        return BlogCard(blog: blogs[index]);
      },
    );
  }
}
