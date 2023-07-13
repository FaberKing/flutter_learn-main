import 'dart:io';

import 'package:dicoding_restaurant/common/state_restaurant.dart';
import 'package:dicoding_restaurant/data/api/api_services.dart';
import 'package:dicoding_restaurant/data/model/restaurant_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRestaurantProvider =
    FutureProvider.family<RestaurantSearch, String>((ref, value) async {
  final restaurant = ref.watch(listProvider);

  return restaurant.fullRestaurantSearch(value);
});

class RestaurantSearchListNotifier extends StateNotifier<RestaurantState> {
  ApiService apiService = ApiService();

  RestaurantSearchListNotifier(String value, {required this.apiService})
      : super(RestaurantState.nothing) {
    allRestaurantList(value);
  }

  late RestaurantSearch _restaurantResult;

  String _message = '';

  String get message => _message;

  RestaurantSearch get result => _restaurantResult;

  Future<dynamic> allRestaurantList(id) async {
    try {
      state = RestaurantState.loading;
      // final restaurant = await ref.watch(listProvider).fullRestaurantList();
      final restaurant = await apiService.fullRestaurantSearch(id);
      if (restaurant.restaurants.isEmpty) {
        state = RestaurantState.noData;
        return _message = 'Tidak dapat ditemukan';
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

final restaurantSearchListProvider = StateNotifierProvider.family<
        RestaurantSearchListNotifier, RestaurantState, String>(
    (ref, id) => RestaurantSearchListNotifier(apiService: ApiService(), id));
