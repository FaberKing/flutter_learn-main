import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_story_app/data/model/auth_result.dart';
import 'package:flutter_story_app/data/model/user.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final LoginResult? userData;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userData,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userData = null;

  AuthState copiedWithIsLoading(bool isLoading) => AuthState(
        result: result,
        isLoading: isLoading,
        userData: userData,
      );
}
