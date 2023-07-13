import 'package:flutter/material.dart';
import 'package:news_provider/common/navigation.dart';
import 'package:news_provider/common/styles.dart';
import 'package:news_provider/data/model/article.dart';
import 'package:news_provider/provider/database_provider.dart';
import 'package:news_provider/ui/article_detail_page.dart';
import 'package:provider/provider.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  const CardArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseNotifier>(
      builder: (context, value, child) {
        return FutureBuilder<bool>(
          future: value.isBookmarked(article.url),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
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
                trailing: isBookmarked
                    ? IconButton(
                        onPressed: () => value.removeBookmark(article.url),
                        icon: const Icon(Icons.bookmark),
                        color: Theme.of(context).accentColor,
                      )
                    : IconButton(
                        onPressed: () => value.addBookmark(article),
                        icon: const Icon(
                          Icons.bookmark_border,
                        ),
                        color: Theme.of(context).accentColor),
                subtitle: Text(article.author ?? ""),
                onTap: () => Navigation.intentWithData(
                    ArticlesDetailPage.routeName, article),
                // Navigator.pushNamed(
                //   context,
                //   ArticlesDetailPage.routeName,
                //   arguments: article,
                // ),
              ),
            );
          },
        );
      },
    );
  }
}
