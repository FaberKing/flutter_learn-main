import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_restaurant/common/navigation.dart';
import 'package:dicoding_restaurant/common/styles.dart';
import 'package:dicoding_restaurant/common/text_theme.dart';
import 'package:dicoding_restaurant/data/model/restaurant_detail.dart';
import 'package:dicoding_restaurant/ui/restaurant_detail_page.dart';
import 'package:dicoding_restaurant/ui/restaurant_list_page.dart';
import 'package:dicoding_restaurant/ui/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Dicode',
      theme: ThemeData(
        textTheme: myTextTheme,
        appBarTheme: const AppBarTheme(elevation: 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primaryColor,
            onPrimary: Colors.black,
            secondary: secondaryColor),

        // primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      initialRoute: StartPage.routeName,
      routes: {
        StartPage.routeName: (context) => const StartPage(),
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
