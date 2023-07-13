import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(10.0),
        child: Container(
          color: Colors.green,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
