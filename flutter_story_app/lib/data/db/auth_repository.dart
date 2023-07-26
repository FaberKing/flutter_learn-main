import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_result.dart';

class AuthRepository {
  final String userToken = 'token';
  final String userLocale = 'locale';
  final SharedPreferences sharedPreferences;

  AuthRepository({required this.sharedPreferences});

  LoginResult userStorage() {
    final value = sharedPreferences.getString(userToken) ?? '';
    return LoginResult.fromJson(json.decode(value));
  }

  bool isUserLoggin() {
    return sharedPreferences.getString(userToken)?.isNotEmpty ?? false;
  }

  Future<void> login(LoginResult token) async {
    await sharedPreferences.setString(userToken, jsonEncode(token));
  }

  Future<void> logout() async {
    await sharedPreferences.remove(userToken);
  }

  Future<bool> setLocale(Map<String, dynamic> value) async {
    String string = jsonEncode(value);
    return await sharedPreferences.setString(userLocale, string);
  }

  Future<Map<String, dynamic>?> getLocale() async {
    if (!sharedPreferences.containsKey(userLocale)) {
      return null;
    }
    String? string = sharedPreferences.getString(userLocale);
    if (string == null) {
      return null;
    }
    Map<String, dynamic> value = jsonDecode(string);
    return value;
  }
}
