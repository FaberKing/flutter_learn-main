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
    bool check = false;
    bool check1 = false;

    return ListView(
      children: [
        // Material(
        //   child: ListTile(
        //     title: const Text('Dark Theme'),
        //     trailing: Switch.adaptive(
        //       value: check,
        //       onChanged: (value) {
        //         check = value;
        //       },

        //     ),
        //   ),
        // ),
        Material(
          child: ListTile(
            title: const Text('Scheduling News'),
            trailing: Switch.adaptive(
              value: check1,
              onChanged: (value) async {
                // if (Platform.isIOS) {
                //   customDialog(context);
                // } else {
                //   scheduled.scheduledNews(value);
                //   provider.enableDailyNews(value);
                // }
                check1 = value;
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
