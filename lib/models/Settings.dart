import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting {
  final String title;
  final IconData icon;

  Setting({
    required this.title,
    required this.icon,
  });
}

final List<Setting> settings = [
  Setting(
    title: "Personal Data",
    icon: CupertinoIcons.person_fill,
  ),
  Setting(
    title: "Settings",
    icon: Icons.settings,
  ),
  Setting(
    title: "Privacy",
    icon: CupertinoIcons.lock_fill,
  ),
];

final List<Setting> settings2 = [
  Setting(
    title: "FAQ",
    icon: CupertinoIcons.ellipsis_vertical_circle_fill,
  ),
  Setting(
    title: "Our Handbook",
    icon: CupertinoIcons.pencil_circle_fill,
  ),
  Setting(
    title: "About Us",
    icon: CupertinoIcons.person_3_fill,
  ),
  Setting(
    title: "Logout",
    icon: Icons.logout,
  ),
];
