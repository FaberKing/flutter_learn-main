import 'dart:convert';

import 'package:course_bank_sha/model/user_edit_form_model.dart';
import 'package:course_bank_sha/model/user_model.dart';
import 'package:course_bank_sha/services/auth_service.dart';
import 'package:course_bank_sha/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<void> updateUser(UserEditFormModel data) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.put(
        Uri.parse('$baseUrl/users'),
        body: data.toJson(),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getRecentUsers() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse(
          '$baseUrl/transfer_histories',
        ),
        headers: {
          'Authorization': token,
        },
      );
      if (res.statusCode == 200) {
        // return List<UserModel>.from(
        //   jsonDecode(res.body)['data'],
        // );

        List<UserModel> users = List<UserModel>.from(
          jsonDecode(res.body)['data'].map(
            (user) => UserModel.fromJson(user),
          ),
        ).toList();

        return users;
      }
      return throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> geUsersByUsername(String username) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse(
          '$baseUrl/users/$username',
        ),
        headers: {
          'Authorization': token,
        },
      );
      if (res.statusCode == 200) {
        // return List<UserModel>.from(
        //   jsonDecode(res.body),
        // )
        //     .map(
        //       (e) => UserModel.fromJson(e as Map<String, dynamic>),
        //     )
        //     .toList();

        List<UserModel> users = List<UserModel>.from(
          jsonDecode(res.body).map(
            (user) => UserModel.fromJson(user),
          ),
        ).toList();

        return users;
      }
      return throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
