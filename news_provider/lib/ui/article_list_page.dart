import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_provider/provider/news_provider.dart';
import 'package:news_provider/utils/result_state.dart';
import 'package:news_provider/widgets/card_article.dart';
import 'package:news_provider/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

// class ArticleListPage extends StatefulWidget {
//   static const routeName = '/article_list_page';

//   const ArticleListPage({super.key});

//   @override
//   State<ArticleListPage> createState() => _ArticleListPageState();
// }

// class _ArticleListPageState extends State<ArticleListPage> {
//   late Future<ArticlesResult> _article;

//   @override
//   void initState() {
//     super.initState();
//     _article = ApiService().topHeadlines();
//   }

//   Widget _buildList(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           ElevatedButton(
//             child: Text("Refresh Data"),
//             onPressed: () {
//               setState(() {
//                 _article = ApiService().topHeadlines();
//               });
//             },
//           ),
//           FutureBuilder(
//             future: _article,
//             builder: (context, AsyncSnapshot<ArticlesResult> snapshot) {
//               var state = snapshot.connectionState;
//               if (state != ConnectionState.done) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else {
//                 if (snapshot.hasData) {
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: snapshot.data?.articles.length,
//                     itemBuilder: (context, index) {
//                       var article = snapshot.data?.articles[index];
//                       return CardArticle(article: article!);
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Material(
//                       child: Text(snapshot.error.toString()),
//                     ),
//                   );
//                 } else {
//                   return const Material(
//                     child: Text('ds'),
//                   );
//                 }
//               }
//               // return ListView.builder(
//               //   itemCount: articles.length,
//               //   itemBuilder: (context, index) {
//               //     return _buildArticleItem(context, articles[index]);
//               //   },
//               // );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildArticleItem(BuildContext context, Article article) {
//   //   return Material(
//   //     child: ListTile(
//   //       onTap: () {
//   //         Navigator.pushNamed(context, ArticlesDetailPage.routeName,
//   //             arguments: article);
//   //       },
//   //       contentPadding:
//   //           const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//   //       leading: Hero(
//   //         tag: article.urlToImage,
//   //         child: Image.network(
//   //           article.urlToImage,
//   //           width: 100,
//   //         ),
//   //       ),
//   //       title: Text(article.title),
//   //       subtitle: Text(article.author),
//   //     ),
//   //   );
//   // }

//   Widget _buildAndroid(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('News App'),
//       ),
//       body: _buildList(context),
//     );
//   }

//   Widget _buildIos(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text('News App'),
//         transitionBetweenRoutes: false,
//       ),
//       child: _buildList(context),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
//   }
// }

class ArticleListPage extends StatelessWidget {
  static const routeName = '/article_list_page';
  const ArticleListPage({super.key});

  Widget _buildList() {
    return Consumer<NewsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.articles.length,
            itemBuilder: (context, index) {
              var article = state.result.articles[index];
              return CardArticle(article: article);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
