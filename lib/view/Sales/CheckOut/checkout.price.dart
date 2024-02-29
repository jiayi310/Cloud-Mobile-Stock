import 'package:flutter/material.dart';

import '../../../models/Sales.dart';
import '../SalesProvider.dart';

class PriceCheckOut extends StatefulWidget {
  const PriceCheckOut({Key? key}) : super(key: key);

  @override
  State<PriceCheckOut> createState() => _PriceCheckOutState();
}

class _PriceCheckOutState extends State<PriceCheckOut> {
  @override
  Widget build(BuildContext context) {
    Sales? sales = SalesProvider.of(context)?.sales;

    if (sales == null) {
      // Handle the case where Sales is not available
      return Text('Sales data not available');
    }
    return Container(
      height: 110,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SubTotal',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${sales.calculateTotalPrice().toStringAsFixed(2)}',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                sales.taxAmt != null
                    ? sales.taxAmt!.toStringAsFixed(2)
                    : "0.00",
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '0.00',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                sales.finalTotal != null
                    ? sales.finalTotal!.toStringAsFixed(2)
                    : "N/A",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
