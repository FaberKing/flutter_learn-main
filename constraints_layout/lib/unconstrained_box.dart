import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        color: Colors.red,
        width: 1000,
        height: 100,
      ),
    );
  }
}

// Row(
//   children: [
//     Container(
//       color: Colors.red,
//       child: Text('Hello!'),
//     ),
//     Container(
//       color: Colors.green,
//       child: Text('Goodbye!'),
//     ),
//   ],
// ),

// Row(
//   children: [
//     Container(
//       color: Colors.red,
//       child: Text('Hello! This is a very long Text!'),
//     ),
//     Container(
//       color: Colors.green,
//       child: Text('Goodbye!'),
//     ),
//   ],
// ),

// Row(
//   children: [
//     Expanded(
//       child: Container(
//         color: Colors.red,
//         child: Text('Hello! This is a very long Text!'),
//       ),
//     ),
//     Container(
//       color: Colors.green,
//       child: Text('Goodbye!'),
//     ),
//   ],
// ),

// Row(
//   children: [
//     Expanded(
//       child: Container(
//         color: Colors.red,
//         child: Text('Hello! This is a very long Text!'),
//       ),
//     ),
//     Expanded(
//       child: Container(
//         color: Colors.green,
//         child: Text('Goodbye!'),
//       ),
//     ),
//   ],
// ),

// Row(
//   children: [
//     Flexible(
//       child: Container(
//         color: Colors.red,
//         child: Text('Hello! This is a very long Text!'),
//       ),
//     ),
//     Flexible(
//       child: Container(
//         color: Colors.green,
//         child: Text('Goodbye!'),
//       ),
//     ),
//   ],