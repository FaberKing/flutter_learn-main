import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      home: const ScrollingScreen(),
    );
  }
}

class ScrollingScreen extends StatelessWidget {
  const ScrollingScreen({Key? key}) : super(key: key);

  final List<int> numberList = const <int>[
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: numberList.map((number) {
          return Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(fontSize: 50),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// class ScrollingScreen extends StatelessWidget {
//   const ScrollingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: <Widget>[
//           Container(
//             height: 250,
//             decoration: BoxDecoration(
//               color: Colors.grey,
//               border: Border.all(color: Colors.black),
//             ),
//             child: const Center(
//               child: Text(
//                 '1',
//                 style: TextStyle(fontSize: 50),
//               ),
//             ),
//           ),
//           Container(
//             height: 250,
//             decoration: BoxDecoration(
//               color: Colors.grey,
//               border: Border.all(color: Colors.black),
//             ),
//             child: const Center(
//               child: Text(
//                 '2',
//                 style: TextStyle(fontSize: 50),
//               ),
//             ),
//           ),
//           Container(
//             height: 250,
//             decoration: BoxDecoration(
//               color: Colors.grey,
//               border: Border.all(color: Colors.black),
//             ),
//             child: const Center(
//               child: Text(
//                 '3',
//                 style: TextStyle(fontSize: 50),
//               ),
//             ),
//           ),
//           Container(
//             height: 250,
//             decoration: BoxDecoration(
//               color: Colors.grey,
//               border: Border.all(color: Colors.black),
//             ),
//             child: const Center(
//               child: Text(
//                 '4',
//                 style: TextStyle(fontSize: 50),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
