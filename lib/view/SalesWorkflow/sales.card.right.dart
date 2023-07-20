import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Quotation/quotation.view.dart';

import '../../models/Product.dart';

class SalesCardRight extends StatelessWidget {
  SalesCardRight(
      {Key? key,
      required this.mainimage,
      required this.subimage,
      required this.title,
      required this.subtext,
      required this.maincolor,
      required this.subcolor,
      required this.route})
      : super(key: key);
  final String mainimage, subimage, route;
  final String title, subtext;
  final Color maincolor, subcolor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (route == "quotation")
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuotationHomeScreen()));
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Align(
                          alignment: Alignment.centerRight,
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
                        alignment: Alignment.centerRight,
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
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
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
                    left: 30,
                    child: buildEditIcon(maincolor, mainimage, 130, 50)),
                Positioned(
                    top: 0,
                    left: 120,
                    child: buildEditIcon(subcolor, subimage, 50, 25)),
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
