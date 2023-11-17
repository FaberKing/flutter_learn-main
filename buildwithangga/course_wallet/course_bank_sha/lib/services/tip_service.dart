import 'dart:convert';

import 'package:course_bank_sha/model/tip_model.dart';
import 'package:course_bank_sha/services/auth_service.dart';
import 'package:course_bank_sha/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class TipService {
  Future<List<TipsModel>> getTips() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(Uri.parse('$baseUrl/tips'), headers: {
        'Authorization': token,
      });

      if (res.statusCode == 200) {
        return List<TipsModel>.from(
          jsonDecode(res.body)['data'].map(
            (data) => TipsModel.fromJson(data),
          ),
        ).toList();
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
