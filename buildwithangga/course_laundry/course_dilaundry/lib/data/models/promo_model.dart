import 'package:course_dilaundry/data/models/shop_model.dart';
import 'dart:convert';

class PromoModel {
  int id;
  String image;
  int shopId;
  double oldPrice;
  double newPrice;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  ShopModel shop;

  PromoModel({
    required this.id,
    required this.image,
    required this.shopId,
    required this.oldPrice,
    required this.newPrice,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.shop,
  });

  PromoModel copyWith({
    int? id,
    String? image,
    int? shopId,
    double? oldPrice,
    double? newPrice,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    ShopModel? shop,
  }) =>
      PromoModel(
        id: id ?? this.id,
        image: image ?? this.image,
        shopId: shopId ?? this.shopId,
        oldPrice: oldPrice ?? this.oldPrice,
        newPrice: newPrice ?? this.newPrice,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        shop: shop ?? this.shop,
      );

  factory PromoModel.fromRawJson(String str) =>
      PromoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PromoModel.fromJson(Map<String, dynamic> json) => PromoModel(
        id: json["id"],
        image: json["image"],
        shopId: json["shop_id"],
        oldPrice: json["old_price"]?.toDouble(),
        newPrice: json["new_price"]?.toDouble(),
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]).toLocal(),
        updatedAt: DateTime.parse(json["updated_at"]).toLocal(),
        shop: ShopModel.fromJson(json["shop"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "shop_id": shopId,
        "old_price": oldPrice,
        "new_price": newPrice,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "shop": shop.toJson(),
      };
}
