import 'dart:convert';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/view/Analysis/widgets.custom.dart';
import 'package:mobilestock/view/Analysis/widgets.grid.dart';
import 'package:pie_chart/pie_chart.dart' as Pie;

import '../../api/base.client.dart';

class AnalysisScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<AnalysisScreen> {
  List<DataModel> _list = [];
  double maxAmt = 0.00;
  int indexvalue = 1;

  Map<String, double> dataMap = {};

  final colorList = <Color>[
    Colors.green,
    Colors.lightBlue,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.pinkAccent,
    Colors.yellow,
    Colors.cyan,
    Colors.indigo,
    Colors.greenAccent
  ];

  String companyid = "", userid = "";
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getTop10SalesAmtbyCustomer(indexvalue);
    getTop10SalesQtybyStock(indexvalue);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E319D),
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          _buildRegionTabBar(),
          _buildStatsTabBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: Builder(builder: (context) {
                return StatsGrid(
                  index: indexvalue,
                );
              }),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 800.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Top 10 Sales Amount by Customer',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 300,
                      child: _list.isNotEmpty
                          ? BarChart(BarChartData(
                              maxY: maxAmt,
                              minY: 0,
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                show: true,
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget:
                                            (double value, TitleMeta t) {
                                          return Container(
                                            child: Text(_list[value.toInt()]
                                                    .customerName ??
                                                ''),
                                          );
                                        })),
                              ),
                              barGroups: _chartGroups(),
                            ))
                          : Center(
                              child: Text('No Data'),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Top 10 Sales Qty by Stock',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 250,
                      child: dataMap.isNotEmpty
                          ? Pie.PieChart(
                              dataMap: dataMap,
                              colorList: colorList,
                              animationDuration: Duration(milliseconds: 800),
                              chartLegendSpacing: 32,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 2.0,
                              initialAngleInDegree: 0,
                              ringStrokeWidth: 32,
                            )
                          : Center(
                              // Show some placeholder or loading indicator when dataMap is empty
                              child: Text('No Data')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _chartGroups() {
    List<BarChartGroupData> list =
        List<BarChartGroupData>.empty(growable: true);
    for (int i = 0; i < _list.length; i++) {
      list.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(
            toY: _list[i].amt ?? 0,
            gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
            width: 20,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxAmt,
              color: Colors.white,
            ))
      ]));
    }
    return list;
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Analysis',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 1,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text('Individual'),
              // Text('All'),
            ],
            onTap: (index) {
              print('Selected tab index: $index');
            },
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatsTabBar() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 4,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: <Widget>[
              Text('Today'),
              Text('Weekly'),
              Text('Monthly'),
              Text('Total'),
            ],
            onTap: (index) {
              print('Selected tab index: $index');
              if (index == 0) {
                indexvalue = 1;
              } else if (index == 1) {
                indexvalue = 2;
              } else if (index == 2) {
                indexvalue = 3;
              } else {
                indexvalue = 4;
              }
              getTop10SalesAmtbyCustomer(indexvalue);
              getTop10SalesQtybyStock(indexvalue);
            },
          ),
        ),
      ),
    );
  }

  Future<void> getTop10SalesAmtbyCustomer(int _case) async {
    companyid = (await storage.read(key: "companyid"))!;
    userid = (await storage.read(key: "userid"))!;
    if (companyid != null) {
      String response = await BaseClient().get(
          '/Sales/GetTop10SalesAmtByCustomer?companyId=' +
              companyid.toString() +
              '&_case=' +
              _case.toString());

      if (response != 0) {
        List<dynamic> jsonList = jsonDecode(response);

        List<DataModel> dataList =
            jsonList.map((json) => DataModel.fromJson(json)).toList();

        setState(() {
          _list = dataList;
          maxAmt = _list.isNotEmpty
              ? _list
                  .map((data) => data.amt ?? 0)
                  .reduce((a, b) => a > b ? a : b)
              : 0;
        });
      }
    }
  }

  Future<void> getTop10SalesQtybyStock(int _case) async {
    companyid = (await storage.read(key: "companyid"))!;
    userid = (await storage.read(key: "userid"))!;
    if (companyid != null) {
      String response = await BaseClient().get(
          '/Sales/GetTop10SalesQtybyStock?companyId=' +
              companyid.toString() +
              '&_case=' +
              _case.toString());

      if (response != 0) {
        List<dynamic> jsonData = jsonDecode(response);
        Map<String, double> _dataMap = convertJsonToDataMap(jsonData);
        print("DataMap: $_dataMap");
        setState(() {
          dataMap = _dataMap;
        });
      }
    }
  }
}

Map<String, double> convertJsonToDataMap(List<dynamic> jsonData) {
  Map<String, double> result = {};

  for (dynamic item in jsonData) {
    String stockDescription = item['stockDescription'];
    double qty = (item['qty'] as num).toDouble(); // Convert qty to double

    // Add the stock description and qty to the map
    result[stockDescription] = qty;
  }

  return result;
}

class DataModel {
  String? customerCode;
  String? customerName;
  double? amt;

  DataModel({this.customerCode, this.customerName, this.amt});

  DataModel.fromJson(Map<String, dynamic> json) {
    customerCode = json['customerCode'];
    customerName = json['customerName'];
    amt = json['amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerCode'] = this.customerCode;
    data['customerName'] = this.customerName;
    data['amt'] = this.amt;
    return data;
  }
}
