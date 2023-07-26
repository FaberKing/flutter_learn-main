import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/localizations_call.dart';
import '../locale/localization_state_provider.dart';
import '../utils/localization.dart';

class FlagIconWidget extends StatelessWidget {
  const FlagIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(child: Consumer(
      builder: (context, ref, child) {
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
                // await authRepository.setLocale(locale.toString());
                // ref
                //     .read(localizationStateProvider.notifier)
                //     .changeLocale(locale);
                ref.read(localizationStateProvider.notifier).setLocale(locale);
              },
            );
          }).toList(),
          onChanged: (value) {},
        );
      },
    ));
  }
}
