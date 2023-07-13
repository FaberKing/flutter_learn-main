import 'package:flutter/material.dart';
import 'package:news_app/common/styles.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/ui/article_detail_page.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  const CardArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
            tag: article.urlToImage ?? article.title,
            child: article.urlToImage == null
                ? const Icon(Icons.error)
                : Image.network(
                    article.urlToImage ?? '',
                    width: 100,
                  )),
        title: Text(
          article.title,
        ),
        subtitle: Text(article.author ?? ""),
        onTap: () => Navigator.pushNamed(
          context,
          ArticlesDetailPage.routeName,
          arguments: article,
        ),
      ),
    );
  }
}
