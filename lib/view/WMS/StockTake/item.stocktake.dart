import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilestock/models/StockTake.dart';

import '../../../utils/global.colors.dart';
import 'StockTakeProvider.dart';

class ItemStockTake extends StatefulWidget {
  ItemStockTake(
      {Key? key, required this.stItems, required this.refreshMainPage})
      : super(key: key);
  List<StockTakeDetails> stItems;
  final Function refreshMainPage;
  @override
  State<ItemStockTake> createState() => _ItemStockTakeState();
}

class _ItemStockTakeState extends State<ItemStockTake> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.stItems.length,
          itemBuilder: (BuildContext context, int i) {
            final item = widget.stItems[i].docID;
            return Slidable(
              key: Key(item.toString()),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  ElevatedButton(
                      onPressed: () {
                        TextEditingController _amountController =
                            TextEditingController();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Change Payment Amount'),
                            content: TextField(
                              // You can customize this text field according to your needs
                              decoration: InputDecoration(
                                hintText: 'Enter new amount',
                              ),
                              keyboardType: TextInputType.number,
                              controller:
                                  _amountController, // Assign the controller
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    double newAmount = double.tryParse(
                                            _amountController.text) ??
                                        0.0;
                                    if (newAmount != null &&
                                        newAmount <=
                                            (widget.stItems[i].qty ?? 0.0)) {
                                      final stockTakeProvider =
                                          StockTakeProvider.of(context);
                                      if (stockTakeProvider != null) {
                                        // stockTakeProvider.stockTake
                                        //     .updateAmount(
                                        //         widget.stItems[i].salesDocID!,
                                        //         newAmount);
                                        widget.refreshMainPage();
                                      }
                                      Fluttertoast.showToast(
                                        msg: "Changed",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                      Navigator.of(context).pop();
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Payment Amount > Sales Amount",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
                                  });
                                },
                                child: Text('Save'),
                              ),
                            ],
                          ),
                        );
                        widget.refreshMainPage();
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: Icon(
                        Icons.edit,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final stockTakeProvider =
                              StockTakeProvider.of(context);
                          if (stockTakeProvider != null) {
                            //   stockTakeProvider.stockTake.removeItem(item!);
                            widget.refreshMainPage();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: Icon(
                        Icons.delete,
                      )),
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
                    Expanded(
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.stItems[i].stockCode.toString(),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              widget.stItems[i].batchNo.toString(),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              widget.stItems[i].storageCode.toString(),
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
                            (widget.stItems[i].uom ?? ""),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: GlobalColors.mainColor,
                            ),
                          ),
                          Text(
                            "",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "x " + widget.stItems[i].qty!.toStringAsFixed(0),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
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
