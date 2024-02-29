import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/view/Collection/collection.invoice.dart';
import 'package:mobilestock/view/Quotation/NewQuotation/quotation.customer.dart';
import 'package:mobilestock/view/Quotation/NewQuotation/quotation.total.dart';

import '../../size.config.dart';
import '../../utils/global.colors.dart';
import '../Sales/CheckOut/checkout.view.dart';

class CollectionAdd extends StatefulWidget {
  const CollectionAdd({Key? key}) : super(key: key);

  @override
  State<CollectionAdd> createState() => _CollectionAddState();
}

class _CollectionAddState extends State<CollectionAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.only(
            left: defaultPadding, right: defaultPadding, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Total (10): ",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                Text(
                  "RM 100,000.00",
                  style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ],
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                MaterialPageRoute(builder: (context) => CheckOutPage());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),

            // ElevatedButton(
            //   onPressed: () {
            //     showModalBottomSheet(
            //         backgroundColor: Colors.transparent,
            //         context: context,
            //         builder: (context) {
            //           return AddToCartModal();
            //         });
            //   },
            //   style: ElevatedButton.styleFrom(primary: GlobalColors.mainColor),
            //   child: const Text("Add to Cart"),
            // ),
          ],
        ),
      ),
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "AR-00001",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            color: GlobalColors.mainColor,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Customer",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
            ),
          ),
          CusQuotation(),
          Container(
            color: GlobalColors.mainColor,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Invoice",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(20),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(20),
                dashPattern: [10, 10],
                color: GlobalColors.mainColor.withOpacity(0.50),
                strokeWidth: 2,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: GlobalColors.mainColor,
                      ),
                    ),
                  ),
                ),
              )),
          InvoiceCollection(),
          Container(
            color: GlobalColors.mainColor,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          PriceQuotation(),
        ],
      )),
    );
  }
}
