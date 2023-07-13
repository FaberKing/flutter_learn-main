import 'package:dicoding_restaurant/data/provider/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteCheckProvider =
    FutureProvider.family.autoDispose<dynamic, String>((ref, id) async {
  final checkFavorite =
      ref.watch(favoriteListFullProvider.notifier).isFavorited(id);
  return checkFavorite;
});

// final favoriteCheckProvider =
//     StreamProvider.family.autoDispose<bool, String>((ref, id) async* {
//   final checkFavorite =
//       await ref.watch(favoriteListFullProvider.notifier).isFavorited(id);
//   yield checkFavorite;
// });
