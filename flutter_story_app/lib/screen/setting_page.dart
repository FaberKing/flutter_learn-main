import 'package:flutter/material.dart';
import 'package:flutter_story_app/widgets/flag_icon_widget.dart';

import '../common/localizations_call.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleAppBarSetting),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.settingTextLanguage),
            trailing: const FlagIconWidget(),
          ),
        ],
      ),
    );
  }
}
