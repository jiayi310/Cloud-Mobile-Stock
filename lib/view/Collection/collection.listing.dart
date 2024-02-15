import 'package:flutter/material.dart';
import 'package:mobilestock/models/Collection.dart';
import 'package:mobilestock/view/Collection/listing.details.dart';
import 'package:mobilestock/view/Collection/listing.header.dart';

import '../../utils/global.colors.dart';

class CollectionListingScreen extends StatefulWidget {
  const CollectionListingScreen({Key? key, required this.collection})
      : super(key: key);
  final Collection collection;

  @override
  State<CollectionListingScreen> createState() =>
      _CollectionListingScreen(collection: collection);
}

class _CollectionListingScreen extends State<CollectionListingScreen> {
  _CollectionListingScreen({required this.collection});
  final Collection collection;

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
          collection.docNo.toString(),
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
              collection: collection,
            ),
            SizedBox(
              height: 20,
            ),
            ListingDetails(collection: collection),
          ],
        )),
      ),
    );
  }
}

enum MenuItem { item1, item2, item3 }
