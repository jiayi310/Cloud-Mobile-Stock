import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

import '../../../size.config.dart';

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    required this.isActive,
  }) : super(key: key);

  final Color color;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 4),
      decoration: BoxDecoration(
        border: Border.all(
            color: isActive ? GlobalColors.mainColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 10,
        backgroundColor: color,
      ),
    );
  }
}
