import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_story_app/common/localizations_call.dart';
import 'package:flutter_story_app/data/provider/shared_preference_provider.dart';
import 'package:flutter_story_app/locale/local_json_converter.dart';
import 'package:flutter_story_app/locale/persistent_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db/auth_repository.dart';

part 'localization_state_provider.freezed.dart';
part 'localization_state_provider.g.dart';

@freezed
class LocaleState with _$LocaleState, PersistentState<LocaleState> {
  const factory LocaleState({
    @LocaleJsonConverter() @Default(Locale('ui')) @JsonKey() Locale locale,
  }) = _LocaleState;

  const LocaleState._();

  factory LocaleState.fromJson(Map<String, dynamic> json) =>
      _$LocaleStateFromJson(json);

  @override
  Future<LocaleState?> fromStorage() async {
    try {
      final AuthRepository authRepository = AuthRepository(
          sharedPreferences: await SharedPreferences.getInstance());
      var value = await authRepository.getLocale();
      if (value == null) {
        return null;
      }
      var data = LocaleState.fromJson(value);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> localSave() async {
    Map<String, dynamic> value = toJson();
    try {
      final AuthRepository authRepository = AuthRepository(
          sharedPreferences: await SharedPreferences.getInstance());
      return await authRepository.setLocale(value);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}

final localizationStateProvider =
    StateNotifierProvider<LocalizationStateNotifier, LocaleState>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return LocalizationStateNotifier(
      sharedPreferences: sharedPreferences, ref: ref);
});

class LocalizationStateNotifier extends StateNotifier<LocaleState> {
  final SharedPreferences sharedPreferences;
  final StateNotifierProviderRef ref;
  LocalizationStateNotifier(
      {required this.sharedPreferences, required this.ref})
      : super(const LocaleState());

  Future<void> initLocale() async {
    bool fromStorageSuccess =
        await ref.read(localizationStateProvider.notifier).restoreFromStorage();

    if (!fromStorageSuccess) {
      ref
          .read(localizationStateProvider.notifier)
          .setLocale(const Locale('id'));
    }
  }

  void setLocale(Locale locale) {
    List<Locale> supportedLocales = AppLocalizations.supportedLocales;
    if (supportedLocales.contains(locale)) {
      state = state.copyWith(locale: locale);

      state.localSave();
      return;
    }
    return;
  }

  Future<bool> restoreFromStorage() async {
    try {
      LocaleState? localeResult = await state.fromStorage();

      if (localeResult == null) {
        return false;
      }

      state = localeResult;

      return true;
    } catch (e, stk) {
      log("Error : ${e.toString()}");
      log(stk.toString());
      return false;
    }
  }
}
