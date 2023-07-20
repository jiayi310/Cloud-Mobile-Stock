import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/view/Settings/settings.title.dart';
import 'package:mobilestock/view/Settings/support.card.dart';

import '../../../models/Settings.dart';
import '../../../utils/global.colors.dart';
import 'avatar.card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AvatarCard(),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              Column(
                children: List.generate(
                  settings.length,
                  (index) => SettingTile(setting: settings[index]),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Column(
                children: List.generate(
                  settings2.length,
                  (index) => SettingTile(setting: settings2[index]),
                ),
              ),
              const SizedBox(height: 20),
              const SupportCard(),
              const SizedBox(height: 50),
              Center(child: Text("ver 3.1.1"))
            ],
          ),
        ),
      ),
    );
  }
}
