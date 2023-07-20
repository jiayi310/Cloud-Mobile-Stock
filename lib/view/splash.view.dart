import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/login.view.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Timer(const Duration(seconds: 1), () {
      Get.to(() => LoginView());
    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Center(
          child:
              Image.asset('assets/images/agiliti_logo_blue.png', height: 100)),
    );
  }
}
