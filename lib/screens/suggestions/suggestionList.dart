import 'package:flutter/material.dart';
import 'package:memental/model/suggestion.dart';
import 'package:memental/screens/suggestions/suggestionCard.dart';
import 'package:memental/shared/loading.dart';
import 'package:provider/provider.dart';

class SuggestionListView extends StatefulWidget {
  const SuggestionListView({Key? key}) : super(key: key);

  @override
  State<SuggestionListView> createState() => _SuggestionListViewState();
}

class _SuggestionListViewState extends State<SuggestionListView> {



  @override
  Widget build(BuildContext context) {
    final List<Suggestion> suggestions = Provider.of<List<Suggestion>>(context);
    return suggestions.length == 0 ? LoadingScreen() : ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index){
        return SuggestionCard(suggestions: suggestions[index]);
      },
    );
  }
}
