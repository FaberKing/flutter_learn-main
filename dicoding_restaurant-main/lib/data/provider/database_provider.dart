import 'dart:async';

import 'package:dicoding_restaurant/data/db/database_helper.dart';
import 'package:dicoding_restaurant/data/model/restaurant.dart';
import 'package:dicoding_restaurant/data/provider/check_favorite_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchFavoriteProvider = StateProvider((ref) => '');

class AsyncDatabaseNotifier extends AutoDisposeAsyncNotifier<dynamic> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  Future<dynamic> _getDatabaseTodo() async {
    final search = ref.watch(searchFavoriteProvider);

    try {
      if (search.isNotEmpty && search != '') {
        final restaurant = await databaseHelper.getSearchFavorite(search);
        if (restaurant.isNotEmpty) {
          ref.keepAlive();

          return restaurant;
        } else {
          return 'No Data Available';
        }
      } else {
        final restaurant = await databaseHelper.getFavorites();
        if (restaurant.isNotEmpty) {
          ref.keepAlive();

          return restaurant;
        } else {
          return 'No Data Available';
        }
      }
    } catch (e) {
      return 'error ===>> $e';
    }
  }

  @override
  FutureOr<dynamic> build() async {
    return _getDatabaseTodo();
  }

  Future<void> addFavorites(Restaurant restaurant) async {
    try {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        await databaseHelper
            .insertFavorite(restaurant)
            .then((value) => ref.refresh(checkFavoriteProvider(restaurant.id)));

        return _getDatabaseTodo();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        await databaseHelper
            .removeFavorite(id)
            .then((value) => ref.refresh(checkFavoriteProvider(id)));

        return _getDatabaseTodo();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> isFavorited(String id) async {
    try {
      final favoriteRestaurant = await databaseHelper.getFavoritekById(id);

      return favoriteRestaurant.isNotEmpty;
    } catch (e) {
      return e.toString();
    }
  }
}

final asyncDatabaseProvider =
    AsyncNotifierProvider.autoDispose<AsyncDatabaseNotifier, dynamic>(() {
  return AsyncDatabaseNotifier();
});
