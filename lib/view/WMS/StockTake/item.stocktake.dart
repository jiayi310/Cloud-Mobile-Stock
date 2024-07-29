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
            final item = widget.stItems[i];
            return Slidable(
              key: Key(item.docID.toString()),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  ElevatedButton(
                      onPressed: () {
                        TextEditingController _amountController =
                            TextEditingController(text: item.qty.toString());
                        double quantity = item.qty ?? 0;

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Edit Quantity'),
                              content: SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          quantity =
                                              (quantity > 0) ? quantity - 1 : 0;
                                          _amountController.text =
                                              quantity.toString();
                                        });
                                      },
                                    ),
                                    Container(
                                      width: 100,
                                      child: TextField(
                                        controller: _amountController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          // Optional: Validate the input here if needed
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          quantity += 1;
                                          _amountController.text =
                                              quantity.toString();
                                        });
                                      },
                                    ),
                                  ],
                                ),
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
                                    // Implement update logic here
                                    setState(() {
                                      item.qty = double.tryParse(
                                              _amountController.text) ??
                                          0;
                                    });
                                    Navigator.of(context).pop();
                                    widget.refreshMainPage();
                                  },
                                  child: Text('Update'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: Icon(
                        Icons.edit,
                      )),
                  ElevatedButton(
                    onPressed: () {
                      final stockTakeProvider = StockTakeProvider.of(context);
                      if (stockTakeProvider != null) {
                        setState(() {
                          final item = widget.stItems[i];
                          stockTakeProvider.stockTake
                              .removeStockTakeDetail(item);
                          widget.refreshMainPage();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Icon(
                      Icons.delete,
                    ),
                  ),
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
                              item.stockCode.toString(),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              item.batchNo.toString(),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              item.storageCode.toString(),
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
                            item.uom ?? "",
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
                            "x " + item.qty!.toStringAsFixed(0),
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
