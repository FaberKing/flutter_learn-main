// To parse this JSON data, do
//
//     final tipsModel = tipsModelFromJson(jsonString);

import 'dart:convert';

TipsModel tipsModelFromJson(String str) => TipsModel.fromJson(json.decode(str));

String tipsModelToJson(TipsModel data) => json.encode(data.toJson());

class TipsModel {
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnail;

  TipsModel({
    this.id,
    this.title,
    this.url,
    this.thumbnail,
  });

  TipsModel copyWith({
    int? id,
    String? title,
    String? url,
    String? thumbnail,
  }) =>
      TipsModel(
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        thumbnail: thumbnail ?? this.thumbnail,
      );

  factory TipsModel.fromJson(Map<String, dynamic> json) => TipsModel(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "thumbnail": thumbnail,
      };
}
