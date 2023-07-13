import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:news_provider/common/styles.dart';
import 'package:news_provider/data/api/api_services.dart';
import 'package:news_provider/provider/news_provider.dart';
import 'package:news_provider/provider/schedulling_provider.dart';
import 'package:news_provider/ui/article_detail_page.dart';
import 'package:news_provider/ui/article_list_page.dart';
import 'package:news_provider/ui/bookmarks_page.dart';
import 'package:news_provider/ui/settings_page.dart';
import 'package:news_provider/utils/notification_helper.dart';
import 'package:provider/provider.dart';

import '../widgets/platform_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Headline';

  // final List<Widget> _listWidget = const [
  //   ArticleListPage(),
  //   SettingsPage(),
  // ];

  final List<Widget> _listWidget = [
    // ChangeNotifierProvider<NewsProvider>(
    //   create: (context) => NewsProvider(apiService: ApiService()),
    //   child: const ArticleListPage(),
    // ),
    // // const SettingsPage(),
    // ChangeNotifierProvider<SchedulingProvider>(
    //   create: (context) => SchedulingProvider(),
    //   child: const SettingsPage(),
    // ),
    const ArticleListPage(),
    const BookmarksPage(),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
      label: _headlineText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS
          ? CupertinoIcons.bookmark
          : Icons.collections_bookmark),
      label: BookmarksPage.bookmarksTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: SettingsPage.settingsTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(ArticlesDetailPage.routeName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
        activeColor: secondaryColor,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }
}


// Widget _buildArticleItem(BuildContext context, Article article) {
//   return Material(
//     child: ListTile(
//       onTap: () {
//         Navigator.pushNamed(context, ArticlesDetailPage.routeName,
//             arguments: article);
//       },
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       leading: Hero(
//         tag: article.urlToImage,
//         child: Image.network(
//           article.urlToImage,
//           width: 100,
//         ),
//       ),
//       title: Text(article.title),
//       subtitle: Text(article.author),
//     ),
//   );
// }
