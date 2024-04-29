import 'package:flutter/material.dart';

import '../../../models/Stock.dart';
import '../../../utils/global.colors.dart';

class StockTakeUOMList extends StatefulWidget {
  StockTakeUOMList({Key? key, required this.stock}) : super(key: key);
  Stock stock;

  @override
  State<StockTakeUOMList> createState() => _StockTakeUOMListState();
}

class _StockTakeUOMListState extends State<StockTakeUOMList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.stock.stockCode.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "UOM",
                  style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                buildUOMDropdown(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Batch",
                  style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Storage Code",
                  style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quantity",
                  style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
