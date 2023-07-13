import 'package:dicoding_restaurant/data/api/api_services.dart';
import 'package:dicoding_restaurant/data/model/restaurant.dart' as b;
import 'package:dicoding_restaurant/data/model/restaurant_detail.dart' as a;
import 'package:dicoding_restaurant/data/provider/database_future_provider.dart';
import 'package:dicoding_restaurant/data/provider/favorite_check_provider.dart';
import 'package:dicoding_restaurant/utils/add_refresh_favorite.dart';
import 'package:dicoding_restaurant/widgets/add_review_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/platform_helper.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail_page';

  final a.Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late a.Restaurant fullDetail;

  @override
  void initState() {
    super.initState();
    fullDetail = widget.restaurant;
  }

  Widget _buildDetail(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Hero(
                  tag: fullDetail.pictureId,
                  child: Image.network(
                    ApiService.retrivePicture(
                      fullDetail.pictureId,
                      'medium',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final isFavorite =
                              ref.watch(favoriteCheckProvider(fullDetail.id));
                          return isFavorite.when(
                            data: (data) {
                              return Positioned(
                                top: 0,
                                left: 340,
                                child: data
                                    ? IconButton(
                                        onPressed: () {
                                          RefreshFavorite.removeFavorite(
                                                  ref, fullDetail.id)
                                              .then((value) => ref.refresh(
                                                  favoriteCheckProvider(
                                                      fullDetail.id)))
                                              .whenComplete(() => ref.refresh(
                                                  databaseFavoriteProvider));
                                        },
                                        icon: const Icon(Icons.favorite,
                                            color: Colors.red, size: 40),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          RefreshFavorite.addFavorite(
                                                  ref,
                                                  b.Restaurant(
                                                      id: fullDetail.id,
                                                      name: fullDetail.name,
                                                      city: fullDetail.city,
                                                      description: fullDetail
                                                          .description,
                                                      pictureId:
                                                          fullDetail.pictureId,
                                                      rating:
                                                          fullDetail.rating))
                                              .then((value) => ref.refresh(
                                                  favoriteCheckProvider(
                                                      fullDetail.id)))
                                              .whenComplete(() => ref.refresh(
                                                  databaseFavoriteProvider));
                                        },
                                        icon: const Icon(Icons.favorite_border,
                                            color: Colors.red, size: 40),
                                      ),
                              );
                            },
                            error: (error, stackTrace) => Center(
                              child: Text('error ===>> $error'),
                            ),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          fullDetail.name,
                          style: Theme.of(context).textTheme.headlineMedium,
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
                          Text(fullDetail.rating.toString()),
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
                        fullDetail.city,
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
                    fullDetail.description,
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
                  _buildFood(fullDetail),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('Drinks:',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 6,
                  ),
                  _buildDrinks(fullDetail),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reviews:',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          final a.Restaurant result = await showDialog(
                            context: context,
                            builder: (context) =>
                                AddReviewDialogs(id: fullDetail.id),
                          );
                          setState(() {
                            fullDetail = result;
                          });
                        },
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
                  _buildReviews(widget.restaurant)
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // },
    // );
    // } else if (restauranti == RestaurantState.noData) {
    //   return SafeArea(
    //     child: Column(
    //       children: [
    //         AppBar(
    //           leading: IconButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             icon: const Icon(
    //               Icons.arrow_back,
    //             ),
    //           ),
    //         ),
    //         Center(
    //           child: Text(restaurantDetail.message),
    //         ),
    //       ],
    //     ),
    //   );
    // } else if (restauranti == RestaurantState.error) {
    //   return SafeArea(
    //     child: Column(
    //       children: [
    //         AppBar(
    //           leading: IconButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             icon: const Icon(
    //               Icons.arrow_back,
    //             ),
    //           ),
    //         ),
    //         Center(
    //           child: Text(restaurantDetail.message),
    //         ),
    //       ],
    //     ),
    //   );
    // } else {
    //   return SafeArea(
    //     child: Column(
    //       children: [
    //         AppBar(
    //           leading: IconButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             icon: const Icon(
    //               Icons.arrow_back,
    //             ),
    //           ),
    //         ),
    //         const Center(
    //           child: Text(''),
    //         ),
    //       ],
    //     ),
    //   );
    // }
    //   },
    // );
  }

  Widget _buildFood(a.Restaurant restaurant) {
    return SizedBox(
      height: 80,
      child: GridView.builder(
        itemCount: restaurant.menus.foods.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
          childAspectRatio: 1 / 1,
          mainAxisExtent: 70,
        ),
        itemBuilder: (context, index) {
          final food = restaurant.menus.foods[index];
          return Container(
            height: 1,
            width: 1,
            // height: 5,
            // width: 100,
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

  Widget _buildDrinks(a.Restaurant restaurant) {
    return SizedBox(
      height: 80,
      child: GridView.builder(
        physics: const ScrollPhysics(),
        itemCount: restaurant.menus.drinks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
          mainAxisExtent: 60,
        ),
        itemBuilder: (context, index) {
          final drinks = restaurant.menus.drinks[index];
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

  Widget _buildReviews(a.Restaurant restaurant) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: restaurant.customerReviews.length,
        itemBuilder: (context, index) {
          final reviews = restaurant.customerReviews[index];
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

// class RestaurantDetailPage extends ConsumerWidget {
//   static const routeName = '/restaurant_detail_page';

//   final Restaurant restaurant;

//   const RestaurantDetailPage({super.key, required this.restaurant});

//   Widget _buildDetail(BuildContext context, Restaurant restaurant, Widget ref) {
//     // return Consumer(
//     //   builder: (context, ref, child) {
//     //     final restaurant = ref.watch(restaurantDetailProvider(id));

//     //     final restaurantDetail =
//     //         ref.watch(restaurantDetailProvider(id).notifier);

//     //     if (restaurant == RestaurantState.loading) {
//     //       return const Center(
//     //         child: CircularProgressIndicator(color: Colors.black),
//     //       );
//     //     } else if (restaurant == RestaurantState.hasData) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Stack(
//               children: [
//                 Hero(
//                   tag: restaurant.pictureId,
//                   child: Image.network(
//                     ApiService.retrivePicture(
//                       restaurant.pictureId,
//                       'medium',
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.grey,
//                         child: IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: const Icon(
//                             Icons.arrow_back,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.favorite),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 15.0,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           restaurant.name,
//                           style: Theme.of(context).textTheme.headlineMedium,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                             size: 20,
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(restaurant.rating.toString()),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10.0,
//                   ),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.location_on,
//                         size: 25,
//                       ),
//                       const SizedBox(
//                         width: 2,
//                       ),
//                       Text(
//                         restaurant.city,
//                         style: const TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(
//                     color: Colors.grey,
//                     height: 1,
//                   ),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   Text(
//                     'Description',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     restaurant.description,
//                     maxLines: 8,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   const Divider(
//                     color: Colors.grey,
//                     height: 1,
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Text(
//                     'Menus',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Text(
//                     'Food:',
//                     style: Theme.of(context).textTheme.titleSmall,
//                   ),
//                   const SizedBox(
//                     height: 6,
//                   ),
//                   _buildFood(restaurant),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Text('Drinks:',
//                       style: Theme.of(context).textTheme.titleSmall),
//                   const SizedBox(
//                     height: 6,
//                   ),
//                   _buildDrinks(restaurant),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   const Divider(
//                     color: Colors.grey,
//                     height: 1,
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Reviews:',
//                         style: Theme.of(context).textTheme.titleSmall,
//                       ),
//                       OutlinedButton(
//                         onPressed: () =>
//                             addReviewDialog(context, restaurant.id, ref),
//                         child: const Text(
//                           'Add Review',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   _buildReviews(restaurant),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFood(Restaurant restaurant) {
//     return SizedBox(
//       height: 80,
//       child: GridView.builder(
//         itemCount: restaurant.menus.foods.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4,
//           crossAxisSpacing: 15,
//           mainAxisSpacing: 10,
//           childAspectRatio: 1 / 1,
//           mainAxisExtent: 70,
//         ),
//         itemBuilder: (context, index) {
//           final food = restaurant.menus.foods[index];
//           return Container(
//             height: 1,
//             width: 1,
//             // height: 5,
//             // width: 100,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.amber,
//             ),
//             padding: const EdgeInsets.all(8),
//             child: Text(
//               food.name,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildDrinks(Restaurant restaurant) {
//     return SizedBox(
//       height: 80,
//       child: GridView.builder(
//         physics: const ScrollPhysics(),
//         itemCount: restaurant.menus.drinks.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4,
//           crossAxisSpacing: 15,
//           mainAxisSpacing: 10,
//           mainAxisExtent: 60,
//         ),
//         itemBuilder: (context, index) {
//           final drinks = restaurant.menus.drinks[index];
//           return Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.amber,
//             ),
//             padding: const EdgeInsets.all(8),
//             child: Text(
//               drinks.name,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildReviews(Restaurant restaurant) {
//     return SizedBox(
//       height: 300,
//       child: ListView.builder(
//         itemCount: restaurant.customerReviews.length,
//         itemBuilder: (context, index) {
//           final reviews = restaurant.customerReviews[index];
//           return Card(
//             shape: const RoundedRectangleBorder(
//               side: BorderSide(color: Colors.grey),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(12),
//               ),
//             ),
//             child: SizedBox(
//               height: 90,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(reviews.name,
//                         textAlign: TextAlign.end,
//                         style: Theme.of(context).textTheme.labelLarge),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                       child: Text(
//                         '" ${reviews.review} "',
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Expanded(
//                         child: Align(
//                             alignment: Alignment.bottomRight,
//                             child: Text(
//                               reviews.date,
//                               style: Theme.of(context).textTheme.labelSmall,
//                             ))),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildAndroid(BuildContext context, ref) {
//     return Scaffold(
//       body: _buildDetail(context, restaurant, ref),
//     );
//   }

//   Widget _buildIos(BuildContext context) {
//     return CupertinoPageScaffold(
//       child: _buildDetail(context, restaurant, ref),
//     );
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return PlatformHelper(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
//   }
// }
