import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/DataModel.dart';
import 'package:pie_chart/pie_chart.dart' as Pie;

class BarChartWidget extends StatefulWidget {
  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  List<DataModel> _list = List<DataModel>.empty(growable: true);
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
    "Flutter2": 5,
    "React2": 36,
    "Xamarin2": 23,
    "Ionic2": 22,
    "Flutter3": 15,
    "React3": 23
  };

  @override
  void initState() {
    super.initState();
    _list.add(DataModel(key: "product 0", value: "2"));
    _list.add(DataModel(key: "1", value: "4"));
    _list.add(DataModel(key: "2", value: "6"));
    _list.add(DataModel(key: "3", value: "8"));
    _list.add(DataModel(key: "4", value: "10"));
    _list.add(DataModel(key: "5", value: "8"));
    _list.add(DataModel(key: "6", value: "4"));
  }

  @override
  Widget build(BuildContext context) {
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

    return Container(
      height: 1000.0,
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
              'Top 10 Products',
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
            child: BarChart(BarChartData(
              maxY: 15,
              minY: 0,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              barGroups: _chartGroups(),
            )),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Top 10 Products',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 300,
              child: Pie.PieChart(
                dataMap: dataMap,
                colorList: colorList,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 2.0,
                initialAngleInDegree: 0,
                ringStrokeWidth: 32,
              )),
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
            toY: double.parse(_list[i].value!),
            gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
            width: 20,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 15,
              color: Colors.grey[200],
            ))
      ]));
    }
    return list;
  }
}
