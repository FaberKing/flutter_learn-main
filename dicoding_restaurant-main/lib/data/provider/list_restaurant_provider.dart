import 'dart:async';
import 'dart:io';

import 'package:dicoding_restaurant/data/api/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final searchProvider = StateProvider((ref) => '');

class AsyncRestaurantNotifier extends AutoDisposeAsyncNotifier<dynamic> {
  ApiService apiService = ApiService();

  Future<dynamic> _getRestaurantList() async {
    final search = ref.watch(searchProvider);

    try {
      if (search.isNotEmpty && search != '') {
        final restaurant = await apiService.fullRestaurantSearch(search);
        if (restaurant.restaurants.isEmpty) {
          return 'No Data Available';
        } else {
          ref.keepAlive();

          return restaurant;
        }
      } else {
        final restaurant = await apiService.fullRestaurantList(http.Client());
        if (restaurant.restaurants.isEmpty) {
          return 'No Data Available';
        } else {
          ref.keepAlive();

          return restaurant;
        }
      }
    } on SocketException catch (_) {
      return 'No Internet Connection';
    } catch (e) {
      return 'error ===>> $e';
    }
  }

  @override
  FutureOr<dynamic> build() async {
    return _getRestaurantList();
  }
}

final asyncRestaurantProvider =
    AsyncNotifierProvider.autoDispose<AsyncRestaurantNotifier, dynamic>(
  () {
    return AsyncRestaurantNotifier();
  },
);
