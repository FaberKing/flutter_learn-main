import 'package:dicoding_restaurant/common/state_restaurant.dart';
import 'package:dicoding_restaurant/data/model/restaurant_list.dart';
import 'package:dicoding_restaurant/data/provider/list_restaurant_future_provider.dart';
import 'package:dicoding_restaurant/data/provider/search_provider.dart';
import 'package:dicoding_restaurant/widgets/build_restaurant_item.dart';
import 'package:dicoding_restaurant/widgets/platform_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list_page';
  static const String restaurantsTitle = 'Home';

  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  String keyword = '';
  late bool show;
  TextEditingController searchText = TextEditingController();

  @override
  void initState() {
    super.initState();
    show = false;
  }

  Widget _buildListR(BuildContext context, WidgetRef ref) {
    final restaurant = ref.watch(restaurantDataProvider);
    return restaurant.when(
      data: (data) {
        if (data.runtimeType == RestaurantList) {
          if (data.restaurants.isNotEmpty) {
            return ListView.builder(
              itemCount: data.restaurants.length,
              itemBuilder: (context, index) {
                return BuildRestaurantItem(restaurant: data.restaurants[index]);
              },
            );
          } else if (data.restaurants.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            return const Text('Something Wrong');
          }
        } else {
          return Center(
            child: Text(data),
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
    // final restaurantState = ref.watch(restaurantListFullProvider);
    // final restaurantValue = ref.watch(restaurantListFullProvider.notifier);

    // if (restaurantState == RestaurantState.loading) {
    //   return const Center(
    //     child: CircularProgressIndicator(color: Colors.black),
    //   );
    // } else if (restaurantState == RestaurantState.hasData) {
    //   return ListView.builder(
    //     itemCount: restaurantValue.result.restaurants.length,
    //     itemBuilder: (context, index) {
    //       // return buildRestaurantItem(
    //       //     context, restaurantValue.result.restaurants[index]);
    //       return BuildRestaurantItem(
    //           restaurant: restaurantValue.result.restaurants[index]);
    //     },
    //   );
    // } else if (restaurantState == RestaurantState.noData) {
    //   return SafeArea(
    //     child: Center(
    //       child: Text(restaurantValue.message),
    //     ),
    //   );
    // } else if (restaurantState == RestaurantState.error) {
    //   return Center(
    //     child: Text(restaurantValue.message),
    //   );
    // } else {
    //   return const Material(
    //     child: Center(
    //       child: Text('eeee'),
    //     ),
    //   );
    // }
  }

  Widget _buildListSearch(BuildContext context, WidgetRef ref) {
    final restaurant = ref.watch(restaurantSearchListProvider(keyword));
    final restaurantother =
        ref.watch(restaurantSearchListProvider(keyword).notifier);

    if (restaurant == RestaurantState.loading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.black),
      );
    } else if (restaurant == RestaurantState.hasData) {
      return ListView.builder(
        itemCount: restaurantother.result.restaurants.length,
        itemBuilder: (context, index) {
          // return buildRestaurantItem(
          //     context, restaurantother.result.restaurants[index]);
          return BuildRestaurantItem(
              restaurant: restaurantother.result.restaurants[index]);
        },
      );
    } else if (restaurant == RestaurantState.noData) {
      return SafeArea(
        child: Center(
          child: Text(restaurantother.message),
        ),
      );
    } else if (restaurant == RestaurantState.error) {
      return Center(
        child: Text(restaurantother.message),
      );
    } else {
      return const Material(
        child: Center(
          child: Text('eeee'),
        ),
      );
    }
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: show
            ? TextField(
                controller: searchText,
                onChanged: (value) {
                  setState(() {
                    keyword = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter Search',
                ),
              )
            : const Text('Restaurant App'),
        actions: [
          IconButton(
            onPressed: () {
              searchText.text.isNotEmpty
                  ? null
                  : setState(() {
                      searchText.clear();
                      show = !show;
                    });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            return searchText.text.isEmpty
                ? _buildListR(context, ref)
                : _buildListSearch(context, ref);
          },
        ),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: show
            ? TextField(
                controller: searchText,
                onChanged: (value) {
                  setState(() {
                    keyword = value;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Enter Search',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none),
              )
            : const Text('Restaurant App'),
        trailing: IconButton(
          onPressed: () {
            searchText.text.isNotEmpty
                ? null
                : setState(() {
                    searchText.clear();
                    show = !show;
                  });
          },
          icon: const Icon(Icons.search),
        ),
        transitionBetweenRoutes: false,
      ),
      child: SafeArea(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return searchText.text.isEmpty
                ? _buildListR(context, ref)
                : _buildListSearch(context, ref);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformHelper(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
