import 'package:dicoding_restaurant/common/navigation.dart';
import 'package:dicoding_restaurant/data/api/api_services.dart';
import 'package:dicoding_restaurant/data/provider/check_favorite_provider.dart';
import 'package:dicoding_restaurant/data/provider/database_provider.dart';
import 'package:dicoding_restaurant/ui/restaurant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuildRestaurantItem extends ConsumerWidget {
  final dynamic restaurant;
  const BuildRestaurantItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(checkFavoriteProvider(restaurant.id));
    return Material(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: InkWell(
          onTap: () => Navigation.intentWithData(
              RestaurantDetailPage.routeName, restaurant),
          child: Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceVariant,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Center(
              child: SizedBox(
                width: 400,
                height: 90,
                child: Row(
                  children: [
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Hero(
                          tag: restaurant.pictureId,
                          child: Image.network(
                            ApiService.retrivePicture(
                                restaurant.pictureId, 'small'),
                            width: 125,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  restaurant.name,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                isFavorite.when(
                                  data: (data) {
                                    var isisis = data ?? false;
                                    return isisis
                                        ? GestureDetector(
                                            onTap: () {
                                              ref
                                                  .read(asyncDatabaseProvider
                                                      .notifier)
                                                  .removeFavorite(
                                                      restaurant.id);
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              ref
                                                  .read(asyncDatabaseProvider
                                                      .notifier)
                                                  .addFavorites(restaurant);
                                            },
                                            child: Icon(
                                              Icons.favorite_border,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          );
                                  },
                                  error: (error, stackTrace) {
                                    return const Center();
                                  },
                                  loading: () {
                                    return const Center();
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(restaurant.city),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
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
      ),
    );
  }
}
