import 'package:dicoding_restaurant/data/db/database_helper.dart';
import 'package:dicoding_restaurant/data/model/restaurant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseFavoriteProvider = FutureProvider<List<Restaurant>>((ref) async {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final favorite = await databaseHelper.getFavorites();
  return favorite;
});
