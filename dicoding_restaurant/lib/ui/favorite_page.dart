import 'package:dicoding_restaurant/common/state_restaurant.dart';
import 'package:dicoding_restaurant/data/model/restaurant.dart';
import 'package:dicoding_restaurant/data/provider/database_future_provider.dart';
import 'package:dicoding_restaurant/data/provider/database_provider.dart';
import 'package:dicoding_restaurant/widgets/build_restaurant_item.dart';
import 'package:dicoding_restaurant/widgets/platform_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePage extends ConsumerStatefulWidget {
  static const String bookmarksTitle = 'Bookmarks';

  const FavoritePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  Widget _buildList() {
    final favorites = ref.watch(databaseFavoriteProvider);
    return favorites.when(
      data: (data) {
        if (data.isNotEmpty) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final favorite = data[index];
              return BuildRestaurantItem(restaurant: favorite);
            },
          );
        } else {
          return const Center(
            child: Text('No Data'),
          );
        }
      },
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    // final restaurantState = ref.watch(favoriteListFullProvider);
    // var restaurantValue = ref.watch(favoriteListFullProvider.notifier);
    // ref.listen(favoriteListFullProvider, (previous, next) {
    //   restaurantValue;
    //   // restaurantValue = next;
    // });
    // restaurantValue.favorites.
    // if (restaurantState == RestaurantState.loading) {
    //   return const Center(
    //     child: CircularProgressIndicator(color: Colors.black),
    //   );
    // } else if (restaurantState == RestaurantState.hasData) {
    //   // restaurantValue.
    //   return ListView.builder(
    //     itemCount: restaurantValue.favorites.length,
    //     itemBuilder: (context, index) {
    //       return BuildRestaurantItem(
    //           restaurant: restaurantValue.favorites[index]);
    //     },
    //   );
    // } else if (restaurantState == RestaurantState.noData) {
    //   return Center(
    //     child: Material(
    //       child: Text(restaurantValue.message),
    //     ),
    //   );
    // } else {
    //   return Center(
    //     child: Material(
    //       child: Text(''),
    //     ),
    //   );
    // }
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(FavoritePage.bookmarksTitle),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(FavoritePage.bookmarksTitle),
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformHelper(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
