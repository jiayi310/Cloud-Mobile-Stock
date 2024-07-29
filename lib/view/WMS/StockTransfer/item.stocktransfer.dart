import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobilestock/models/StockTransfer.dart';

import 'StockTransferProvider.dart';

class ItemStockTransfer extends StatefulWidget {
  ItemStockTransfer(
      {Key? key,
      required this.stockTransferDetails,
      required this.refreshMainPage})
      : super(key: key);
  List<StockTransferDetails> stockTransferDetails;
  final Function refreshMainPage;

  @override
  State<ItemStockTransfer> createState() => _ItemStockTransferState();
}

class _ItemStockTransferState extends State<ItemStockTransfer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.stockTransferDetails.length,
          itemBuilder: (BuildContext context, int i) {
            final item = widget.stockTransferDetails[i];

            return Slidable(
              key: Key(item.toString()),
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
                      final stockTransferProvider =
                          StockTransferProvider.of(context);
                      if (stockTransferProvider != null) {
                        setState(() {
                          final item = widget.stockTransferDetails[i];
                          stockTransferProvider.stockTransfer
                              .removeStockTransferDetail(item);
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            10.0)), // Adjust the radius as needed
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.stockTransferDetails[i].stockCode
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 14, // Adjust font size as needed
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .black, // Change text color as needed
                                  ),
                                ),
                                Text(
                                  widget.stockTransferDetails[i].description
                                              .toString()
                                              .length >
                                          35
                                      ? widget.stockTransferDetails[i]
                                              .description
                                              .toString()
                                              .substring(0, 30) +
                                          '...'
                                      : widget
                                          .stockTransferDetails[i].description
                                          .toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors
                                        .black, // Change text color as needed
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.stockTransferDetails[i].uom.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors
                                        .black, // Change text color as needed
                                  ),
                                ),
                                Text(
                                  widget.stockTransferDetails[i].batchNo
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors
                                        .black, // Change text color as needed
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(
                                            10)), // Adjust the radius as needed
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        widget.stockTransferDetails[i]
                                            .fromLocation
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .black, // Change text color as needed
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget.stockTransferDetails[i]
                                            .fromStorageCode
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .black, // Change text color as needed
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 24, // Set the desired width here
                                  child: Icon(Icons.arrow_forward_ios_sharp),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(
                                            10)), // Adjust the radius as needed
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        widget
                                            .stockTransferDetails[i].toLocation
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .black, // Change text color as needed
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget.stockTransferDetails[i]
                                            .toStorageCode
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .black, // Change text color as needed
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Qty: " +
                                      widget.stockTransferDetails[i].qty
                                          .toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
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
