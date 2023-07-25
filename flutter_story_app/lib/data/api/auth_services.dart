import 'dart:convert';

import 'package:flutter_story_app/data/model/api_response.dart';
import 'package:flutter_story_app/data/model/user.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  const AuthServices();
  static const String _baseUrl = "https://story-api.dicoding.dev/v1";
  static const String _register = "/register";
  static const String _login = "/login";
  static var client = http.Client();

  Future<ApiResponse> registerWithEmailPassword(
      String name, String email, String password) async {
    final url = Uri.parse("$_baseUrl$_register");

    final response = await client.post(url, body: <String, String>{
      'name': name,
      'email': email,
      'password': password
    });

    final responseBody = ApiResponse.fromJson(
      json.decode(utf8.decode(response.bodyBytes)),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseBody;
      default:
        throw Exception(responseBody.message);
    }
  }

  Future<User> loginWithEmailPassword(String email, String password) async {
    final url = Uri.parse("$_baseUrl$_login");

    final response = await client.post(url,
        body: <String, String>{'email': email, 'password': password});

    switch (response.statusCode) {
      case 200:
      case 201:
        return User.fromJson(
          json.decode(utf8.decode(response.bodyBytes)),
        );
      default:
        final responseBody = ApiResponse.fromJson(json.decode(response.body));

        throw Exception(responseBody.message);
    }
  }
}
