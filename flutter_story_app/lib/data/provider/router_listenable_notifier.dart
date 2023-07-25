import 'package:flutter/material.dart';
import 'package:flutter_story_app/data/model/auth_state.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/auth_result.dart';
import 'auth_provider.dart';
import 'is_loggin_provider.dart';

class RouterListenableNotifier extends AsyncNotifier<void>
    implements Listenable {
  VoidCallback? _routerListener;
  bool isLoggin = false;
  AuthState authProvider = const AuthState.unknown();

  @override
  Future<void> build() async {
    authProvider = await ref.watch(authStateProvider);
    isLoggin = await ref.watch(isLoggedInProvider);

    ref.listenSelf((previous, next) {
      if (state.isLoading) return;
      _routerListener?.call();
    });
  }

  String? redirect(BuildContext context, GoRouterState state) {
    if (authProvider.isLoading == true ||
        authProvider.result == AuthResult.failure ||
        authProvider.result == AuthResult.aborted) return null;

    final isSplash = state.uri.toString() == '/splash';
    final isLogginIn = state.uri.toString() == '/login';
    final isRegisterIn = state.uri.toString() == '/register';

    if (isSplash) {
      return isLoggin ? '/story' : '/login';
    }

    if (isLogginIn) return isLoggin ? '/story' : null;

    if (isRegisterIn) return isLoggin ? '/story' : null;

    return isLoggin ? null : '/login';
  }

  @override
  void addListener(VoidCallback listener) {
    _routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _routerListener = null;
  }
}
