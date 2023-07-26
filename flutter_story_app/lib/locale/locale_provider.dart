import 'package:flutter/material.dart';
import 'package:flutter_story_app/locale/localization_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final localeProvider = Provider<Locale>((ref) {
  return ref.watch(localizationStateProvider).locale;
});
