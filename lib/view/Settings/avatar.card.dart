import 'package:flutter/material.dart';
import 'package:mobilestock/view/Settings/settings.constant.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/images/avatar.png",
          width: 70,
          height: 70,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Admin",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kprimaryColor,
              ),
            ),
            Text(
              "Agilec Technology Sdn Bhd",
              style: TextStyle(
                fontSize: ksmallFontSize,
                color: Colors.grey.shade600,
              ),
            )
          ],
        )
      ],
    );
  }
}
