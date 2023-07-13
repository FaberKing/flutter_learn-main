import 'package:dicoding_restaurant/data/model/restaurant_list.dart';
import 'package:dicoding_restaurant/data/model/restaurant_search.dart';
import 'package:dicoding_restaurant/data/provider/list_restaurant_provider.dart';
import 'package:dicoding_restaurant/widgets/build_restaurant_item.dart';
import 'package:dicoding_restaurant/widgets/platform_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantListPage extends ConsumerStatefulWidget {
  static const routeName = '/restaurant_list_page';

  const RestaurantListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RestaurantListPageState();
}

class _RestaurantListPageState extends ConsumerState<RestaurantListPage> {
  TextEditingController searchContoller = TextEditingController();
  late bool show;

  @override
  void initState() {
    super.initState();

    searchContoller.text = ref.read(searchProvider);
    show = false;
  }

  Widget _buildListR(BuildContext context) {
    final restaurants = ref.watch(asyncRestaurantProvider);

    return restaurants.when(
      data: (data) {
        if (data.runtimeType == RestaurantList ||
            data.runtimeType == RestaurantSearch) {
          if (data.restaurants.isNotEmpty) {
            return ListView.builder(
              itemCount: data.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = data.restaurants[index];
                return BuildRestaurantItem(restaurant: restaurant);
              },
            );
          } else if (data.restaurants.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            return const Text('Something is Wrong');
          }
        } else {
          return Center(
            child: Text(data),
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
    final search = ref.watch(searchProvider);

    return Scaffold(
      appBar: AppBar(
        title: show
            ? TextField(
                autofocus: true,
                controller: searchContoller,
                onChanged: (value) {
                  ref.read(searchProvider.notifier).state = value;
                },
                decoration: const InputDecoration(
                    hintText: 'Enter Search', border: InputBorder.none),
              )
            : search.isEmpty
                ? const Text('Restaurant App')
                : TextField(
                    autofocus: true,
                    controller: searchContoller,
                    onChanged: (value) {
                      ref.read(searchProvider.notifier).state = value;
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
                ref.read(searchProvider.notifier).state = '';
                setState(() {
                  show = !show;
                });
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _buildListR(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    final search = ref.watch(searchProvider);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: show
            ? TextField(
                autofocus: true,
                controller: searchContoller,
                onChanged: (value) {
                  ref.read(searchProvider.notifier).state = value;
                },
                decoration: const InputDecoration(
                    hintText: 'Enter Search', border: InputBorder.none),
              )
            : search.isEmpty
                ? const Text('Restaurant App')
                : TextField(
                    autofocus: true,
                    controller: searchContoller,
                    onChanged: (value) {
                      ref.read(searchProvider.notifier).state = value;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Enter Search', border: InputBorder.none),
                  ),
        trailing: IconButton(
          onPressed: () {
            if (search.isNotEmpty) {
              null;
            } else {
              ref.read(searchProvider.notifier).state = '';
              setState(() {
                show = !show;
              });
            }
          },
          icon: const Icon(Icons.search),
        ),
        transitionBetweenRoutes: false,
      ),
      child: _buildListR(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformHelper(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  @override
  void dispose() {
    searchContoller.dispose();
    super.dispose();
  }
}
