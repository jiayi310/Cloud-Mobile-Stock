import 'package:flutter/material.dart';
import 'package:mobilestock/view/SalesWorkflow/sales.card.left.dart';
import 'package:mobilestock/view/SalesWorkflow/sales.card.right.dart';
import '../../utils/global.colors.dart';

class SalesWorkFlowPage extends StatefulWidget {
  const SalesWorkFlowPage({super.key});

  @override
  State<SalesWorkFlowPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SalesWorkFlowPage> {
  double topEleven = 0;
  double topTen = 0;
  double topNine = 0;
  double topEight = 0;
  double topSeven = 0;
  double topSix = 0;
  double topFive = 0;
  double topFour = 0;
  double topThree = 0;
  double topTwo = 0;
  double topOne = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Center(
                  child: Text(
                    "5 Steps of",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 230,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xff9c54e4).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SALES PROCESS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: SalesCardLeft(
                    title: "CLOCK IN",
                    maincolor: Color(0xff44d8c0),
                    subtext:
                        "Make sure records the attendence and work hours for sales team members.",
                    subcolor: Color(0xfffa327b),
                    mainimage: "assets/images/clock.png",
                    subimage: "assets/images/one.png",
                    route: "clockin",
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: SalesCardRight(
                    title: "QUOTATION",
                    maincolor: Color(0xfffa327b),
                    subtext:
                        "A formal quotation or proposal to potential customers.",
                    subcolor: Color(0xff35bae7),
                    mainimage: "assets/images/quotation.png",
                    subimage: "assets/images/two.png",
                    route: "quotation",
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: SalesCardLeft(
                    title: "SALES",
                    maincolor: Color(0xfff7ca18),
                    subtext: "Selling products or services to a customer.",
                    subcolor: Color(0xff9c54e4),
                    mainimage: "assets/images/sales.png",
                    subimage: "assets/images/three.png",
                    route: "sales",
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: SalesCardRight(
                    title: "COLLECTION",
                    maincolor: Color(0xff35bae7),
                    subtext: "Obtaining payment from the customer.",
                    subcolor: Color(0xfffa327b),
                    mainimage: "assets/images/collection.png",
                    subimage: "assets/images/four.png",
                    route: "collection",
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: SalesCardLeft(
                    title: "ANALYSIS",
                    maincolor: Color(0xff9c54e4),
                    subtext:
                        "Evaluating sales data, performance metrics, and market trends",
                    subcolor: Color(0xff35bae7),
                    mainimage: "assets/images/analysis.png",
                    subimage: "assets/images/five.png",
                    route: "analysis",
                  )),
            ],
          ),
        ),
      ),
      // body: Center(
      //   child: GestureDetector(
      //     child: Container(
      //       child: LayoutBuilder(
      //         builder: (context, constraints) => SingleChildScrollView(
      //           physics: ClampingScrollPhysics(),
      //           scrollDirection: Axis.horizontal,
      //           child: SizedBox(
      //             height: constraints.biggest.height,
      //             child: Stack(
      //               children: [
      //                 Image(
      //                   image: AssetImage("assets/images/salesworkflow.png"),
      //                   fit: BoxFit.scaleDown,
      //                 ),
      //                 Positioned(
      //                     top: (MediaQuery.of(context).size.height / 3.7) - 10,
      //                     left: 0,
      //                     child: buildEditIcon(
      //                         Color(0xff44d8c0),
      //                         "assets/images/clock.png",
      //                         picturewidth,
      //                         MaterialPageRoute(
      //                             builder: (context) =>
      //                                 QuotationHomeScreen()))),
      //                 Positioned(
      //                     top: (MediaQuery.of(context).size.height / 2.7),
      //                     left: (picturewidth / 2.5),
      //                     child: buildEditIcon(
      //                         Color(0xfffa327b),
      //                         "assets/images/quotation.png",
      //                         picturewidth,
      //                         MaterialPageRoute(
      //                             builder: (context) =>
      //                                 QuotationHomeScreen()))),
      //                 Positioned(
      //                     top: (MediaQuery.of(context).size.height / 2) - 10,
      //                     left: 0,
      //                     child: buildEditIcon(
      //                         Color(0xfff7ca18),
      //                         "assets/images/sales.png",
      //                         picturewidth,
      //                         MaterialPageRoute(
      //                             builder: (context) => HomeSalesScreen()))),
      //                 Positioned(
      //                     top: (MediaQuery.of(context).size.height / 1.6),
      //                     left: (picturewidth / 2.5),
      //                     child: buildEditIcon(
      //                         Color(0xff35bae7),
      //                         "assets/images/collection.png",
      //                         picturewidth,
      //                         MaterialPageRoute(
      //                             builder: (context) =>
      //                                 QuotationHomeScreen()))),
      //                 Positioned(
      //                     top: (MediaQuery.of(context).size.height / 1.35),
      //                     left: 0,
      //                     child: buildEditIcon(
      //                         Color(0xff9c54e4),
      //                         "assets/images/collection.png",
      //                         picturewidth,
      //                         MaterialPageRoute(
      //                             builder: (context) => StatsScreen()))),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget buildEditIcon(Color color, String image, double picturewidth,
          MaterialPageRoute<Widget> pageRoute) =>
      buildCircle(
          color: color,
          all: 3,
          image: image,
          width: picturewidth,
          pageRoute: pageRoute);

  Widget buildCircle(
          {required double width,
          required String image,
          required double all,
          required Color color,
          required MaterialPageRoute<Widget> pageRoute}) =>
      InkWell(
        onTap: () {
          Navigator.push(context, pageRoute);
        },
        child: Container(
          color: Colors.transparent,
          width: width / 2,
          height: width / 4.8 + 20,
          padding: EdgeInsets.all(25),
        ),
      );
}
