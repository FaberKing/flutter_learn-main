import 'dart:convert';

import 'package:course_asset_management/config/app_constant.dart';
import 'package:course_asset_management/page/asset/home_page.dart';
import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final editUsername = TextEditingController();
  final editPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Uri url = Uri.parse(
        '${AppConstant.baseUrl}/user/login.php',
      );
      http.post(
        url,
        body: {
          'username': editUsername.text,
          'password': editPassword.text,
        },
      ).then((response) {
        DMethod.printResponse(response);

        Map resBody = jsonDecode(response.body);

        bool isSuccess = resBody['success'] ?? false;
        if (isSuccess) {
          DInfo.toastSuccess('Login Berhasil');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          DInfo.toastError('Login Gagal');
        }
      }).catchError((error, stackTrace) {
        DInfo.toastError('Something Error');
        DMethod.printBasic(error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -60,
            left: -60,
            child: CircleAvatar(
              radius: 120,
              backgroundColor: Colors.purple[300],
            ),
          ),
          Positioned(
            bottom: -90,
            right: -60,
            child: CircleAvatar(
              radius: 120,
              backgroundColor: Colors.purple[300],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            child: Icon(
              Icons.scatter_plot,
              color: Colors.purple[400],
              size: 90,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppConstant.appName.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.purple[700],
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: editUsername,
                    validator: (value) => value == '' ? 'Jangan Kosong' : null,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      isDense: true,
                      hintText: 'Username',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: editPassword,
                    obscureText: true,
                    validator: (value) => value == '' ? 'Jangan Kosong' : null,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      isDense: true,
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => login(context),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
