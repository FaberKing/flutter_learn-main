import 'package:dicoding_restaurant/data/provider/detail_restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddReviewDialogs extends StatefulWidget {
  final String id;

  const AddReviewDialogs({super.key, required this.id});

  @override
  State<AddReviewDialogs> createState() => _AddReviewDialogsState();
}

class _AddReviewDialogsState extends State<AddReviewDialogs> {
  final TextEditingController name = TextEditingController();
  final TextEditingController reviews = TextEditingController();

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
                  'id': widget.id,
                  'name': name.text,
                  'review': reviews.text
                };

                ref
                    .read(asyncRestaurantDetailProvider(widget.id).notifier)
                    .addReview(context, answer, widget.id)
                    .then((value) => Navigator.pop(context));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    name.clear();
    reviews.clear();
    super.dispose();
  }
}
