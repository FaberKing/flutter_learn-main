import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/localizations_call.dart';
import '../data/provider/localization_provider.dart';
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
            final flag = Localization.getFlag(locale.languageCode);

            return DropdownMenuItem(
              value: locale,
              child: Center(
                child: Text(
                  flag,
                ),
              ),
              onTap: () =>
                  ref.read(localizationProvider.notifier).state = locale,
            );
          }).toList(),
          onChanged: (value) {},
        );
      },
    ));
  }
}
