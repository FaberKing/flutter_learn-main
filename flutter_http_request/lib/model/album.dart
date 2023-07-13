import 'package:meta/meta.dart';
import 'dart:convert';

class Album {
  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  final int userId;
  final int id;
  final String title;

  factory Album.fromRawJson(String str) => Album.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
