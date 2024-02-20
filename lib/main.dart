import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Sales/SalesProvider.dart';
import 'package:mobilestock/view/splash.view.dart';

import 'models/Sales.dart';

void main() {
  runApp(
    SalesProvider(
      sales: Sales(/* your sales data initialization here */),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
