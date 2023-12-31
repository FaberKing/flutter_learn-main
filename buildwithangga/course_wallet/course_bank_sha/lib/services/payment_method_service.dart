import 'dart:convert';

import 'package:course_bank_sha/model/payment_method_model.dart';
import 'package:course_bank_sha/services/auth_service.dart';
import 'package:course_bank_sha/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class PaymentMethodService {
  Future<List<PaymentMethodModel>> getPaymentMedthods() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse('$baseUrl/payment_methods'),
        headers: {
          'Authorization': token,
        },
      );
      if (res.statusCode == 200) {
        return List<PaymentMethodModel>.from(
          jsonDecode(res.body).map(
            (e) => PaymentMethodModel.fromJson(e),
          ),
        ).toList();
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
