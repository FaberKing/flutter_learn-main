import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_restaurant/common/navigation.dart';
import 'package:dicoding_restaurant/common/styles.dart';
import 'package:dicoding_restaurant/common/text_theme.dart';
import 'package:dicoding_restaurant/data/model/restaurant.dart';
import 'package:dicoding_restaurant/data/provider/shared_preference_provider.dart';
import 'package:dicoding_restaurant/ui/restaurant_detail_page.dart';
import 'package:dicoding_restaurant/ui/start_page.dart';
import 'package:dicoding_restaurant/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final sharedPreferences = await SharedPreferences.getInstance();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant Dicode',
      theme: ThemeData(
        textTheme: myTextTheme,
        appBarTheme: const AppBarTheme(elevation: 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: Theme.of(context).colorScheme.copyWith(
            surfaceVariant: secondaryColor.withOpacity(0.1),
            primary: primaryColor,
            onPrimary: Colors.black,
            secondary: secondaryColor),
      ),
      initialRoute: StartPage.routeName,
      navigatorKey: navigatorKey,
      routes: {
        StartPage.routeName: (context) => const StartPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurantItem:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
