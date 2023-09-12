import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobilestock/utils/global.colors.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            '-Or sign in with-',
            style: TextStyle(
              color: GlobalColors.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              children: [
                //Google
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      'assets/images/google.svg',
                      height: 25,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                //Microsoft
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      'assets/images/microsoft.svg',
                      height: 25,
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
