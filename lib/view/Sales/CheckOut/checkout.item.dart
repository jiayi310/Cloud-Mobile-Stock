import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/view/Sales/Cart/cart.add.dart';

import '../../../models/Sales.dart';
import '../../../models/Stock.dart';
import '../../../utils/global.colors.dart';
import '../SalesProvider.dart';

class ItemCheckout extends StatefulWidget {
  const ItemCheckout({Key? key}) : super(key: key);

  @override
  State<ItemCheckout> createState() => _ItemCheckoutState();
}

class _ItemCheckoutState extends State<ItemCheckout> {
  List<SalesDetails> salesItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access context and salesProvider here
    final salesProvider = SalesProvider.of(context);
    salesItems = salesProvider?.sales.salesDetails ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < salesItems.length; i++)
          Container(
            height: 110,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                if (salesItems[i].image!.length > 0)
                  Container(
                    height: 70,
                    width: 70,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 224, 224, 244),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.memory(salesItems[i].image ?? Uint8List(0)),
                  ),
                if (salesItems[i].image!.length <= 0)
                  Container(
                    height: 70,
                    width: 70,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      "assets/images/no-image.png",
                      width: 100,
                    ),
                  ),
                Expanded(
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          salesItems[i].stockCode.toString(),
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          salesItems[i].description.toString(),
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          salesItems[i].uom.toString(),
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "RM " +
                            (salesItems[i].unitPrice! *
                                    (salesItems[i].qty ?? 0))
                                .toStringAsFixed(2),
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: GlobalColors.mainColor,
                        ),
                      ),
                      // AddCartButtonCart(
                      //   quantity: 2,
                      // ),
                    ],
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
