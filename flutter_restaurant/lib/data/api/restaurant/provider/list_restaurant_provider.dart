import 'dart:async';
import 'dart:io';

import 'package:flutter_restaurant/data/api/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../model/restaurant_list.dart';

final listRestaurantProvider = FutureProvider<dynamic>((ref) async {
  try {
    final restaurant = await ref.watch(listProvider).fullRestaurantList();
    if (restaurant.restaurants.isEmpty) {
      return 'No Data';
    } else {
      return restaurant;
    }
  } catch (e) {
    return 'Error : $e';
  }
  // final restaurant = ref.watch(listProvider);
  // return restaurant.fullRestaurantList();
});
