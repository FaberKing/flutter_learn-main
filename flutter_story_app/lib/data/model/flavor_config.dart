import 'package:flutter/material.dart';

enum FlavorType {
  free,
  paid,
}

class FlavorValues {
  final String titleApp;
  final bool check;

  const FlavorValues({
    this.titleApp = "Free App",
    this.check = false,
  });
}

class FlavorConfig {
  final FlavorType flavor;
  final MaterialColor color;
  final FlavorValues values;

  static FlavorConfig? _instance;

  FlavorConfig({
    this.flavor = FlavorType.free,
    this.color = Colors.orange,
    this.values = const FlavorValues(),
  }) {
    _instance = this;
  }

  static FlavorConfig get instance => _instance ?? FlavorConfig();
}
