import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobilestock/api/base.client.dart';
import 'package:mobilestock/models/UserCompanyLoginSelectionDto.dart';
import 'package:mobilestock/view/social.login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/global.colors.dart';
import 'home.view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  _LoginViewState({Key? key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  int i = 0;
  bool _validate = false;
  bool _validate2 = false;
  final storage = new FlutterSecureStorage();
  bool value = false;
  int userid = 0;

  int companyid = 0;
  List<UserCompanyLoginSelectionDto> companylist = [
    new UserCompanyLoginSelectionDto(
        userMappingID: 0,
        userTypeID: 0,
        type: null,
        comapanyName: "Select Company",
        isActive: true)
  ];
  UserCompanyLoginSelectionDto company = new UserCompanyLoginSelectionDto(
      userMappingID: 0,
      userTypeID: 0,
      type: null,
      comapanyName: "Select Company",
      isActive: true);

  UserCompanyLoginSelectionDto _company = new UserCompanyLoginSelectionDto(
      userMappingID: 0,
      userTypeID: 0,
      type: null,
      comapanyName: "Select Company",
      isActive: true);
  @override
  void initState() {
    super.initState();
    checkLogin();

    company = companylist[0];
  }

  void checkLogin() async {
    int token = await getToken();

    if (token == 1) {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(50, 80, 50, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/agiliti_logo.png',
                        height: 80)),
                const SizedBox(height: 30),
                Text(
                  'Login to your Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),

                ///Email Input
                Container(
                    height: 55,
                    padding: const EdgeInsets.only(top: 3, left: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 7,
                          )
                        ]),
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {
                          companylist = [
                            new UserCompanyLoginSelectionDto(
                                userMappingID: 0,
                                userTypeID: 0,
                                type: null,
                                comapanyName: "Select Company",
                                isActive: true)
                          ];
                        });
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Field cannot be empty' : null,
                          hintText: 'Email',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                          hintStyle: const TextStyle(
                            height: 1,
                          )),
                    )),
                const SizedBox(height: 20),

                ///Password Input
                Container(
                    height: 55,
                    padding: const EdgeInsets.only(top: 3, left: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 7,
                          )
                        ]),
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {
                          companylist = [
                            new UserCompanyLoginSelectionDto(
                                userMappingID: 0,
                                userTypeID: 0,
                                type: null,
                                comapanyName: "Select Company",
                                isActive: true)
                          ];
                        });
                      },
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          errorText:
                              _validate2 ? 'Field cannot be empty' : null,
                          hintText: 'Password',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                          hintStyle: const TextStyle(
                            height: 1,
                          )),
                    )),
                const SizedBox(height: 20),
                Container(
                  height: 55,
                  padding: const EdgeInsets.only(top: 3, left: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 7,
                        )
                      ]),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        getCompanyList();
                      });
                    },
                    child: DropdownButton<UserCompanyLoginSelectionDto>(
                      onTap: () {
                        getCompanyList();
                      },
                      value: company,
                      isExpanded: true,
                      onChanged: (UserCompanyLoginSelectionDto? newvalue) {
                        setState(() {
                          print("company " + newvalue!.comapanyName);
                          setState(() {
                            company.comapanyName = newvalue.comapanyName;
                            companyid = newvalue!.companyID!;
                          });
                        });
                      },
                      items: companylist
                          .map<DropdownMenuItem<UserCompanyLoginSelectionDto>>(
                              (UserCompanyLoginSelectionDto value2) {
                        return DropdownMenuItem<UserCompanyLoginSelectionDto>(
                          value: value2,
                          child: Text(value2.comapanyName!),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: this.value,
                        activeColor: GlobalColors.mainColor,
                        onChanged: (bool? value) {
                          setState(() {
                            this.value = value!;
                          });
                        }),
                    Text("Remember Me"),
                  ],
                ),

                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    setState(() {
                      emailController.text.isEmpty
                          ? _validate = true
                          : _validate = false;

                      passwordController.text.isEmpty
                          ? _validate2 = true
                          : _validate2 = false;
                    });
                    TextInput.finishAutofillContext();
                    fetchUsers();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    decoration: BoxDecoration(
                        color: GlobalColors.mainColor,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          )
                        ]),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                SocialLogin(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ver 3.1.0'),
          ],
        ),
      ),
    );
  }

  void fetchUsers() async {
    if (!emailController.text.isEmpty && !passwordController.text.isEmpty) {
      final resp = await BaseClient().get('/User/ValidateUserLogin?email=' +
          emailController.text +
          '&password=' +
          passwordController.text +
          '');

      setState(() {
        i = int.parse(resp.toString());
      });

      if (i > 0) {
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          if (company.comapanyName == "Select Company") {
            Fluttertoast.showToast(
              msg: "Please select a company.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
            if (value)
              storeTokenAndData(emailController.text, passwordController.text,
                  value, i, companyid, company);
            else
              storeTokenAndData(emailController.text, passwordController.text,
                  value, i, companyid, company);

            Fluttertoast.showToast(
              msg: "Login successfully.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
            );
          }
        }
      } else {
        Fluttertoast.showToast(
          msg: "Incorrect email and password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
        );
      }
    }
    print("userid: " + i.toString() + " companyid:" + companyid.toString());
  }

  Future<void> storeTokenAndData(
    String email,
    String usercredential,
    bool remember,
    int userid,
    int companyid,
    UserCompanyLoginSelectionDto company,
  ) async {
    await storage.write(key: "email", value: email);
    await storage.write(key: "usercredential", value: usercredential);
    await storage.write(key: "remember", value: remember.toString());
    await storage.write(key: "userid", value: userid.toString());
    await storage.write(key: "companyid", value: companyid.toString());
    await storage.write(
        key: "company", value: UserCompanyLoginSelectionDto.serialize(company));
    await BaseClient()
        .get('/User/UpdateMobileRemember?email=' + email! + '&grant=1');
  }

  Future<int> getToken() async {
    String? email = await storage.read(key: "email");
    String? pass = await storage.read(key: "usercredential");
    String? remember = await storage.read(key: "remember");
    String? _userid = await storage.read(key: "userid");
    String? _companyid = await storage.read(key: "companyid");
    String? _company2 = await storage.read(key: "company");
    _company = UserCompanyLoginSelectionDto.deserialize(_company2!);

    if (_company != null) {
      companylist.clear();
      companylist.add(_company);
      company = companylist[0];
    }

    userid = int.parse(_userid.toString());
    companyid = int.parse(_companyid.toString());

    emailController.text = email!;
    passwordController.text = pass!;

    if (remember == "true") {
      setState(() {
        value = true;
      });
    }

    final resp = await BaseClient().get('/User/ValidateMobileRemember?email=' +
        email! +
        '&password=' +
        pass! +
        '');

    return int.parse(resp.toString());
  }

  Future<void> getCompanyList() async {
    if (!emailController.text.isEmpty && !passwordController.text.isEmpty) {
      final resp = await BaseClient().get('/User/ValidateUserLogin?email=' +
          emailController.text +
          '&password=' +
          passwordController.text +
          '');
      company = new UserCompanyLoginSelectionDto(
          userMappingID: 0,
          userTypeID: 0,
          type: null,
          comapanyName: "Select Company",
          isActive: true);

      int k = int.parse(resp.toString());

      if (k != 0) {
        Fluttertoast.showToast(
          msg: "Validating...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
        );
        String response = await BaseClient()
            .get('/User/GetCompanyLoginList?userid=' + k.toString() + '');

        List<UserCompanyLoginSelectionDto> userlist =
            UserCompanyLoginSelectionDto.userFromJson(response);

        setState(() {
          companylist = userlist;
          companylist.add(company);
        });
      } else {
        Fluttertoast.showToast(
          msg: "Incorrect email and password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
        );
        setState(() {
          companylist = [
            new UserCompanyLoginSelectionDto(
                userMappingID: 0,
                userTypeID: 0,
                type: null,
                comapanyName: "Select Company",
                isActive: true)
          ];
        });
      }
    }
  }
}
