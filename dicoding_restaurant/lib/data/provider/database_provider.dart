import 'package:dicoding_restaurant/common/state_restaurant.dart';
import 'package:dicoding_restaurant/data/db/database_helper.dart';
import 'package:dicoding_restaurant/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatabaseNotifier extends StateNotifier<RestaurantState> {
  final DatabaseHelper databaseHelper;

  DatabaseNotifier({required this.databaseHelper})
      : super(RestaurantState.nothing) {
    _getFavorites();
  }

  // late RestaurantState _state;
  // RestaurantState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      state = RestaurantState.hasData;
    } else {
      state = RestaurantState.noData;
      _message = 'Empty Data';
    }

    // notifyListeners();
  }

  void addFavorites(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant).then(
            (_) => _getFavorites(),
          );
      // _getFavorites();
    } catch (e) {
      state = RestaurantState.error;
      _message = 'Error: $e';
      // notifyListeners();
    }
  }

  Future<dynamic> isFavorited(String id) async {
    try {
      final bookmarkedArticle = await databaseHelper.getFavoritekById(id);
      // _getFavorites();

      return bookmarkedArticle.isNotEmpty;
    } catch (e) {
      state = RestaurantState.error;
      _message = 'Error: $e';
    }
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id).then(
            (_) => _getFavorites(),
          );
      // _getFavorites();
    } catch (e) {
      state = RestaurantState.error;
      _message = 'Error: $e';
      // notifyListeners();
    }
  }
}

final favoriteListFullProvider =
    StateNotifierProvider<DatabaseNotifier, RestaurantState>(
        (ref) => DatabaseNotifier(databaseHelper: DatabaseHelper()));

final favoriteMarkFullProvider = Provider<List<Restaurant>>((ref) {
  final restaurant = ref.watch(favoriteListFullProvider.notifier)._favorites;

  return restaurant;
});
