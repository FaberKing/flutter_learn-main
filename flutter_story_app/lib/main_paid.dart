import 'package:flutter/material.dart';
import 'package:flutter_story_app/utils/state_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/model/flavor_config.dart';
import 'data/provider/shared_preference_provider.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    flavor: FlavorType.paid,
    color: Colors.amber,
    values: const FlavorValues(
      titleApp: "Paid App",
      check: true,
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
