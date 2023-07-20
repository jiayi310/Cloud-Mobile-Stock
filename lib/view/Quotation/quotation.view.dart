import 'package:flutter/material.dart';

import '../../utils/global.colors.dart';

class QuotationHomeScreen extends StatefulWidget {
  const QuotationHomeScreen({Key? key}) : super(key: key);

  @override
  State<QuotationHomeScreen> createState() => _QuotationHomeScreen();
}

class _QuotationHomeScreen extends State<QuotationHomeScreen> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => NewCustomer()));
        },
        child: Icon(Icons.add),
        backgroundColor: GlobalColors.mainColor,
      ),
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Quotation",
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
    );
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }
}
