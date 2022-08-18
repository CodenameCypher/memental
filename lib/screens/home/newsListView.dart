import 'package:flutter/material.dart';
import 'package:memental/screens/home/newsCard.dart';
import 'package:memental/shared/loading.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:provider/provider.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    List<Article> articles = Provider.of<List<Article>>(context);

    return articles.length == 0 ? LoadingScreen() : ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index){
        return NewsCard(article: articles[index]);
      },
    );
  }
}
