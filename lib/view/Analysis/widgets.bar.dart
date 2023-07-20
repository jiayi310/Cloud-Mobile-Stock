import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/view/Analysis/styles.dart';

import '../../models/DataModel.dart';

class BarChartWidget extends StatefulWidget {
  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  List<DataModel> _list = List<DataModel>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _list.add(DataModel(key: "0", value: "2"));
    _list.add(DataModel(key: "1", value: "4"));
    _list.add(DataModel(key: "2", value: "6"));
    _list.add(DataModel(key: "3", value: "8"));
    _list.add(DataModel(key: "4", value: "10"));
    _list.add(DataModel(key: "5", value: "8"));
    _list.add(DataModel(key: "6", value: "4"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
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
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            // child: BarChart(
            //   BarChartData(
            //     backgroundColor: Colors.white,
            //     barGroups: _chartGroups(),
            //     borderData: FlBorderData(
            //         border:
            //             const Border(bottom: BorderSide(), left: BorderSide())),
            //     gridData: FlGridData(show: false),
            //     titlesData: FlTitlesData(
            //       bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            //       leftTitles: AxisTitles(
            //           sideTitles: SideTitles(
            //         showTitles: true,
            //         interval: 1,
            //         getTitlesWidget: (value, meta) {
            //           return Text(
            //             value.toString(),
            //             style: const TextStyle(fontSize: 10),
            //           );
            //         },
            //       )),
            //       topTitles:
            //           AxisTitles(sideTitles: SideTitles(showTitles: false)),
            //       rightTitles:
            //           AxisTitles(sideTitles: SideTitles(showTitles: false)),
            //     ),
            //   ),
            // ),
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
            toY: double.parse(_list[i].value!), color: Colors.deepOrange)
      ]));
    }
    return list;
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = 'Mon';
              break;
            case 1:
              text = 'Tue';
              break;
            case 2:
              text = 'Wed';
              break;
            case 3:
              text = 'Thu';
              break;
            case 4:
              text = 'Fri';
              break;
            case 5:
              text = 'Sat';
              break;
            case 6:
              text = 'Sun';
              break;
          }

          return Text(
            text,
            style: TextStyle(fontSize: 10),
          );
        },
      );
}
