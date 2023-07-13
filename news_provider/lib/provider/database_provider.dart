import 'package:flutter/material.dart';
import 'package:news_provider/data/db/database_helper.dart';

import 'package:news_provider/data/model/article.dart';
import 'package:news_provider/utils/result_state.dart';

class DatabaseNotifier extends ChangeNotifier {
  final DataBaseHelper dataBaseHelper;

  DatabaseNotifier({required this.dataBaseHelper}) {
    _getBookmarks();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Article> _bookmarks = [];
  List<Article> get bookmarks => _bookmarks;

  void _getBookmarks() async {
    _bookmarks = await dataBaseHelper.getBookmarks();
    if (_bookmarks.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addBookmark(Article article) async {
    try {
      await dataBaseHelper.insertBookmark(article);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String url) async {
    final bookmarkedArticle = await dataBaseHelper.getBookmarkByUrl(url);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeBookmark(String url) async {
    try {
      await dataBaseHelper.removeBookmark(url);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
