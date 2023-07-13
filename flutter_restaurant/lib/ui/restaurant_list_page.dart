import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/api/restaurant/provider/list_restaurant_provider.dart';
import 'package:flutter_restaurant/data/api/restaurant/provider/search_provider.dart';
import 'package:flutter_restaurant/data/model/restaurant_list.dart';
import 'package:flutter_restaurant/widgets/build_restaurant_item.dart';
import 'package:flutter_restaurant/widgets/platform_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list_page';
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
    final restaurant = ref.watch(listRestaurantProvider);
    // if (restaurant.value) {
    // } else {}

    return restaurant.when(
      data: (data) {
        if (data == 'No Data') {
          return Text(data);
        } else if (data.runtimeType == String &&
            data.toString().contains('E')) {
          return Text(data);
        } else if (data.runtimeType == RestaurantList) {
          return ListView.builder(
            itemCount: data.restaurants.length,
            itemBuilder: (context, index) {
              return buildRestaurantItem(context, data.restaurants[index], ref);
            },
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
      error: (error, stackTrace) => Text('Error: $error'),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // return restaurant.when(
    //   data: (restaurantList) => restaurantList.restaurants.isNotEmpty
    // ? ListView.builder(
    //     itemCount: restaurantList.restaurants.length,
    //     itemBuilder: (context, index) {
    //       return buildRestaurantItem(
    //           context, restaurantList.restaurants[index], ref);
    //     },
    //   )
    //       : const Center(
    //           child: Text('No Data'),
    //         ),
    // error: (error, stackTrace) => Text('Error: $error'),
    // loading: () => const Center(
    //   child: CircularProgressIndicator(),
    // ),
    // );

    // } else {
    //   print('eeeee');
    //   final restaurant = ref.watch(searchRestaurantProvider(searchText.text));

    //   return restaurant.when(
    //     data: (restaurantListSearch) => restaurantListSearch
    //             .restaurants.isNotEmpty
    //         ? ListView.builder(
    //             itemCount: restaurantListSearch.restaurants.length,
    //             itemBuilder: (context, index) {
    //               return _buildRestaurantItem(
    //                   context, restaurantListSearch.restaurants[index], ref);
    //             },
    //           )
    //         : const Center(
    //             child: Text('No Data'),
    //           ),
    //     error: (error, stackTrace) => Text('Error: $error'),
    //     loading: () => const Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }
    // final restaurant = ref.watch(listRestaurantProvider);

    // return restaurant.when(
    //   data: (restaurantList) => restaurantList.restaurants.isNotEmpty
    //       ? ListView.builder(
    //           itemCount: restaurantList.restaurants.length,
    //           itemBuilder: (context, index) {
    //             return _buildRestaurantItem(
    //                 context, restaurantList.restaurants[index], ref);
    //           },
    //         )
    //       : const Center(
    //           child: Text('No Data'),
    //         ),
    //   error: (error, stackTrace) => Text('Error: $error'),
    //   loading: () => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
    // final restaurant = ref.watch(fetchRestaurantProvider);
    // return FutureBuilder<String>(
    //   future: DefaultAssetBundle.of(context)
    //       .loadString('assets/local_restaurant.json'),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState != ConnectionState.done) {
    //       // loading widget
    //       return const Center(child: CircularProgressIndicator());
    //     } else {
    //       if (snapshot.hasData) {
    //         // success widget
    //         // final jsonResponse = jsonDecode(
    //         //   snapshot.data.toString(),
    //         // );
    //         // Restaurant restaurant1 = new Restaurant.fromJson(jsonResponse);
    //         final List<Restaurant> restaurant =
    //             localRestaurantFromJson(snapshot.data);

    //         return ListView.builder(
    //           itemCount: restaurant.length,
    //           itemBuilder: (context, index) {
    //             return _buildRestaurantItem(context, restaurant[index]);
    //           },
    //         );
    //       } else if (snapshot.hasError) {
    //         // error widget
    //         return Center(
    //           child: Text(snapshot.error.toString()),
    //         );
    //       } else {
    //         // loading widget
    //         return Center(child: CircularProgressIndicator());
    //       }
    //     }
    //   },
    // );
  }

  Widget _buildListSearch(BuildContext context, WidgetRef ref) {
    final restaurant = ref.watch(searchRestaurantProvider(keyword));

    return restaurant.when(
      data: (restaurantList) => restaurantList.restaurants.isNotEmpty
          ? ListView.builder(
              itemCount: restaurantList.restaurants.length,
              itemBuilder: (context, index) {
                return buildRestaurantItem(
                    context, restaurantList.restaurants[index], ref);
              },
            )
          : const Center(
              child: Text('No Data Match'),
            ),
      error: (error, stackTrace) => Text('Error: $error'),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
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
      body: Consumer(
        builder: (context, ref, child) {
          return searchText.text.isEmpty
              ? _buildListR(context, ref)
              : _buildListSearch(context, ref);
        },
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
            : Text('Restaurant App'),
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
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return searchText.text.isEmpty
              ? _buildListR(context, ref)
              : _buildListSearch(context, ref);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformHelper(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
