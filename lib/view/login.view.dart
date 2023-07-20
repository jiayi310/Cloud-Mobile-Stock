import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/widgets/text.form.global.dart';
import 'package:mobilestock/widgets/button.login.dart';
import 'package:mobilestock/widgets/social.login.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    obscure: false,
                    textInputType: TextInputType.emailAddress),
                const SizedBox(height: 20),

                ///Password Input
                TextFormGlobal(
                    controller: passwordController,
                    text: 'Password',
                    obscure: true,
                    textInputType: TextInputType.text),
                const SizedBox(height: 30),
                ButtonLogin(),
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
}
