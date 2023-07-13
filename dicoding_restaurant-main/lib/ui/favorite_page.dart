import 'package:dicoding_restaurant/common/navigation.dart';
import 'package:dicoding_restaurant/data/model/restaurant.dart';
import 'package:dicoding_restaurant/data/provider/database_provider.dart';
import 'package:dicoding_restaurant/widgets/build_restaurant_item.dart';
import 'package:dicoding_restaurant/widgets/platform_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePage extends ConsumerStatefulWidget {
  static const String favoritesTitle = 'Favorites';

  const FavoritePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  TextEditingController searchContoller = TextEditingController();
  late bool show;

  @override
  void initState() {
    super.initState();
    searchContoller.text = ref.read(searchFavoriteProvider);
    show = false;
  }

  Widget _buildList(BuildContext context) {
    final restaurants = ref.watch(asyncDatabaseProvider);
    return restaurants.when(
      data: (data) {
        if ((data.isNotEmpty && data is List<Restaurant>) ||
            (data.isNotEmpty && data is List<dynamic>)) {
          if (data.isNotEmpty) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final restaurant = data[index];
                return BuildRestaurantItem(restaurant: restaurant);
              },
            );
          } else if (data.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            return const Text('Something is Wrong');
          }
        } else {
          return Center(
            child: Text('$data'),
          );
        }
      },
      error: (error, stackTrace) => Center(
        child: Text('error =====> $error'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    final search = ref.watch(searchFavoriteProvider);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: show
            ? TextField(
                autofocus: true,
                controller: searchContoller,
                onChanged: (value) {
                  ref.read(searchFavoriteProvider.notifier).state = value;
                },
                decoration: const InputDecoration(
                    hintText: 'Enter Search', border: InputBorder.none),
              )
            : search.isEmpty
                ? const Text(FavoritePage.favoritesTitle)
                : TextField(
                    autofocus: true,
                    controller: searchContoller,
                    onChanged: (value) {
                      ref.read(searchFavoriteProvider.notifier).state = value;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Enter Search', border: InputBorder.none),
                  ),
        actions: [
          IconButton(
            onPressed: () {
              if (search.isNotEmpty) {
                null;
              } else {
                ref.read(searchFavoriteProvider.notifier).state = '';
                setState(() {
                  show = !show;
                });
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    final search = ref.watch(searchFavoriteProvider);

    return CupertinoPageScaffold(
      key: scaffoldKey,
      navigationBar: CupertinoNavigationBar(
        middle: show
            ? TextField(
                autofocus: true,
                controller: searchContoller,
                onChanged: (value) {
                  ref.read(searchFavoriteProvider.notifier).state = value;
                },
                decoration: const InputDecoration(
                    hintText: 'Enter Search', border: InputBorder.none),
              )
            : search.isEmpty
                ? const Text(FavoritePage.favoritesTitle)
                : TextField(
                    autofocus: true,
                    controller: searchContoller,
                    onChanged: (value) {
                      ref.read(searchFavoriteProvider.notifier).state = value;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Enter Search', border: InputBorder.none),
                  ),
        trailing: IconButton(
          onPressed: () {
            if (search.isNotEmpty) {
              null;
            } else {
              ref.read(searchFavoriteProvider.notifier).state = '';
              setState(() {
                show = !show;
              });
            }
          },
          icon: const Icon(Icons.search),
        ),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformHelper(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  @override
  void dispose() {
    searchContoller.dispose();
    super.dispose();
  }
}
