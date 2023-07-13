import 'package:flutter_story_app/data/model/auth_state.dart';
import 'package:flutter_story_app/data/provider/auth_notifier.dart';
import 'package:flutter_story_app/data/provider/shared_preference_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final sharedPrerences = ref.watch(sharedPreferencesProvider);
  return AuthStateNotifier(sharedPrerences: sharedPrerences);
});
