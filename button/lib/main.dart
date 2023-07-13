import 'package:flutter/material.dart';

void main() {
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String? language;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: DropdownButton<String>(
        items: const <DropdownMenuItem<String>>[
          DropdownMenuItem<String>(
            value: 'Dart',
            child: Text('Dart'),
          ),
          DropdownMenuItem<String>(
            value: 'Kotlin',
            child: Text('Kotlin'),
          ),
          DropdownMenuItem<String>(
            value: 'Swift',
            child: Text('Swift'),
          ),
        ],
        value: language,
        hint: const Text('Select Language'),
        onChanged: (String? value) {
          setState(() {
            language = value;
          });
        },
      ),
    );
  }
}


            // Container(
            //   padding: const EdgeInsets.all(16.0),
            //   child: ElevatedButton(
            //     child: const Text('Tombol'),
            //     onPressed: () {},
            //   ),
            // ),
            // Container(
            //   padding: const EdgeInsets.all(16.0),
            //   child: TextButton(
            //     child: const Text('Text Button'),
            //     onPressed: () {},
            //   ),
            // ),
            // Container(
            //   padding: const EdgeInsets.all(16.0),
            //   child: OutlinedButton(
            //     child: const Text('Outlined Button'),
            //     onPressed: () {},
            //   ),
            // ),
            // Container(
            //   padding: const EdgeInsets.all(16.0),
            //   child: IconButton(
            //     onPressed: () {},
            //     icon: const Icon(Icons.volume_up),
            //     tooltip: 'Increase volume by 10',
            //   ),
            // )