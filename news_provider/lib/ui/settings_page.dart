import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_provider/provider/preferences_provider.dart';
import 'package:news_provider/provider/schedulling_provider.dart';
import 'package:news_provider/widgets/custom_dialog.dart';
import 'package:news_provider/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesNotifier>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                  },

                  // defaultTargetPlatform == TargetPlatform.iOS
                  //     ? showCupertinoDialog(
                  //         context: context,
                  //         barrierDismissible: true,
                  //         builder: (context) {
                  //           return CupertinoAlertDialog(
                  //             title: const Text('Coming Soon!'),
                  //             content:
                  //                 const Text('This feature will be coming soon!'),
                  //             actions: [
                  //               CupertinoDialogAction(
                  //                 child: const Text('Ok'),
                  //                 onPressed: () {
                  //                   Navigator.pop(context);
                  //                 },
                  //               ),
                  //             ],
                  //           );
                  //         },
                  //       )
                  //     : showDialog(
                  //         context: context,
                  //         builder: (context) {
                  //           return AlertDialog(
                  //             title: const Text('Coming Soon!'),
                  //             content:
                  //                 const Text('This feature will be coming soon!'),
                  //             actions: [
                  //               TextButton(
                  //                 onPressed: () {
                  //                   Navigator.pop(context);
                  //                 },
                  //                 child: const Text('Ok'),
                  //               ),
                  //             ],
                  //           );
                  //         },
                  //       );
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: const Text('Scheduling News'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyNewsActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledNews(value);
                          provider.enableDailyNews(value);
                        }
                      },
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
