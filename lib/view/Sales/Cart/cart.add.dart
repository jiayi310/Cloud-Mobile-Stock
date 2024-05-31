import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestock/models/Sales.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Settings/settings.constant.dart';

import '../SalesProvider.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class AddCartButtonCart extends StatefulWidget {
  AddCartButtonCart({Key? key, required this.salesItem}) : super(key: key);

  SalesItem salesItem;

  @override
  State<AddCartButtonCart> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddCartButtonCart> {
  Widget showWidget(int qty) {
    if (qty == 0) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        var result = await Get.defaultDialog(
          cancelTextColor: GlobalColors.mainColor,
          confirmTextColor: Colors.white,
          buttonColor: Colors.red,
          titlePadding: EdgeInsets.only(top: 20),
          title: "Confirmation",
          content: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Are you sure want to delete " + widget.salesItem.stockCode,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          textConfirm: "Confirm",
          textCancel: "Cancel",
          onConfirm: () {
            setState(() {
              final salesProvider = SalesProvider.of(context);
              if (salesProvider != null) {
                salesProvider.sales.removeItem(widget.salesItem.stockCode);
              }
            });
            Get.back();
          },
          onCancel: () {},
        );

        // Check the result to determine if the user confirmed or canceled
        if (result != null && result as bool) {
        } else {
          setState(() {
            widget.salesItem.quantity = 1;
          });
        }
      });
    }

    // return Align(
    //   alignment: Alignment.centerRight,
    //   child: TextButton(
    //     child: Text(
    //       "x1",
    //       style: TextStyle(color: Colors.black),
    //     ),
    //     style: ElevatedButton.styleFrom(
    //         backgroundColor: Colors.grey.withOpacity(0.05)),
    //     onPressed: () {
    //       setState(() {
    //         widget.salesItem.quantity;
    //       });
    //     },
    //   ),
    // );

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(
              Icons.remove,
              color: kprimaryColor,
            ),
            onPressed: () {
              setState(() {
                final salesProvider = SalesProvider.of(context);
                if (salesProvider != null) {
                  salesProvider.sales.updateItemQuantity(
                      widget.salesItem.stockCode,
                      (widget.salesItem.quantity ?? 0.0) + 1.0);
                }
                if (widget.salesItem.quantity > 0) widget.salesItem.quantity--;
              });
            },
          ),
          Text(
            widget.salesItem.quantity.toString(),
            style: TextStyle(color: GlobalColors.mainColor),
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: kprimaryColor,
            ),
            onPressed: () {
              setState(() {
                final salesProvider = SalesProvider.of(context);
                if (salesProvider != null) {
                  salesProvider.sales.updateItemQuantity(
                      widget.salesItem.stockCode,
                      (widget.salesItem.quantity ?? 0.0) + 1.0);
                }
                widget.salesItem.quantity++;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 120,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: showWidget(widget.salesItem.quantity),
      ),
    );
  }
}
