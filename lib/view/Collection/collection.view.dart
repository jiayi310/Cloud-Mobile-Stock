import 'package:flutter/material.dart';
import 'package:mobilestock/view/Quotation/quotation.add.dart';
import 'package:mobilestock/view/Quotation/quotation.card.dart';

import '../../utils/global.colors.dart';
import '../Customer/customer.search.dart';
import 'collection.add.dart';
import 'collection.card.dart';

class CollectionHomeScreen extends StatefulWidget {
  const CollectionHomeScreen({Key? key}) : super(key: key);

  @override
  State<CollectionHomeScreen> createState() => _CollectionHomeScreen();
}

class _CollectionHomeScreen extends State<CollectionHomeScreen> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CollectionAdd()));
        },
        child: Icon(Icons.add),
        backgroundColor: GlobalColors.mainColor,
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: GlobalColors.mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Collection",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                _toggle();
              },
              child: Icon(
                Icons.search,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Visibility(visible: _visible, child: SearchWidget()),
            CollectionCard(),
          ],
        )),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }
}
