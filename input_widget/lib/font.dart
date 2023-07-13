import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:input_widget/main.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Oswald',
        primarySwatch: Colors.blue,
      ),
      home: const fonts1(),
    );
  }
}

class fonts1 extends StatelessWidget {
  const fonts1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text(
          'Custom Font',
          style: TextStyle(fontFamily: 'Oswald', fontSize: 30),
        ),
      ),
    );
  }
}
