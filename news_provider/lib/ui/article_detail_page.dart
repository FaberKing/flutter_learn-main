import 'package:flutter/material.dart';
import 'package:news_provider/common/navigation.dart';
import 'package:news_provider/data/model/article.dart';
import 'package:news_provider/ui/article_web_view.dart';

class ArticlesDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Article article;

  const ArticlesDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero(
            //   tag: article.urlToImage ?? '',
            //   child: Image.network(article.urlToImage ?? ''),
            // ),
            Hero(
                tag: article.urlToImage ?? article.title,
                child: article.urlToImage == null
                    ? const Icon(Icons.error)
                    : Image.network(
                        article.urlToImage ?? '',
                        width: 100,
                      )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.description ?? '',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.headline6,
                    // style: const TextStyle(
                    //   color: Colors.black,
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 24,
                    // ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    'Date: ${article.publishedAt ?? ""}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Author: ${article.author ?? ""}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    article.content ?? "",
                    style: Theme.of(context).textTheme.bodyText1,
                    // style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigation.intentWithData(
                          ArticleWebView.routeName, article.url);
                      // Navigator.pushNamed(context, ArticleWebView.routeName,
                      //     arguments: article.url);
                    },
                    child: const Text('Read More'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
