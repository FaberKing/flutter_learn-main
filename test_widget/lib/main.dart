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
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late String selectedValue; // **FOR DEFAULT VALUE**
  late String selectedValue2;
  List<String> dropDownItemValue = ['123', '2', '4', 'Create'];
  List<String> dropDownItemValue2 = ['xx', '2', '4'];

  late final dropDownKey2;

  final FocusNode dropDownFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    ///selected value must be contain at dropDownItemValue
    selectedValue = dropDownItemValue[0];
    selectedValue2 = dropDownItemValue2[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // MyTabBar(),

            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue, // CANT SET THE DEFAULT VALUE**
                isExpanded: true,
                // icon: Image.asset('assets/down-list-arrow.png'),
                iconSize: 10,
                elevation: 16,
                onChanged: (newValue) {
                  print(newValue);
                  setState(() {
                    selectedValue = newValue!; //   SET THE DEFAULT VALUE**
                  });
                },

                /// dont assing same value on multiple widget
                items: List.generate(
                  dropDownItemValue.length,
                  (index) => DropdownMenuItem(
                      child: Text('${dropDownItemValue[index]}'),
                      value: '${dropDownItemValue[index]}'),
                ),
              ),
            ),

            SizedBox(
              height: 100,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                focusNode: dropDownFocus,
                value: selectedValue2, // CANT SET THE DEFAULT VALUE**
                isExpanded: true,
                // icon: Image.asset('assets/down-list-arrow.png'),
                iconSize: 10,
                elevation: 16,
                onChanged: (newValue) {
                  print(newValue == null);
                  // if value doesnt contain just close the dropDown
                  if (newValue == null) {
                    dropDownFocus.unfocus();
                  } else
                    setState(() {
                      selectedValue2 = newValue; //   SET THE DEFAULT VALUE**
                    });
                },

                /// dont assing same value on multiple widget
                items: List.generate(
                  dropDownItemValue2.length + 1,
                  (index) => index < dropDownItemValue2.length
                      ? DropdownMenuItem(
                          child: Text('${dropDownItemValue2[index]}'),
                          value: '${dropDownItemValue2[index]}')
                      : DropdownMenuItem(
                          child: TextButton(
                            child: Text('Create'),
                            onPressed: () {},
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
