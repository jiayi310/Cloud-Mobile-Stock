import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobilestock/view/Quotation/quotation.view.dart';

import 'Analysis/analysis.view.dart';
import 'ClockIn/clockin.view.dart';
import 'Collection/collection.view.dart';
import 'Customer/customer.home.dart';
import 'Sales/home.sales.dart';
import 'SalesWorkflow/sales.workflow.dart';
import 'Stock/stock.home.dart';

class TabletView extends StatefulWidget {
  TabletView({Key? key}) : super(key: key);

  @override
  State<TabletView> createState() => _TabletViewState();
}

class _TabletViewState extends State<TabletView> {
  _TabletViewState({Key? key});
  List menu = [];

  _initData() {
    DefaultAssetBundle.of(context)
        .loadString("assets/home_menu.json")
        .then((value) {
      setState(() {
        menu = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: OverflowBox(
      maxWidth: MediaQuery.of(context).size.width,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 40),
          itemCount: _getDeviceType(),
          itemBuilder: (_, i) {
            int a = 4 * i;
            int b = 4 * i + 1;
            int c = 4 * i + 2;
            int d = 4 * i + 3;
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    if (a == 0) {
                      //Wokflows
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalesWorkFlowPage()));
                    } else if (a == 4) {
                      //Stock
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuotationHomeScreen()));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    width: (MediaQuery.of(context).size.width - 90) / 4.5,
                    height:
                        ((MediaQuery.of(context).size.width - 90) / 4.5) + 20,
                    margin: EdgeInsets.only(left: 30, bottom: 15, top: 10),
                    decoration: BoxDecoration(
                        color: HexColor(menu[a]['color']),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0,
                              spreadRadius: 2.0),
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0)
                        ]),
                    child: Column(
                      children: [
                        Image.asset(menu[a]['img']),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          menu[a]['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (b == 1) {
                      //Wokflows
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerHomeScreen()));
                    } else if (b == 5) {
                      //Stock
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeSalesScreen()));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    width: (MediaQuery.of(context).size.width - 90) / 4.5,
                    height:
                        ((MediaQuery.of(context).size.width - 90) / 4.5) + 20,
                    margin: EdgeInsets.only(left: 30, bottom: 15, top: 10),
                    decoration: BoxDecoration(
                        color: HexColor(menu[b]['color']),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0,
                              spreadRadius: 2.0),
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0)
                        ]),
                    child: Column(
                      children: [
                        Image.asset(menu[b]['img']),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          menu[b]['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (c == 2) {
                      //Wokflows
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StockHomeScreen()));
                    } else if (c == 6) {
                      //Stock
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CollectionHomeScreen()));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    width: (MediaQuery.of(context).size.width - 90) / 4.5,
                    height:
                        ((MediaQuery.of(context).size.width - 90) / 4.5) + 20,
                    margin: EdgeInsets.only(left: 30, bottom: 15, top: 10),
                    decoration: BoxDecoration(
                        color: HexColor(menu[c]['color']),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0,
                              spreadRadius: 2.0),
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0)
                        ]),
                    child: Column(
                      children: [
                        Image.asset(menu[c]['img']),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          menu[c]['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (d == 3) {
                      //Wokflows
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClockInHomeScreen()));
                    } else if (d == 7) {
                      //Stock
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnalysisScreen()));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    width: (MediaQuery.of(context).size.width - 90) / 4.5,
                    height:
                        ((MediaQuery.of(context).size.width - 90) / 4.5) + 20,
                    margin: EdgeInsets.only(left: 30, bottom: 15, top: 10),
                    decoration: BoxDecoration(
                        color: HexColor(menu[d]['color']),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0,
                              spreadRadius: 2.0),
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0)
                        ]),
                    child: Column(
                      children: [
                        Image.asset(menu[d]['img']),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          menu[d]['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    ));
  }

  int _getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    if (data.size.shortestSide < 600) {
      //phone
      return (menu.length.toDouble() / 2).toInt();
    } else {
      //tablet
      return (menu.length.toDouble() / 4).toInt();
    }
  }
}
