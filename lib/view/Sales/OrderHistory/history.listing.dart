import 'package:flutter/material.dart';
import 'package:mobilestock/models/Quotation.dart';
import 'package:mobilestock/view/Quotation/listing.details.dart';
import 'package:mobilestock/view/Quotation/listing.header.dart';
import 'package:mobilestock/view/Sales/OrderHistory/history.header.dart';

import '../../../models/Sales.dart';
import '../../../utils/global.colors.dart';
import 'listingsales.details.dart';

class HistoryListingScreen extends StatefulWidget {
  const HistoryListingScreen({Key? key, required this.sales}) : super(key: key);
  final Sales sales;

  @override
  State<HistoryListingScreen> createState() =>
      _HistoryListingScreen(sales: sales);
}

class _HistoryListingScreen extends State<HistoryListingScreen> {
  bool _visible = false;
  _HistoryListingScreen({Key? key, required this.sales});
  final Sales sales;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: GlobalColors.mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          sales.DocNo,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.share,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          PopupMenuButton<MenuItem>(
              onSelected: (value) {
                if (value == MenuItem.item1) {
                  //Clicked
                } else if (value == MenuItem.item2) {}
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: MenuItem.item2, child: Text('Print Receipt'))
                  ]),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            HistoryListingHeader(sales: sales),
            SizedBox(
              height: 20,
            ),
            ListingSalesDetails(
              sales: sales,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text("Authorised Signature:"),
                Image.asset(
                  'assets/images/agiliti_logo.png',
                  height: 100,
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}

enum MenuItem { item1, item2, item3 }
