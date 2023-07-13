import 'dart:io';

import 'package:dicoding_restaurant/common/state_restaurant.dart';
import 'package:dicoding_restaurant/data/api/api_services.dart';
import 'package:dicoding_restaurant/data/model/restaurant_list.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantListNotifier extends StateNotifier<RestaurantState> {
  ApiService apiService = ApiService();

  RestaurantListNotifier({required this.apiService})
      : super(RestaurantState.nothing) {
    allRestaurantList();
  }

  late RestaurantList _restaurantResult;

  String _message = '';

  String get message => _message;

  RestaurantList get result => _restaurantResult;

  Future<dynamic> allRestaurantList() async {
    try {
      state = RestaurantState.loading;
      // final restaurant = await ref.watch(listProvider).fullRestaurantList();
      final restaurant = await apiService.fullRestaurantList();
      if (restaurant.restaurants.isEmpty) {
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
}

final restaurantListFullProvider =
    StateNotifierProvider<RestaurantListNotifier, RestaurantState>(
        (ref) => RestaurantListNotifier(apiService: ApiService()));
