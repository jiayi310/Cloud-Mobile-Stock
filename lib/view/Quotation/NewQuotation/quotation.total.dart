import 'package:flutter/material.dart';

class PriceQuotation extends StatefulWidget {
  const PriceQuotation({Key? key}) : super(key: key);

  @override
  State<PriceQuotation> createState() => _PriceQuotation();
}

class _PriceQuotation extends State<PriceQuotation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
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
                '100,000',
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
                '3.90',
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
                '- 3.90',
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
                '100,000',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
