import 'dart:convert';

import 'package:course_dilaundry/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSession {
  static const _key = 'user';
  static Future<UserModel?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString(_key);
    if (userString == null) return null;

    var userMap = jsonDecode(userString);
    return UserModel.fromJson(userMap);
  }

  static Future<bool> setUser(Map userMap) async {
    final pref = await SharedPreferences.getInstance();
    String userString = jsonEncode(userMap);
    bool success = await pref.setString(_key, userString);
    return success;
  }

  static Future<bool> removeUser() async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove(_key);
    return success;
  }

  static Future<String?> getBearerToken() async {
    final pref = await SharedPreferences.getInstance();
    String? success = pref.getString('bearer_token');
    return success;
  }

  static Future<bool> setBearerToken(String bearerToken) async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.setString('bearer_token', bearerToken);
    return success;
  }

  static Future<bool> removeBearerToken() async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('bearer_token');
    return success;
  }
}
