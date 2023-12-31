import 'dart:convert';

import 'package:dicoding_restaurant/data/model/restaurant.dart';

class RestaurantList {
  RestaurantList({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  factory RestaurantList.fromRawJson(String str) =>
      RestaurantList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

// class Restaurant {
//   Restaurant({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.pictureId,
//     required this.city,
//     required this.rating,
//   });

//   final String id;
//   final String name;
//   final String description;
//   final String pictureId;
//   final String city;
//   final double rating;

//   factory Restaurant.fromRawJson(String str) =>
//       Restaurant.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         pictureId: json["pictureId"],
//         city: json["city"],
//         rating: json["rating"]?.toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "description": description,
//         "pictureId": pictureId,
//         "city": city,
//         "rating": rating,
//       };
// }
