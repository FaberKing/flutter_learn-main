import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class AuthRepository {
  final String userToken = 'token';
  final SharedPreferences sharedPreferences;

  AuthRepository({required this.sharedPreferences});

  LoginResult userStorage() {
    final value = sharedPreferences.getString(userToken) ?? '';
    return LoginResult.fromRawJson(value);
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
}
