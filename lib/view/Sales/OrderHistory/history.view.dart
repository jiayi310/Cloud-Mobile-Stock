import 'package:flutter/material.dart';
import 'package:mobilestock/view/Sales/OrderHistory/history.card.dart';

import '../../../utils/global.colors.dart';
import '../../Customer/customer.search.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _QuotationHomeScreen();
}

class _QuotationHomeScreen extends State<OrderHistoryScreen> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Order History",
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
            SalesCard(),
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
