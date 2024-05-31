import 'package:flutter/material.dart';

import '../../utils/global.colors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

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
          "About Us",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/cubehous_logo.png',
                      height: 80)),
              Text(
                "Cubehous",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text("@2024 Presoft (M) Sdn. Bhd."),
              Text(
                  "All rights Reserved. The usage of this app indicates that you agree to be bound by our Terms and Conditions."),
              SizedBox(
                height: 20,
              ),
              Text("Support Line: +603 8068 2556"),
              Text("Support Email: support@presoft.com.my"),
            ],
          ),
        ),
      ),
    );
  }
}
