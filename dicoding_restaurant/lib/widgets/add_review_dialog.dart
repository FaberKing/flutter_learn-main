import 'package:dicoding_restaurant/data/model/restaurant_detail.dart';
import 'package:dicoding_restaurant/data/provider/detail_restaurant_provider.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> addReviewDialog(
    BuildContext context, String id, WidgetRef ref) async {
  TextEditingController name = TextEditingController();
  TextEditingController reviews = TextEditingController();
  // late Restaurant value;

  RestaurantDetail result = await showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          return AlertDialog(
            title: const Text('Add Your Reviews :'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: 'Enter Your Name',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: reviews,
                  decoration: const InputDecoration(
                    labelText: 'Enter Your Review',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
            actions: [
              TextButton(
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Map answer = {
                    'id': id,
                    'name': name.text,
                    'review': reviews.text
                  };
                  ref
                      .read(restaurantDetailProvider(id).notifier)
                      .entryNewReview(answer, context, id)
                      .whenComplete(
                    () {
                      // return ref.watch(restaurantDetailProvider(id).notifier);
                      // // final restaurantDetail =
                      // //     ref.watch(restaurantDetailProvider(id).notifier);

                      // value = ref
                      //     .watch(restaurantDetailProvider(id).notifier)
                      //     .result
                      //     .restaurant;
                      Navigator.pop(
                          context,
                          ref
                              .watch(restaurantDetailProvider(id).notifier)
                              .allRestaurantDetail(id));
                    },
                  );
                },
              ),
            ],
          );
        },
      );
    },
  );
  print(result);
}

class AddReviewDialogs extends StatelessWidget {
  final String id;
  final TextEditingController name = TextEditingController();
  final TextEditingController reviews = TextEditingController();

  AddReviewDialogs({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return AlertDialog(
          title: const Text('Add Your Reviews :'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: 'Enter Your Name',
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: reviews,
                decoration: const InputDecoration(
                  labelText: 'Enter Your Review',
                  labelStyle: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Map answer = {
                  'id': id,
                  'name': name.text,
                  'review': reviews.text
                };
                ref
                    .read(restaurantDetailProvider(id).notifier)
                    .entryNewReview(answer, context, id)
                    .whenComplete(
                  () {
                    Navigator.pop(
                        context,
                        ref
                            .read(restaurantDetailProvider(id).notifier)
                            .result
                            .restaurant);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
