import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilestock/models/Picking.dart';
import 'package:mobilestock/view/Sales/Cart/cart.add.dart';

import '../../../models/Stock.dart';
import '../../../utils/global.colors.dart';
import 'PickingProvider.dart';

class InvoicePicking extends StatelessWidget {
  InvoicePicking(
      {Key? key, required this.pickingItems, required this.refreshMainPage})
      : super(key: key);
  List<PickingItems> pickingItems;
  final Function refreshMainPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: pickingItems.map((salesDocID) {
        return Container(
          color: GlobalColors.mainColor,
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sales Doc No: $salesDocID",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Implement delete functionality if needed
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
