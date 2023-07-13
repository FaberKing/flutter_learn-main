import 'package:flutter_story_app/data/model/auth_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_provider.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authProvider = ref.watch(authStateProvider);
  return authProvider.result == AuthResult.success;
});
