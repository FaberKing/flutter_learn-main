import 'package:flutter_restaurant/data/api/api_services.dart';
import 'package:flutter_restaurant/data/model/restaurant_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final searchRestaurantProvider =
    FutureProvider.family<RestaurantSearch, String>((ref, value) async {
  final restaurant = ref.watch(listProvider);

  return restaurant.fullRestaurantSearch(value);
});
