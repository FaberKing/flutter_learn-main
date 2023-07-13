import 'dart:async';
import 'dart:developer';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_restaurant/data/provider/shared_preference_provider.dart';
import 'package:dicoding_restaurant/preferences/preferences_helper.dart';
import 'package:dicoding_restaurant/utils/background_service.dart';
import 'package:dicoding_restaurant/utils/date_time_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncDailyReminderNotifier extends AsyncNotifier<bool> {
  Future<bool> _getDailyReminder() async {
    PreferencesHelper preferencesHelper = PreferencesHelper(
        sharedPreferences: ref.read(sharedPreferencesProvider));

    final value = await preferencesHelper.isDailyReminderActive();

    if (value) {
      log('Scheduling Restaurant Activated');

      await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      log('Scheduling Restaurant Canceled');
      await AndroidAlarmManager.cancel(1);
    }

    return value;
  }

  @override
  FutureOr<bool> build() async {
    return _getDailyReminder();
  }

  Future<void> setDailyReminder(bool value) async {
    PreferencesHelper preferencesHelper = PreferencesHelper(
        sharedPreferences: ref.read(sharedPreferencesProvider));
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await preferencesHelper.setDailyReminder(value);
      return _getDailyReminder();
    });
  }
}

final asyncDailyReminderProvider =
    AsyncNotifierProvider<AsyncDailyReminderNotifier, bool>(() {
  return AsyncDailyReminderNotifier();
});
