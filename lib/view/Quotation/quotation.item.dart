import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobilestock/models/Quotation.dart';
import 'package:mobilestock/models/Sales.dart';
import 'package:mobilestock/view/Quotation/QuotationProvider.dart';
import 'package:mobilestock/view/Sales/Cart/cart.add.dart';

import '../../../models/Stock.dart';
import '../../../utils/global.colors.dart';

class ItemQuotation extends StatefulWidget {
  ItemQuotation(
      {Key? key, required this.quotationDetails, required this.refreshMainPage})
      : super(key: key);
  List<QuotationDetails> quotationDetails;
  final Function refreshMainPage;

  @override
  State<ItemQuotation> createState() => _ItemQuotationState();
}

class _ItemQuotationState extends State<ItemQuotation> {
  _ItemQuotationState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.quotationDetails.length,
          itemBuilder: (BuildContext context, int i) {
            final item = widget.quotationDetails[i].stockCode;
            return Slidable(
              key: Key(item.toString()),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final quotationProvider =
                              QuotationProvider.of(context);
                          if (quotationProvider != null && item != null) {
                            quotationProvider.quotation.removeItem(item);
                            widget.refreshMainPage();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: Icon(
                        Icons.delete,
                      ))
                ],
              ),
              child: Container(
                height: 110,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    if (widget.quotationDetails[i].image != null &&
                        widget.quotationDetails[i].image!.length > 0)
                      Container(
                        height: 70,
                        width: 70,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 224, 224, 244),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.memory(
                            widget.quotationDetails[i].image ?? Uint8List(0)),
                      ),
                    if (widget.quotationDetails[i].image == null ||
                        widget.quotationDetails[i].image!.isEmpty)
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
                              widget.quotationDetails[i].stockCode.toString(),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              widget.quotationDetails[i].description.toString(),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              widget.quotationDetails[i].uom.toString(),
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
                            "X " + widget.quotationDetails[i].qty.toString(),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12,
                              color: GlobalColors.mainColor,
                            ),
                          ),
                          Text(
                            "RM " +
                                widget.quotationDetails[i].unitPrice.toString(),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: GlobalColors.mainColor,
                            ),
                          ),
                          // AddCartButtonCart(
                          //   salesItem: new SalesItem(),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
