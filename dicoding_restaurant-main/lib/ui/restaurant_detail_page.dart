import 'package:dicoding_restaurant/common/navigation.dart';
import 'package:dicoding_restaurant/data/api/api_services.dart';
import 'package:dicoding_restaurant/data/model/restaurant.dart';
import 'package:dicoding_restaurant/data/model/restaurant_detail.dart';
import 'package:dicoding_restaurant/data/provider/check_favorite_provider.dart';
import 'package:dicoding_restaurant/data/provider/database_provider.dart';
import 'package:dicoding_restaurant/data/provider/detail_restaurant_provider.dart';
import 'package:dicoding_restaurant/widgets/add_review_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/platform_helper.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail_page';
  final Restaurant restaurantItem;
  const RestaurantDetailPage({super.key, required this.restaurantItem});

  Widget _buildDetail(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Hero(
                    tag: restaurantItem.pictureId,
                    child: Image.network(
                      ApiService.retrivePicture(
                          restaurantItem.pictureId, 'medium'),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final isFavorite =
                          ref.watch(checkFavoriteProvider(restaurantItem.id));

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: IconButton(
                              onPressed: () => Navigation.back(),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          isFavorite.when(
                            data: (data) {
                              return data
                                  ? IconButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                                asyncDatabaseProvider.notifier)
                                            .removeFavorite(restaurantItem.id)
                                            .then((value) => ref.refresh(
                                                checkFavoriteProvider(
                                                        restaurantItem.id)
                                                    .future));
                                      },
                                      icon:
                                          const Icon(Icons.favorite, size: 40),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                                asyncDatabaseProvider.notifier)
                                            .addFavorites(restaurantItem)
                                            .then((value) => ref.refresh(
                                                checkFavoriteProvider(
                                                        restaurantItem.id)
                                                    .future));
                                      },
                                      icon: const Icon(Icons.favorite_border,
                                          size: 40),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary);
                            },
                            error: (error, stackTrace) {
                              return const Center();
                            },
                            loading: () {
                              return const Center();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Consumer(
                builder: (context, ref, child) {
                  final restaurantsDetail = ref
                      .watch(asyncRestaurantDetailProvider(restaurantItem.id));

                  return restaurantsDetail.when(
                    data: (data) {
                      if (data.runtimeType == RestaurantDetail) {
                        if (data.restaurant.id.isNotEmpty) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.restaurant.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(data.restaurant.rating.toString()),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    data.restaurant.city,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                data.restaurant.description,
                                maxLines: 8,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Menus',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Food:',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              _buildFood(data),
                              const SizedBox(
                                height: 4,
                              ),
                              Text('Drinks:',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              const SizedBox(
                                height: 6,
                              ),
                              _buildDrinks(data),
                              const SizedBox(
                                height: 4,
                              ),
                              const Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Reviews:',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  OutlinedButton(
                                    onPressed: () async => showDialog(
                                      context: context,
                                      builder: (context) => AddReviewDialogs(
                                          id: restaurantItem.id),
                                    ),
                                    child: const Text(
                                      'Add Review',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              _buildReviews(data),
                            ],
                          );
                        } else if (data.restaurant.isEmpty) {
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
                      heightFactor: 13,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFood(RestaurantDetail restaurant) {
    return SizedBox(
      height: 80,
      child: GridView.builder(
        itemCount: restaurant.restaurant.menus.foods.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
          childAspectRatio: 1 / 1,
          mainAxisExtent: 70,
        ),
        itemBuilder: (context, index) {
          final food = restaurant.restaurant.menus.foods[index];
          return Container(
            height: 1,
            width: 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber,
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              food.name,
            ),
          );
        },
      ),
    );
  }

  Widget _buildDrinks(RestaurantDetail restaurant) {
    return SizedBox(
      height: 80,
      child: GridView.builder(
        physics: const ScrollPhysics(),
        itemCount: restaurant.restaurant.menus.drinks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
          mainAxisExtent: 60,
        ),
        itemBuilder: (context, index) {
          final drinks = restaurant.restaurant.menus.drinks[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber,
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              drinks.name,
            ),
          );
        },
      ),
    );
  }

  Widget _buildReviews(RestaurantDetail restaurant) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: restaurant.restaurant.customerReviews.length,
        itemBuilder: (context, index) {
          final reviews = restaurant.restaurant.customerReviews[index];
          return Card(
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: SizedBox(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(reviews.name,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        '" ${reviews.review} "',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              reviews.date,
                              style: Theme.of(context).textTheme.labelSmall,
                            ))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildDetail(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildDetail(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformHelper(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
