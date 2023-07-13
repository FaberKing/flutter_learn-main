import 'package:dicoding_restaurant/data/api/api_services.dart';
import 'package:dicoding_restaurant/data/provider/database_future_provider.dart';
import 'package:dicoding_restaurant/data/provider/database_provider.dart';
import 'package:dicoding_restaurant/data/provider/detail_restaurant_provider.dart';
import 'package:dicoding_restaurant/data/provider/favorite_check_provider.dart';
import 'package:dicoding_restaurant/ui/restaurant_detail_page.dart';
import 'package:dicoding_restaurant/utils/add_refresh_favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuildRestaurantItem extends ConsumerWidget {
  final dynamic restaurant;
  const BuildRestaurantItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantDetail =
        ref.watch(restaurantDetailProvider(restaurant.id).notifier);
    // final checkFavorite = ref.watch(favoriteListFullProvider.notifier);
    // return FutureBuilder<dynamic>(
    //   future: checkFavorite.isFavorited(restaurant.id),
    //   builder: (context, snapshot) {
    // var isFavorite = snapshot.data ?? false;
    // var isFavorite = checkFavorite ?? false;
    final isFavorite = ref.watch(favoriteCheckProvider(restaurant.id));

    return Material(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              RestaurantDetailPage.routeName,
              arguments: restaurantDetail.result.restaurant,
            );
          },
          child: Center(
            child: Card(
              shadowColor: Colors.orange,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Hero(
                      tag: restaurant.pictureId,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          ApiService.retrivePicture(
                            restaurant.pictureId,
                            'small',
                          ),
                          width: 125,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 4, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  restaurant.name,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              isFavorite.when(
                                data: (data) {
                                  return data
                                      ? IconButton(
                                          onPressed: () {
                                            RefreshFavorite.removeFavorite(
                                                    ref, restaurant.id)
                                                .then((value) => ref.refresh(
                                                    favoriteCheckProvider(
                                                        restaurant.id)))
                                                .whenComplete(() => ref.refresh(
                                                    databaseFavoriteProvider));
                                          },
                                          icon: const Icon(Icons.favorite),
                                          color: Theme.of(context).accentColor,
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            RefreshFavorite.addFavorite(
                                                    ref, restaurant)
                                                .then((value) => ref.refresh(
                                                    favoriteCheckProvider(
                                                        restaurant.id)))
                                                .whenComplete(() => ref.refresh(
                                                    databaseFavoriteProvider));
                                          },
                                          icon: const Icon(
                                            Icons.favorite_border,
                                          ),
                                          color: Theme.of(context).accentColor);
                                },
                                error: (error, stackTrace) =>
                                    Text('Error: $error'),
                                loading: () =>
                                    const CircularProgressIndicator(),
                              )
                            ],
                          ),
                          // const SizedBox(
                          //   height: 8,
                          // ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 19,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(restaurant.city),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(restaurant.rating.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    //   },
    // );
  }
}
