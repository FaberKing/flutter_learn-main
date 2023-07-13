import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_provider/data/model/article.dart';

// http://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=cad854e8656148779fcaca82ea1ce74d

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = 'cad854e8656148779fcaca82ea1ce74d';
  static const String _category = 'business';
  static const String _country = 'id';

  Future<ArticlesResult> topHeadlines() async {
    final response = await http.get(
      Uri.parse(
          "http://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=cad854e8656148779fcaca82ea1ce74d"),
    );
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to load to Headlines');
    }
  }
}
