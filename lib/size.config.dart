import 'package:flutter/material.dart';

double getProportionateScreenWidth(BuildContext context, double inputWidth) {
  double screenWidth = MediaQuery.of(context).size.width;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

double getProportionateScreenHeight(BuildContext context, double inputHeight) {
  double screenHeight = MediaQuery.of(context).size.height;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

const double defaultPadding = 16.0;
const double defaultBorderRadius = 12.0;
