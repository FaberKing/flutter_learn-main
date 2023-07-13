import 'package:dicoding_restaurant/data/provider/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkFavoriteProvider =
    FutureProvider.family.autoDispose<dynamic, String>((ref, id) async {
  final favoriteRestaurant =
      ref.read(asyncDatabaseProvider.notifier).isFavorited(id);

  return favoriteRestaurant;
});
