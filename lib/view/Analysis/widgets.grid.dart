import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../api/base.client.dart';

class StatsGrid extends StatefulWidget {
  StatsGrid({required this.index});

  int index;

  @override
  State<StatsGrid> createState() => _StatsGridState();
}

class _StatsGridState extends State<StatsGrid> {
  String totalsales = "",
      totalsalescount = "",
      averageordervalue = "",
      stockvalue = "";
  String companyid = "";
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getTotalSales(widget.index);
    getTotalSalesCount(widget.index);
    getStockValue();
  }

  @override
  void didUpdateWidget(covariant StatsGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      getTotalSales(widget.index);
      getTotalSalesCount(widget.index);
      getStockValue();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Parse the strings to doubles and calculate the average order value
    double totalSalesValue = double.tryParse(totalsales) ?? 0;
    double totalSalesCountValue = double.tryParse(totalsalescount) ?? 0;

    // Check for non-zero total sales count to avoid division by zero
    if (totalSalesCountValue != 0) {
      double averageOrderValue = totalSalesValue / totalSalesCountValue;
      averageordervalue = averageOrderValue.toStringAsFixed(2);
    } else {
      // Handle the case where total sales count is zero to avoid division by zero
      averageordervalue = "N/A"; // or any other appropriate value
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Total Sales', totalsales, Colors.indigo),
                _buildStatCard(
                    'Average Order Value', averageordervalue, Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Stock Value (Cost)', stockvalue, Colors.green),
                _buildStatCard('Delivery', '0.00', Colors.lightBlue),
                _buildStatCard('Count', totalsalescount, Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getTotalSales(int _case) async {
    try {
      companyid = (await storage.read(key: "companyid"))!;
      if (companyid != null) {
        String response = await BaseClient().get(
            '/Sales/GetSalesByCompanyIdAndDateRange?companyId=' +
                companyid +
                '&_case=' +
                _case.toString());

        double parsedValue = double.tryParse(response) ?? 0;

        setState(() {
          totalsales = parsedValue.toStringAsFixed(2);
        });
      }
    } catch (error) {
      print('Error fetching total sales: $error');
    }
  }

  Future<void> getTotalSalesCount(int _case) async {
    try {
      companyid = (await storage.read(key: "companyid"))!;
      if (companyid != null) {
        String response = await BaseClient().get(
            '/Sales/GetTotalSalesCount?companyId=' +
                companyid +
                '&_case=' +
                _case.toString());

        int parsedValue = int.tryParse(response) ?? 0;

        setState(() {
          totalsalescount = parsedValue.toStringAsFixed(2);
        });
      }
    } catch (error) {
      print('Error fetching total sales count: $error');
    }
  }

  Future<void> getStockValue() async {
    try {
      companyid = (await storage.read(key: "companyid"))!;
      if (companyid != null) {
        String response = await BaseClient()
            .get('/Stock/GetStockValue?companyid=' + companyid);

        double parsedValue = double.tryParse(response) ?? 0;

        setState(() {
          stockvalue = parsedValue.toStringAsFixed(2);
        });
      }
    } catch (error) {
      print('Error fetching total sales: $error');
    }
  }
}
