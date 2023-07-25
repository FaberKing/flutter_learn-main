import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  final GoException? error;
  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(error.toString()),
          ElevatedButton(
            onPressed: () => context.go('/splash'),
            child: const Text('Home'),
          ),
        ],
      ),
    );
  }
}
