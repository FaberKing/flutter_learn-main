import 'dart:convert';
import 'dart:io';

import 'package:flutter_restaurant/data/model/restaurant_detail.dart';
import 'package:flutter_restaurant/data/model/restaurant_list.dart';
import 'package:flutter_restaurant/data/model/restaurant_search.dart';
import 'package:flutter_restaurant/data/model/review.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static const String _getList = "/list";
  static const String _getDetail = "/detail";
  static const String _getSearch = "/search";
  static const String _getReview = "/review";

  Future<RestaurantList> fullRestaurantList() async {
    final response = await http.get(
      Uri.parse("$_baseUrl$_getList"),
    );
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static String retrivePicture(String id, String size) {
    return "$_baseUrl/images/$size/$id";
  }

  Future<RestaurantDetail> fullRestaurantDetail(String id) async {
    // final response = await http.get(
    //   Uri.parse("$_baseUrl$_getDetail/$id"),
    // );
    // if (response.statusCode == 200) {
    //   return RestaurantDetail.fromJson(
    //     jsonDecode(response.body),
    //   );
    // } else {
    //   throw Exception('Failed to load data');
    // }

    // try {
    final response = await http.get(
      Uri.parse("$_baseUrl$_getDetail/$id"),
    );
    switch (response.statusCode) {
      case 200:
        return RestaurantDetail.fromJson(jsonDecode(response.body));

      default:
        throw Exception(response.reasonPhrase);
    }
    // } on SocketException catch (e) {
    //   return Exception(e);
    // }
  }

  Future<RestaurantSearch> fullRestaurantSearch(String value) async {
    final response = await http.get(
      Uri.parse("$_baseUrl$_getSearch?q=$value"),
    );
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantReview> fullRestaurantReview() async {
    final response = await http.get(
      Uri.parse("$_baseUrl$_getReview"),
    );
    if (response.statusCode == 200) {
      return RestaurantReview.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }
}

final listProvider = Provider<ApiService>((ref) {
  return ApiService();
});
