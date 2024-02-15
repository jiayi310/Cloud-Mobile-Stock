import 'package:flutter/material.dart';

import '../../models/Stock.dart';
import '../../utils/global.colors.dart';

class AddStockDetails extends StatefulWidget {
  AddStockDetails({Key? key, required this.stock}) : super(key: key);
  Stock stock;

  @override
  State<AddStockDetails> createState() => _AddStockDetailsState(stock: stock);
}

class _AddStockDetailsState extends State<AddStockDetails> {
  _AddStockDetailsState({Key? key, required this.stock});
  Stock stock;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Add Stock Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
            ),
          ),
        ],
      ),
    );
  }
}
