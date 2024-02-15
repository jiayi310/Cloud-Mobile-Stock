import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../api/base.client.dart';
import '../../models/User.dart';
import '../../models/UserCompanyLoginSelectionDto.dart';
import '../../utils/global.colors.dart';
import '../../utils/loading.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({Key? key}) : super(key: key);

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
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
          "Personal Data",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: getData(),
                  builder: (context, snapshort) {
                    if (snapshort.hasData) {
                      return Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                if (user.profileImage == null ||
                                    user.profileImage == "")
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/images/avatar.png",
                                      ),
                                    ),
                                  ),
                                if (user.profileImage != null &&
                                    user.profileImage != "")
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: ClipOval(
                                      child: Image.memory(
                                        bytes!,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              user.name ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              user.email ?? "",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              company.companyName.toString() ?? "",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              user.phone ?? "",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: GlobalColors.mainColor,
                                  side: BorderSide.none,
                                  shape: StadiumBorder(),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Edit Profile",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else
                      return const LoadingPage();
                  }),
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
