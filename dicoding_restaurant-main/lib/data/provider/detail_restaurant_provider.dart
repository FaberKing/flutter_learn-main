import 'dart:async';
import 'dart:io';

import 'package:dicoding_restaurant/data/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncRestaurantDetailNotifier
    extends AutoDisposeFamilyAsyncNotifier<dynamic, String> {
  ApiService apiService = ApiService();

  Future<dynamic> _getRestaurantDetail(id) async {
    try {
      final restaurant = await apiService.fullRestaurantDetail(id);
      if (restaurant.restaurant.id.isEmpty) {
        return 'No Data Available';
      } else {
        return restaurant;
      }
    } on SocketException catch (_) {
      return 'No Internet Connection';
    } catch (e) {
      return 'error ===>> $e';
    }
  }

  @override
  FutureOr<dynamic> build(String arg) async {
    return _getRestaurantDetail(arg);
  }

  Future<void> addReview(BuildContext context, Map answer, String id) async {
    try {
      state = const AsyncValue.loading();
      final review = await apiService.addReviewRestaurant(answer);
      state = await AsyncValue.guard(() async {
        await review;

        return _getRestaurantDetail(id);
      }).whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Menambah Review'))));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal Menambah Review : $e')));
    }
  }
}

final asyncRestaurantDetailProvider = AsyncNotifierProvider.autoDispose
    .family<AsyncRestaurantDetailNotifier, dynamic, String>(() {
  return AsyncRestaurantDetailNotifier();
});
