import 'dart:io';

import 'package:dicoding_restaurant/common/state_restaurant.dart';
import 'package:dicoding_restaurant/data/api/api_services.dart';

import 'package:dicoding_restaurant/data/model/restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailNotifier extends StateNotifier<RestaurantState> {
  ApiService apiService = ApiService();

  RestaurantDetailNotifier(String id, {required this.apiService})
      : super(RestaurantState.nothing) {
    allRestaurantDetail(id);
  }

  late RestaurantDetail _restaurantResult;

  String _message = '';

  String get message => _message;

  RestaurantDetail get result => _restaurantResult;

  Future<dynamic> allRestaurantDetail(String id) async {
    try {
      state = RestaurantState.loading;

      final restaurant = await apiService.fullRestaurantDetail(id);
      if (restaurant.restaurant.toString().isEmpty) {
        state = RestaurantState.noData;
        return _message = 'Empty Data';
      } else {
        state = RestaurantState.hasData;
        return _restaurantResult = restaurant;
      }
    } on SocketException catch (_) {
      state = RestaurantState.error;
      return _message = 'No Internet Connection';
    } catch (e) {
      state = RestaurantState.error;
      return _message = 'Error ---> $e';
    }
  }

  Future<void> entryNewReview(
      Map answer, BuildContext context, String id) async {
    try {
      await apiService.addReviewRestaurant(answer);
      allRestaurantDetail(id);
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Berhasil'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Ada kendala, Silahkan coba kembali'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

final restaurantDetailProvider = StateNotifierProvider.family<
    RestaurantDetailNotifier, RestaurantState, String>(
  (ref, id) => RestaurantDetailNotifier(apiService: ApiService(), id),
);
