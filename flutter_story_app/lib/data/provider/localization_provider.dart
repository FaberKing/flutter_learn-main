import 'package:flutter/material.dart';
import 'package:flutter_story_app/data/provider/shared_preference_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/auth_repository.dart';

final localizationStateProvider =
    StateNotifierProvider<LocalizationStateNotifier, Locale>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return LocalizationStateNotifier(
    sharedPreferences,
  );
});

class LocalizationStateNotifier extends StateNotifier<Locale> {
  final SharedPreferences? sharedPreferences;
  LocalizationStateNotifier(this.sharedPreferences)
      : super(const Locale('id')) {
    if (sharedPreferences != null) {
      final AuthRepository authRepository =
          AuthRepository(sharedPreferences: sharedPreferences!);
      state = Locale(authRepository.getLocale()) ?? const Locale('id');
    }
  }

  void changeLocale(Locale locale) {
    state = locale;
  }
}
