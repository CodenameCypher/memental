import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memental/model/blog.dart';

class BlogCard extends StatefulWidget {
  final Blog blog;

  BlogCard({required this.blog});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          indent: 40,
          endIndent: 40,
            color: Colors.green[300]
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').doc(widget.blog.writer_uid).snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
              if(snapshot.hasData){
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 16,
                      child: Icon(
                          Icons.person,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green[900],
                    ),
                    title: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.requireData.get('name')),
                          Text('Posted on: ${widget.blog.posted.day}/${widget.blog.posted.month}/${widget.blog.posted.year} at ${widget.blog.posted.hour}:${widget.blog.posted.minute}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              widget.blog.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                                fontFamily: 'Formal',
                            ),
                          ),
                          Text(
                              widget.blog.content,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Formal',
                                height: 1.5
                            ),
                          ),
                          Divider(),
                          Text(
                            'Category: ${widget.blog.category}',
                            style: TextStyle(
                              fontSize: 12
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }else{
                return SizedBox(height: 0,);
              }
            }
        )
      ],
    );
  }
}
