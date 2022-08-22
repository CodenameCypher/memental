import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memental/model/suggestion.dart';

class SuggestionDatabase{
  final CollectionReference database = FirebaseFirestore.instance.collection('suggestions');

  Future createItem(Suggestion suggestion) async{
    String id = await database.doc().id;
    await database.doc(id).set({
      'name' : suggestion.name,
      'type' : suggestion.type,
      'genre' : suggestion.genre,
      'duration' : suggestion.duration,
      'urlPoster' : suggestion.urlPoster
    });
  }

  Stream<List<Suggestion>> get updatedSuggestions{
    return database.snapshots().map(_suggestionObjectFromFirebase);
  }

  List<Suggestion> _suggestionObjectFromFirebase(QuerySnapshot s){
    return s.docs.map((e){
      Suggestion s = Suggestion(name: e.get('name'), type: e.get('type'), genre: e.get('genre'), duration: e.get('duration'), urlPoster: e.get('urlPoster'));
      s.uid = e.id;
      return s;
    }).toList();
  }
}