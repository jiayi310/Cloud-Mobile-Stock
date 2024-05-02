import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobilestock/models/Receiving.dart';
import 'package:mobilestock/models/Sales.dart';
import 'package:mobilestock/view/Sales/Cart/cart.add.dart';

import '../../../models/Receiving.dart';
import '../../../models/Stock.dart';
import '../../../utils/global.colors.dart';
import 'ReceivingProvider.dart';

class ItemReceiving extends StatefulWidget {
  ItemReceiving(
      {Key? key, required this.receivingDetails, required this.refreshMainPage})
      : super(key: key);
  List<ReceivingDetails> receivingDetails;
  final Function refreshMainPage;

  @override
  State<ItemReceiving> createState() => _ItemReceivingState();
}

class _ItemReceivingState extends State<ItemReceiving> {
  _ItemReceivingState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.receivingDetails.length,
          itemBuilder: (BuildContext context, int i) {
            final item = widget.receivingDetails[i].stockCode;
            return Slidable(
              key: Key(item.toString()),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final receivingProvider =
                              ReceivingProvider.of(context);
                          if (receivingProvider != null && item != null) {
                            receivingProvider.receiving.removeItem(item);
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
                    if (widget.receivingDetails[i].image != null &&
                        widget.receivingDetails[i].image!.length > 0)
                      Container(
                        height: 70,
                        width: 70,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 224, 224, 244),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.memory(
                            widget.receivingDetails[i].image ?? Uint8List(0)),
                      ),
                    if (widget.receivingDetails[i].image == null ||
                        widget.receivingDetails[i].image!.isEmpty)
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
                              widget.receivingDetails[i].stockCode.toString(),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              widget.receivingDetails[i].description.toString(),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              widget.receivingDetails[i].uom.toString(),
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
                            "X " + widget.receivingDetails[i].qty.toString(),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12,
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
