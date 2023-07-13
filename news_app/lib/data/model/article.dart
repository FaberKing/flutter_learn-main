// To parse this JSON data, do
//
//     final articlesResult = articlesResultFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ArticlesResult {
  ArticlesResult({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<Article> articles;

  factory ArticlesResult.fromRawJson(String str) =>
      ArticlesResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticlesResult.fromJson(Map<String, dynamic> json) => ArticlesResult(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from((json["articles"] as List)
            .map((x) => Article.fromJson(x))
            .where((article) =>
                article.author != null ||
                article.urlToImage != null ||
                article.publishedAt != null ||
                article.content != null ||
                article.description != null)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final Source source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  final Id id;
  final Name name;

  factory Source.fromRawJson(String str) => Source.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: idValues.map[json["id"]]!,
        name: nameValues.map[json["name"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "name": nameValues.reverse[name],
      };
}

enum Id { GOOGLE_NEWS }

final idValues = EnumValues({"google-news": Id.GOOGLE_NEWS});

enum Name { GOOGLE_NEWS }

final nameValues = EnumValues({"Google News": Name.GOOGLE_NEWS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

// class ArticlesResult {
//   final String status;
//   final int totalResults;
//   final List<Article> articles;

//   ArticlesResult({
//     required this.status,
//     required this.totalResults,
//     required this.articles,
//   });

//   factory ArticlesResult.fromJson(Map<String, dynamic> json) => ArticlesResult(
//         status: json["status"],
//         totalResults: json["totalResults"],
//         articles: List<Article>.from((json["articles"] as List)
//             .map((x) => Article.fromJson(x))
//             .where((article) =>
//                 article.author != null &&
//                 article.description != null &&
//                 article.urlToImage != null &&
//                 article.publishedAt != null &&
//                 article.content != null)),
//       );
// }

// class Article {
//   String? author;
//   String title;
//   String? description;
//   String url;
//   String? urlToImage;
//   DateTime? publishedAt;
//   String? content;

//   Article({
//     required this.author,
//     required this.title,
//     required this.description,
//     required this.url,
//     required this.urlToImage,
//     required this.publishedAt,
//     required this.content,
//   });

//   factory Article.fromJson(Map<String, dynamic> json) => Article(
//         author: json["author"],
//         title: json["title"],
//         description: json["description"],
//         url: json["url"],
//         urlToImage: json["urlToImage"],
//         publishedAt: DateTime.parse(json["publishedAt"]),
//         content: json["content"],
//       );
// }

// To parse this JSON data, do
//
//     final articlesResult = articlesResultFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// class ArticlesResult {
//   ArticlesResult({
//     required this.status,
//     required this.totalResults,
//     required this.articles,
//   });

//   final String status;
//   final int totalResults;
//   final List<Article> articles;

//   factory ArticlesResult.fromRawJson(String str) =>
//       ArticlesResult.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ArticlesResult.fromJson(Map<String, dynamic> json) => ArticlesResult(
//         status: json["status"],
//         totalResults: json["totalResults"],
//         articles: List<Article>.from(
//             json["articles"].map((x) => Article.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "totalResults": totalResults,
//         "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
//       };
// }

// class Article {
//   Article({
//     required this.source,
//     required this.author,
//     required this.title,
//     required this.description,
//     required this.url,
//     required this.urlToImage,
//     required this.publishedAt,
//     required this.content,
//   });

//   final Source source;
//   final String author;
//   final String title;
//   final dynamic description;
//   final String url;
//   final dynamic urlToImage;
//   final DateTime publishedAt;
//   final dynamic content;

//   factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Article.fromJson(Map<String, dynamic> json) => Article(
//         source: Source.fromJson(json["source"]),
//         author: json["author"],
//         title: json["title"],
//         description: json["description"],
//         url: json["url"],
//         urlToImage: json["urlToImage"],
//         publishedAt: DateTime.parse(json["publishedAt"]),
//         content: json["content"],
//       );

//   Map<String, dynamic> toJson() => {
//         "source": source.toJson(),
//         "author": author,
//         "title": title,
//         "description": description,
//         "url": url,
//         "urlToImage": urlToImage,
//         "publishedAt": publishedAt.toIso8601String(),
//         "content": content,
//       };
// }

// class Source {
//   Source({
//     required this.id,
//     required this.name,
//   });

//   final Id id;
//   final Name name;

//   factory Source.fromRawJson(String str) => Source.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Source.fromJson(Map<String, dynamic> json) => Source(
//         id: idValues.map[json["id"]]!,
//         name: nameValues.map[json["name"]]!,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": idValues.reverse[id],
//         "name": nameValues.reverse[name],
//       };
// }

// enum Id { GOOGLE_NEWS }

// final idValues = EnumValues({"google-news": Id.GOOGLE_NEWS});

// enum Name { GOOGLE_NEWS }

// final nameValues = EnumValues({"Google News": Name.GOOGLE_NEWS});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
