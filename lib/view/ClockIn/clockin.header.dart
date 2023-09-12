import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/view/ClockIn/add.job.dart';

import '../../utils/global.colors.dart';

class ClockInHeader extends StatefulWidget {
  const ClockInHeader({Key? key}) : super(key: key);

  @override
  State<ClockInHeader> createState() => _ClockInHeaderState();
}

class _ClockInHeaderState extends State<ClockInHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat.yMMMd().format(DateTime.now()),
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold)),
            Text(
              "Today",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddJobPage()));
          },
          child: Container(
            width: 120,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: GlobalColors.mainColor),
            child: Center(
              child: Text(
                "+ Add Job",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
