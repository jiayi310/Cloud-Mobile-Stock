import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/view/Quotation/NewQuotation/quotation.customer.dart';
import 'package:mobilestock/view/Quotation/quotation.item.dart';
import 'package:mobilestock/view/Quotation/NewQuotation/quotation.total.dart';

import '../../../utils/global.colors.dart';
import '../../Sales/CheckOut/checkout.bottom.dart';

class QuotationAdd extends StatefulWidget {
  const QuotationAdd({Key? key}) : super(key: key);

  @override
  State<QuotationAdd> createState() => _QuotationAddState();
}

class _QuotationAddState extends State<QuotationAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CheckOutBottomBar(),
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "QT-00001",
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
                    "Product",
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
          ItemQuotation(),
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
