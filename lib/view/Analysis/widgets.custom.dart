import 'package:flutter/material.dart';
import 'package:mobilestock/view/Analysis/Ranking/ranking.agent.dart';
import 'package:mobilestock/view/Settings/settings.constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kprimaryColor,
      elevation: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        iconSize: 28.0,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.leaderboard),
          iconSize: 28.0,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Ranking_Agent()));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
