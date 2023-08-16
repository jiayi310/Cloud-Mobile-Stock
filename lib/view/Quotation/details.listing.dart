import 'package:flutter/material.dart';
import 'package:mobilestock/models/Quotation.dart';
import 'package:mobilestock/view/Quotation/listing.details.dart';
import 'package:mobilestock/view/Quotation/listing.header.dart';

import '../../utils/global.colors.dart';

class DetailsListingScreen extends StatefulWidget {
  const DetailsListingScreen({Key? key, required this.quotation})
      : super(key: key);
  final Quotation quotation;

  @override
  State<DetailsListingScreen> createState() =>
      _DetailsListingScreen(quotation: quotation);
}

class _DetailsListingScreen extends State<DetailsListingScreen> {
  bool _visible = false;
  _DetailsListingScreen({Key? key, required this.quotation});
  final Quotation quotation;

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
          quotation.DocNo,
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
                        value: MenuItem.item1, child: Text('Convert to Sales')),
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
            ListingHeader(
              quotation: quotation,
            ),
            SizedBox(
              height: 20,
            ),
            ListingDetails(quotation: quotation),
          ],
        )),
      ),
    );
  }
}

enum MenuItem { item1, item2, item3 }
