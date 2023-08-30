import 'package:flutter/material.dart';

class Nav {
  static push(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  static pushReplace(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
}
