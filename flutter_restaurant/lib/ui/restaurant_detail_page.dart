import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/api/api_services.dart';
import 'package:flutter_restaurant/data/api/restaurant/provider/detail_restaurant_provider.dart';
import 'package:flutter_restaurant/data/model/restaurant_detail.dart';
import 'package:flutter_restaurant/widgets/platform_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail_page';

  final String id;

  const RestaurantDetailPage({super.key, required this.id});

  Widget _buildDetail(BuildContext context, String id) {
    return Consumer(
      builder: (context, ref, child) {
        final restaurantDetail = ref.watch(detailRestaurantProvider(id));
        // if (restaurantDetail == '') {
        //   return SafeArea(
        //       child: SingleChildScrollView(
        //     child: Column(
        //       children: [Text('Error')],
        //     ),
        //   ));
        // } else {
        return restaurantDetail.when(
          data: (data) {
            // final image =
            //     ApiService.retrivePicture(data.restaurant.pictureId, 'medium');
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        Hero(
                          tag: data.restaurant.pictureId,
                          child: Image.network(ApiService.retrivePicture(
                              data.restaurant.pictureId, 'medium')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.restaurant.name,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(data.restaurant.rating.toString()),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 25,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                data.restaurant.city,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                            height: 1,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            data.restaurant.description,
                            maxLines: 8,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: Colors.grey,
                            height: 1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Menus',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Food:',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          _buildFood(data),
                          SizedBox(
                            height: 4,
                          ),
                          Text('Drinks:',
                              style: Theme.of(context).textTheme.titleSmall),
                          SizedBox(
                            height: 6,
                          ),
                          _buildDrinks(data),
                          SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: Colors.grey,
                            height: 1,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Reviews:',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          _buildReviews(data),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return SafeArea(
              child: Text('Error: $error'),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    // SafeArea(
    //   child: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Stack(
    //           children: [
    //             // Image.network(
    //             //   restaurant.pictureId,
    //             // ),
    //             Hero(
    //               tag: restaurant.pictureId,
    //               child: Image.network(
    //                 restaurant.pictureId,
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   CircleAvatar(
    //                     backgroundColor: Colors.grey,
    //                     child: IconButton(
    //                       onPressed: () {
    //                         Navigator.pop(context);
    //                       },
    //                       icon: const Icon(
    //                         Icons.arrow_back,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //         Padding(
    //           padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 height: 15.0,
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     restaurant.name,
    //                     style: TextStyle(
    //                       fontSize: 25,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                   Row(
    //                     children: [
    //                       Icon(
    //                         Icons.star,
    //                         color: Colors.amber,
    //                         size: 20,
    //                       ),
    //                       SizedBox(
    //                         width: 5,
    //                       ),
    //                       Text(restaurant.rating.toString()),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: 10.0,
    //               ),
    //               Row(
    //                 children: [
    //                   Icon(
    //                     Icons.location_on,
    //                     size: 25,
    //                   ),
    //                   SizedBox(
    //                     width: 2,
    //                   ),
    //                   Text(
    //                     restaurant.city,
    //                     style: TextStyle(
    //                       fontSize: 16,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               Divider(
    //                 color: Colors.grey,
    //                 height: 1,
    //               ),
    //               SizedBox(
    //                 height: 18,
    //               ),
    //               Text('Description'),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text(
    //                 restaurant.description,
    //                 maxLines: 8,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //               SizedBox(
    //                 height: 4,
    //               ),
    //               Divider(
    //                 color: Colors.grey,
    //                 height: 1,
    //               ),
    //               SizedBox(
    //                 height: 8,
    //               ),
    //               Text(
    //                 'Menus',
    //                 style: TextStyle(
    //                   fontSize: 16,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 4,
    //               ),
    //               Text('Food:'),
    //               SizedBox(
    //                 height: 6,
    //               ),
    //               _buildFood(restaurant),
    //               SizedBox(
    //                 height: 4,
    //               ),
    //               Text('Drinks:'),
    //               SizedBox(
    //                 height: 6,
    //               ),
    //               _buildDrinks(restaurant),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
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
      height: 100,
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
                    SizedBox(
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
      body: _buildDetail(context, id),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildDetail(context, id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformHelper(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
