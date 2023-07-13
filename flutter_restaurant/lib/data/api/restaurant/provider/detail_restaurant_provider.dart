import 'package:flutter_restaurant/data/api/api_services.dart';
import 'package:flutter_restaurant/data/model/restaurant_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final detailRestaurantProvider =
    FutureProvider.family<RestaurantDetail, String>((ref, id) async {
  final restaurant = ref.watch(listProvider);

  return restaurant.fullRestaurantDetail(id);
});
