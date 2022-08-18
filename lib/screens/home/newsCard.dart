import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:flip_card/flip_card.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
      padding: EdgeInsets.fromLTRB(6.0, 12.0, 6.0, 12.0),
      child: FlipCard(
        direction: FlipDirection.VERTICAL,
        front: ListTile(
          leading: Image.network(article.urlToImage ?? 'https://thumbs.dreamstime.com/b/news-newspapers-folded-stacked-word-wooden-block-puzzle-dice-concept-newspaper-media-press-release-42301371.jpg'),
          title: Text(article.title ?? ''),
          subtitle: Text(
              "- ${article.author ?? ''}\nPublished: ${DateTime.parse(article.publishedAt ?? DateTime.now().toString()).day}/${DateTime.parse(article.publishedAt ?? DateTime.now().toString()).month}/${DateTime.parse(article.publishedAt ?? DateTime.now().toString()).year} at ${DateTime.parse(article.publishedAt ?? DateTime.now().toString()).hour}:${DateTime.parse(article.publishedAt ?? DateTime.now().toString()).minute}",
            style: TextStyle(
              height: 1.7
            ),
          ),
        ),
        back: ListTile(
          title: Text(
              article.description ?? '',
            style: TextStyle(
              height: 1.1
            ),
          ),
          subtitle: IconButton(
            icon: Icon(Icons.link),
            onPressed: () async{
              await launch(article.url ?? 'www.google.com');
            },
          ),
        ),
      ),
    );
  }
}
