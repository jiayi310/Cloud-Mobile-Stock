import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/view/Settings/settings.constant.dart';

import '../../api/base.client.dart';
import '../../models/User.dart';
import '../../models/UserCompanyLoginSelectionDto.dart';

class AvatarCard extends StatefulWidget {
  AvatarCard({required this.user, required this.company, required this.bytes});
  UserCompanyLoginSelectionDto company;
  User user;
  Uint8List? bytes;

  @override
  State<AvatarCard> createState() =>
      _AvatarCardState(user: user, company: company, bytes: bytes);
}

class _AvatarCardState extends State<AvatarCard> {
  _AvatarCardState(
      {required this.user, required this.company, required this.bytes});

  UserCompanyLoginSelectionDto company;
  User user;
  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (user.profileImage != null && user.profileImage != "")
          ClipOval(
              child: Image.memory(
            bytes!,
            width: 70,
            height: 70,
          )),
        if (user.profileImage == null || user.profileImage == "")
          ClipOval(
              child: Image.asset(
            "assets/images/avatar.png",
            width: 70,
            height: 70,
          )),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user.name ?? "",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kprimaryColor,
              ),
            ),
            Text(
              company.companyName.toString() ?? "",
              style: TextStyle(
                fontSize: ksmallFontSize,
                color: Colors.grey.shade600,
              ),
            )
          ],
        )
      ],
    );
  }
}
