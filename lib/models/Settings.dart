import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting {
  final String title;
  final String route;
  final IconData icon;

  Setting({
    required this.title,
    required this.route,
    required this.icon,
  });
}

final List<Setting> settings = [
  Setting(
    title: "Personal Data",
    route: "/",
    icon: CupertinoIcons.person_fill,
  ),
  Setting(
    title: "Settings",
    route: "/",
    icon: Icons.settings,
  ),
  Setting(
    title: "Document Numbering",
    route: "/",
    icon: CupertinoIcons.doc_fill,
  ),
  Setting(
    title: "Privacy",
    route: "/",
    icon: CupertinoIcons.lock_fill,
  ),
];

final List<Setting> settings2 = [
  Setting(
    title: "FAQ",
    route: "/",
    icon: CupertinoIcons.ellipsis_vertical_circle_fill,
  ),
  Setting(
    title: "Our Handbook",
    route: "/",
    icon: CupertinoIcons.pencil_circle_fill,
  ),
  Setting(
    title: "About Us",
    route: "/",
    icon: CupertinoIcons.person_3_fill,
  ),
];
