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
        primarySwatch: Colors.blue,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: Image.asset(
          'images/android.png',
          width: 200,
          height: 200,
        ),
        // child: Image.network(
        //   'https://i.picsum.photos/id/406/200/300.jpg?hmac=hL72xK7v5nIaSK6F5XcGWjvxXslx72ZNRshXUAci5Bc',
        //   width: 200,
        //   height: 200,
        // ),
      ),
    );
  }
}
