import 'package:flutter/material.dart';
import 'package:sliver_list_grid/learning_path_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sliver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LearningPathPage(),
    );
  }
}
