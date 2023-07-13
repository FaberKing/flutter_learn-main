import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final SharedPreferences sharedPreferences;
  PreferencesHelper({required this.sharedPreferences});

  static const dailyNews = 'DAILY_NEWS';

  Future<bool> isDailyReminderActive() async {
    return sharedPreferences.getBool(dailyNews) ?? false;
  }

  Future<void> setDailyReminder(bool value) async {
    sharedPreferences.setBool(dailyNews, value);
  }
}
