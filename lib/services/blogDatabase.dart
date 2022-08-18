import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memental/model/blog.dart';

class BlogDatabase{
  final CollectionReference database = FirebaseFirestore.instance.collection('blogs');

  Future createBlog(Blog blog) async{
    String id = await database.doc().id;
    await database.doc(id).set({
      'writer_uid' : blog.writer_uid,
      'title' : blog.title,
      'content' : blog.content,
      'posted' : blog.posted,
      'category' : blog.category
    });
  }

  Stream<List<Blog>> get updatedBlogs{
    return database.snapshots().map(_blogObjectFromFirebase);
  }

  List<Blog> _blogObjectFromFirebase(QuerySnapshot s){
    return s.docs.map((e){
      Blog b = Blog(writer_uid: e.get('writer_uid'), title: e.get('title'), content: e.get('content'), posted: e.get('posted').toDate() , category: e.get('category'));
      b.uid = e.id;
      return b;
    }).toList();
  }

}