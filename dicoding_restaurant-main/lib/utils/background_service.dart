import 'dart:developer';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:ui';
import 'package:dicoding_restaurant/data/api/api_services.dart';
import 'package:http/http.dart' as http;

import 'package:dicoding_restaurant/main.dart';
import 'package:dicoding_restaurant/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    log('Alarm Fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var resultList = await ApiService().fullRestaurantList(http.Client());
    int randomRestaurant = math.Random().nextInt(resultList.restaurants.length);
    var resultEnd = resultList.restaurants[randomRestaurant];
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, resultEnd);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
