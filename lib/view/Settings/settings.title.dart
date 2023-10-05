import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/view/Settings/about.us.dart';
import 'package:mobilestock/view/Settings/settings.constant.dart';

import '../../../models/Settings.dart';

class SettingTile extends StatelessWidget {
  final Setting setting;
  const SettingTile({
    super.key,
    required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (setting.title == "About Us")
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutUs()),
          );
      }, // Navigation
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: klightContentColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(setting.icon, color: kprimaryColor),
            ),
            const SizedBox(width: 20),
            Text(
              setting.title,
              style: const TextStyle(
                color: kprimaryColor,
                fontSize: ksmallFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.chevron_forward,
              color: kprimaryColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
