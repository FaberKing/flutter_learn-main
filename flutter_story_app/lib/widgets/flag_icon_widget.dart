import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/localizations_call.dart';
import '../data/db/auth_repository.dart';
import '../data/provider/localization_provider.dart';
import '../data/provider/shared_preference_provider.dart';
import '../utils/localization.dart';

class FlagIconWidget extends StatelessWidget {
  const FlagIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(child: Consumer(
      builder: (context, ref, child) {
        final sharedPrerences = ref.watch(sharedPreferencesProvider);
        final AuthRepository authRepository =
            AuthRepository(sharedPreferences: sharedPrerences);
        return DropdownButton(
          icon: const Icon(Icons.flag_circle_rounded, size: 35),
          items: AppLocalizations.supportedLocales.map((Locale locale) {
            log(locale.toString());
            final flag = Localization.getFlag(locale.languageCode);
            return DropdownMenuItem(
              value: locale,
              child: Center(
                child: Text(
                  flag,
                ),
              ),
              onTap: () async {
                await authRepository.setLocale(locale.toString());
                ref
                    .read(localizationStateProvider.notifier)
                    .changeLocale(locale);
              },
            );
          }).toList(),
          onChanged: (value) {},
        );
      },
    ));
  }
}
