import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/Quotation.dart';
import '../../utils/global.colors.dart';

class JobCard extends StatefulWidget {
  const JobCard({Key? key}) : super(key: key);

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // for (int i = 0; i < demo_quotation.length; i++)
        InkWell(
          onLongPress: () {
            Get.defaultDialog(
                cancelTextColor: GlobalColors.mainColor,
                confirmTextColor: Colors.white,
                buttonColor: GlobalColors.mainColor,
                titlePadding: EdgeInsets.only(top: 20),
                title: "Warning",
                content: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Are you sure want to delete ",
                          //demo_quotation[i].DocNo,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                textConfirm: "Confirm",
                textCancel: "Cancel");
          },
          onTap: () {},
          child: Container(
            height: 110,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            padding: EdgeInsets.all(5),
            // decoration: BoxDecoration(
            //   color: i == 0
            //       ? CupertinoColors.activeBlue
            //       : i == 1
            //           ? Colors.pinkAccent
            //           : Colors.orangeAccent,
            //   borderRadius: BorderRadius.circular(20),
            // ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          "Job Task 1",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          "6:00PM - 10:00PM",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          "Job Description 123........",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
