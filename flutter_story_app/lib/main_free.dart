import 'package:flutter/material.dart';
import 'package:flutter_story_app/data/model/flavor_config.dart';
import 'package:flutter_story_app/my_app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/provider/shared_preference_provider.dart';
import 'utils/state_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    flavor: FlavorType.free,
    color: Colors.blue,
    values: const FlavorValues(
      titleApp: "Free App",
      check: false,
    ),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    observers: const [StateLogger()],
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: const MyApp(),
  ));
}
