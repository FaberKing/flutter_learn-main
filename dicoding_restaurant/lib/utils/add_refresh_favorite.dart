import 'package:dicoding_restaurant/data/model/restaurant.dart';
import 'package:dicoding_restaurant/data/provider/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshFavorite {
  static Future<void> removeFavorite(WidgetRef ref, String id) async {
    ref.read(favoriteListFullProvider.notifier).removeFavorite(id);

    // ref.refresh(favoriteCheckProvider(restaurant.id));
    // ref.refresh(databaseFavoriteProvider);
  }

  static Future<void> addFavorite(WidgetRef ref, Restaurant restaurant) async {
    ref.read(favoriteListFullProvider.notifier).addFavorites(restaurant);
  }
}
