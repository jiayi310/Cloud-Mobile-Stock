import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/view/Analysis/analysis.view.dart';
import 'package:mobilestock/view/ClockIn/clockin.view.dart';
import 'package:mobilestock/view/Sales/home.sales.dart';

class SalesCardLeft extends StatelessWidget {
  SalesCardLeft({
    Key? key,
    required this.mainimage,
    required this.subimage,
    required this.title,
    required this.subtext,
    required this.maincolor,
    required this.subcolor,
    required this.route,
  }) : super(key: key);
  final String mainimage, subimage, route;
  final String title, subtext;
  final Color maincolor, subcolor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (route == "clockin")
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClockInHomeScreen()));
            else if (route == "sales")
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeSalesScreen()));
            else if (route == "analysis")
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AnalysisScreen()));
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 1.3,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5 - 30,
                          height: 3,
                          color: maincolor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Text(
                              subtext,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Positioned(
                    top: 10,
                    right: 30,
                    child: buildEditIcon(maincolor, mainimage, 110, 30)),
                Positioned(
                  top: 0,
                  right: 110,
                  child: buildEditIcon(subcolor, subimage, 45, 25),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildEditIcon(
          Color color, String image, double picturewidth, double all) =>
      buildCircle(color: color, all: all, image: image, width: picturewidth);

  Widget buildCircle({
    required double width,
    required String image,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          color: color,
          width: width,
          height: width,
          padding: EdgeInsets.all(15),
          child: Image.asset(image),
        ),
      );
}
