import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/api/api_services.dart';
import 'package:flutter_restaurant/ui/restaurant_detail_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget buildRestaurantItem(
    BuildContext context, dynamic restaurant, WidgetRef ref) {
  final image = ApiService.retrivePicture(restaurant.pictureId, 'small');

  return Material(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            RestaurantDetailPage.routeName,
            arguments: restaurant.id,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: restaurant.pictureId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      image,
                      width: 125,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 4, 0, 0),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 19,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(restaurant.city),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(restaurant.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
