import 'package:flutter/material.dart';
import 'package:mobilestock/view/Settings/settings.constant.dart';

class SupportCard extends StatelessWidget {
  const SupportCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: ksecondryLightColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(
              Icons.support_agent,
              size: 50,
              color: ksecondryColor,
            ),
          ),
          SizedBox(width: 10),
          Text(
            "Feel Free to Ask, We Ready to Help",
            style: TextStyle(
              fontSize: ksmallFontSize - 2,
              color: ksecondryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
