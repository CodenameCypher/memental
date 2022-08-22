import 'package:flutter/material.dart';
import 'package:memental/model/blog.dart';
import 'package:memental/model/suggestion.dart';
import 'package:memental/services/suggestionDatabase.dart';
import 'package:memental/screens/suggestions/suggestionList.dart';
import 'package:provider/provider.dart';

class SuggestionView extends StatelessWidget {
  const SuggestionView({Key? key}) : super(key: key);

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
          'Suggestions',
          style: TextStyle(
            fontFamily: 'Formal',
            color: Colors.green[900],
          ),
        ),
        elevation: 2,
      ),
      body: StreamProvider<List<Suggestion>>.value(
        value: SuggestionDatabase().updatedSuggestions,
        initialData: [],
        child: SuggestionListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/addSuggestion');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[700],
        splashColor: Colors.greenAccent,
      ),
    );
  }
}
