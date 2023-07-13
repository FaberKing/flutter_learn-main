import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_story_app/data/api/auth_services.dart';
import 'package:flutter_story_app/data/db/auth_repository.dart';
import 'package:flutter_story_app/data/model/auth_result.dart';
import 'package:flutter_story_app/data/model/auth_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authServices = const AuthServices();
  late AuthRepository _authRepository;

  final SharedPreferences sharedPrerences;

  AuthStateNotifier({required this.sharedPrerences})
      : super(const AuthState.unknown()) {
    _authRepository = AuthRepository(sharedPreferences: sharedPrerences);

    if (_authRepository.isUserLoggin()) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userData: _authRepository.userStorage(),
      );
    }
  }

  Future<String> userRegister(
      String name, String email, String password) async {
    state = state.copiedWithIsLoading(true);
    try {
      await _authRepository.logout();
      final apiResponse =
          await _authServices.registerWithEmailPassword(name, email, password);
      state = const AuthState.unknown();

      return apiResponse.message;
    } on SocketException catch (_) {
      return 'No Internet Connection';
    } catch (e) {
      state = const AuthState(
        result: AuthResult.failure,
        isLoading: false,
        userData: null,
      );
      return e.toString();
    }
  }

  Future<void> userLogout() async {
    state = state.copiedWithIsLoading(true);
    await _authRepository.logout();
    state = const AuthState.unknown();
  }

  Future<void> userLogin(
      String email, String password, BuildContext context) async {
    state = state.copiedWithIsLoading(true);
    try {
      final apiResponse =
          await _authServices.loginWithEmailPassword(email, password);
      if (apiResponse.message == 'success' &&
          apiResponse.loginResult.token.isNotEmpty) {
        await _authRepository.login(apiResponse.loginResult);
      }
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userData: apiResponse.loginResult);
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Internet Connection"),
        ),
      );
    } catch (e) {
      state = const AuthState(
        result: AuthResult.failure,
        isLoading: false,
        userData: null,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
