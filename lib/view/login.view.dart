import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String _username = "Username";
  int isLogin = 0;

  int companyid = 0;
  List<UserCompanyLoginSelectionDto> companylist = [
    new UserCompanyLoginSelectionDto(
        userMappingID: 0,
        userTypeID: 0,
        type: null,
        companyName: "Select Company",
        isDeletedTemporarily: true)
  ];
  UserCompanyLoginSelectionDto company = new UserCompanyLoginSelectionDto(
      userMappingID: 0,
      userTypeID: 0,
      type: null,
      companyName: "Select Company",
      isDeletedTemporarily: true);

  UserCompanyLoginSelectionDto _company = new UserCompanyLoginSelectionDto(
      userMappingID: 0,
      userTypeID: 0,
      type: null,
      companyName: "Select Company",
      isDeletedTemporarily: true);
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
        isLogin = 1;
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
                    child: Image.asset('assets/images/cubehous_logo.png',
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

                ///Username Input
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
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return _LoginUserModal();
                              });
                        },
                        child: Container(
                          width: double.maxFinite,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _username,
                              )),
                        ))),
                if (_username != "Username") const SizedBox(height: 30),
                if (_username != "Username")
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
                    child: DropdownButton<UserCompanyLoginSelectionDto>(
                      value: company,
                      isExpanded: true,
                      onChanged: (UserCompanyLoginSelectionDto? newvalue) {
                        setState(() {
                          print("company " + newvalue!.companyName);
                          setState(() {
                            company.companyName = newvalue.companyName;
                            companyid = newvalue!.companyID!;
                          });
                        });
                      },
                      items: companylist
                          .map<DropdownMenuItem<UserCompanyLoginSelectionDto>>(
                              (UserCompanyLoginSelectionDto value2) {
                        return DropdownMenuItem<UserCompanyLoginSelectionDto>(
                          value: value2,
                          child: Text(value2.companyName!),
                        );
                      }).toList(),
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
                    if (_username == "Username") {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return _LoginUserModal();
                          });
                    } else {
                      _validateLogin();
                    }
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
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                if (isLogin == 1)
                  InkWell(
                    onTap: () {
                      storeTokenAndData(
                          "",
                          "",
                          false,
                          0,
                          0,
                          new UserCompanyLoginSelectionDto(companyName: ""),
                          "");

                      setState(() {
                        isLogin = 0;
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return _LoginUserModal();
                            });
                      });
                    },
                    child: Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
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

  _LoginUserModal() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                padding:
                    EdgeInsets.only(left: 30, right: 30, bottom: 50, top: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 4,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 223, 221, 221),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Account Log In",
                      style: TextStyle(
                        color: GlobalColors.mainColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

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
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          decoration: InputDecoration(
                              errorText:
                                  _validate ? 'Field cannot be empty' : null,
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
                    const SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //         materialTapTargetSize:
                    //             MaterialTapTargetSize.shrinkWrap,
                    //         value: this.value,
                    //         activeColor: GlobalColors.mainColor,
                    //         onChanged: (bool? value) {
                    //           setState(() {
                    //             this.value = value!;
                    //           });
                    //         }),
                    //     Text("Remember Me"),
                    //   ],
                    // ),

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
                    const SizedBox(height: 30),
                    // SocialLogin()
                  ],
                )),
          ),
        ),
      ],
    );
  }

  void _validateLogin() async {
    if (company.companyName == "Select Company") {
      Fluttertoast.showToast(
        msg: "Please select a company.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
    } else {
      final resp = await BaseClient().get(
          '/User/ValidateMobileRemember?email=' +
              emailController.text! +
              '&password=' +
              passwordController.text! +
              '');

      if (resp != null)
        i = int.parse(resp.toString());
      else {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return _LoginUserModal();
            });
        // Fluttertoast.showToast(
        //   msg: "Incorrect email and password.",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   timeInSecForIosWeb: 2,
        // );
        storeTokenAndData(emailController.text, passwordController.text, value,
            0, 0, company, _username);
      }
      if (i > 0) {
        storeTokenAndData(emailController.text, passwordController.text, value,
            userid, companyid, company, _username);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Incorrect email and password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
        );
        passwordController.clear();
        storeTokenAndData(emailController.text, passwordController.text, value,
            0, 0, company, _username);
      }
    }
  }

  void fetchUsers() async {
    if (!emailController.text.isEmpty && !passwordController.text.isEmpty) {
      final resp = await BaseClient().get('/User/ValidateUserLogin?email=' +
          emailController.text +
          '&password=' +
          passwordController.text +
          '');

      setState(() {
        if (resp != null)
          i = int.parse(resp.toString());
        else {
          Fluttertoast.showToast(
            msg: "Incorrect email and password.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
          );
          passwordController.clear();
          storeTokenAndData(emailController.text, passwordController.text,
              value, 0, 0, company, _username);
        }
      });

      if (i > 0) {
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          final resp = await BaseClient()
              .get('/User/GetUser?userid=' + i.toString() + '');

          setState(() {
            final body = jsonDecode(resp);
            String? username = body['name'];

            _username = username!;
            userid = i;
            isLogin = 1;
          });

          Fluttertoast.showToast(
            msg: "Login successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
          );
          Navigator.pop(context);
          getCompanyList();
        }
      } else {
        Fluttertoast.showToast(
          msg: "Incorrect email and password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
        );
        storeTokenAndData(emailController.text, passwordController.text, value,
            0, 0, company, _username);
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please key in the details.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
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
      String username) async {
    await storage.write(key: "email", value: email);
    await storage.write(key: "usercredential", value: usercredential);
    await storage.write(key: "remember", value: remember.toString());
    await storage.write(key: "userid", value: userid.toString());
    await storage.write(key: "companyid", value: companyid.toString());
    await storage.write(key: "username", value: username);
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
    String? _username2 = await storage.read(key: "username");
    _company = UserCompanyLoginSelectionDto.deserialize(_company2!);

    if (_company != null) {
      companylist.clear();
      companylist.add(_company);
      company = companylist[0];
    }

    _username = _username2!;

    userid = int.parse(_userid.toString());
    companyid = int.parse(_companyid.toString());

    emailController.text = email!;
    passwordController.text = pass!;

    if (remember == "true") {
      setState(() {
        value = true;
      });
    } else {
      setState(() {
        value = false;
      });
    }

    final resp = await BaseClient().get('/User/ValidateMobileRemember?email=' +
        email! +
        '&password=' +
        pass! +
        '');

    if (resp != null) {
      if (value == false)
        return 0;
      else
        return int.parse(resp.toString());
    } else {
      return 0;
    }
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
          companyName: "Select Company",
          isDeletedTemporarily: true);

      int k = int.parse(resp.toString());

      if (k != 0) {
        String response = await BaseClient()
            .get('/User/GetCompanySelectionList?userid=' + k.toString() + '');

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
                companyName: "Select Company",
                isDeletedTemporarily: true)
          ];
        });
      }
    }
  }
}
