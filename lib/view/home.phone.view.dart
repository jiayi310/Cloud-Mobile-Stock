import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Analysis/analysis.view.dart';
import 'ClockIn/clockin.view.dart';
import 'Collection/collection.view.dart';
import 'Customer/customer.home.dart';
import 'Sales/home.sales.dart';
import 'SalesWorkflow/sales.workflow.dart';
import 'Stock/stock.home.dart';

class PhoneView extends StatefulWidget {
  PhoneView({Key? key}) : super(key: key);

  @override
  State<PhoneView> createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  _PhoneViewState({Key? key});
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
            int a = 2 * i;
            int b = 2 * i + 1;
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
                    } else if (a == 2) {
                      //Stock
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StockHomeScreen()));
                    } else if (a == 4) {
                      //Quotation
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CollectionHomeScreen()));
                    } else if (a == 6) {
                      //Analysis
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnalysisScreen()));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    width: (MediaQuery.of(context).size.width - 90) / 2,
                    height: ((MediaQuery.of(context).size.width - 90) / 2) + 20,
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
                    } else if (b == 3) {
                      //Stock
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClockInHomeScreen()));
                    } else if (b == 5) {
                      //Quotation
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeSalesScreen()));
                    } else if (b == 7) {
                      //Analysis
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnalysisScreen()));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    width: (MediaQuery.of(context).size.width - 90) / 2,
                    height: ((MediaQuery.of(context).size.width - 90) / 2) + 20,
                    margin: EdgeInsets.only(left: 30, bottom: 15, top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
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
