import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class newsAPIService{
  final NewsAPI _newsAPI = NewsAPI("44f1bcd779a142c7b77c8e868b5b4e8f");

  Stream<List<Article>> get newsToday{
    return _newsAPI.getEverything(query: 'psychology').asStream();
  }
}