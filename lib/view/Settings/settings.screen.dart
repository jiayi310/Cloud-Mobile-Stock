import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/utils/loading.dart';
import 'package:mobilestock/view/Settings/settings.title.dart';
import 'package:mobilestock/view/Settings/support.card.dart';

import '../../../models/Settings.dart';
import '../../api/base.client.dart';
import '../../../utils/global.colors.dart';
import '../../models/User.dart';
import '../../models/UserCompanyLoginSelectionDto.dart';
import 'avatar.card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final storage = new FlutterSecureStorage();
  String? username;

  UserCompanyLoginSelectionDto company = new UserCompanyLoginSelectionDto(
      userMappingID: 0,
      userTypeID: 0,
      type: null,
      companyName: "Agiliti",
      isDeletedTemporarily: true);
  User user = new User();
  Uint8List? bytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              FutureBuilder(
                  future: getData(),
                  builder: (context, snapshort) {
                    if (snapshort.hasData) {
                      return AvatarCard(
                        user: user,
                        company: company,
                        bytes: bytes,
                      );
                    } else
                      return const LoadingPage();
                  }),
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

  Future<User> getData() async {
    String? _company2 = await storage.read(key: "company");
    String? _username2 = await storage.read(key: "username");
    String? _userid = await storage.read(key: "userid");
    UserCompanyLoginSelectionDto _company =
        UserCompanyLoginSelectionDto.deserialize(_company2!);

    final resp = await BaseClient()
        .get('/User/GetUser?userId=' + _userid.toString() + '');
    Map<String, dynamic> valueMap = json.decode(resp);
    User _user = User.fromJson(valueMap);

    setState(() {
      user = _user;
      bytes = Base64Decoder().convert(user.profileImage.toString());
      company = _company;
      username = _username2;
    });

    return user;
  }
}
