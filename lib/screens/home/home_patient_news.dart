import 'package:flutter/material.dart';
import 'package:memental/screens/home/newsListView.dart';
import 'package:memental/services/newsAPIService.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:provider/provider.dart';

class PatientHomeNews extends StatelessWidget {
  const PatientHomeNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Article>>.value(
        value: newsAPIService().newsToday,
        initialData: [],
      child: NewsList(),
    );
  }
}

