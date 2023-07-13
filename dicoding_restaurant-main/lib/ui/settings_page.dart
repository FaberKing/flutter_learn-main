import 'dart:io';

import 'package:dicoding_restaurant/data/provider/preferences_daily_reminder_provider.dart';
import 'package:dicoding_restaurant/widgets/platform_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({super.key});

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: const Text('Scheduling News'),
            trailing: Consumer(
              builder: (context, ref, child) {
                final isReminderActive = ref.watch(asyncDailyReminderProvider);
                return isReminderActive.when(
                  data: (data) {
                    return Switch.adaptive(
                      value: data,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          null;
                        } else {
                          ref
                              .read(asyncDailyReminderProvider.notifier)
                              .setDailyReminder(value);
                        }
                      },
                    );
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformHelper(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
