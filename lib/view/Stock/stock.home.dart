import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Stock/stock.card.dart';
import 'package:mobilestock/view/Stock/stock.search.dart';

class StockHomeScreen extends StatefulWidget {
  const StockHomeScreen({Key? key}) : super(key: key);

  @override
  State<StockHomeScreen> createState() => _StockHomeScreen();
}

class _StockHomeScreen extends State<StockHomeScreen> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Stock",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
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
                color: GlobalColors.mainColor,
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
            StockCard(),
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
