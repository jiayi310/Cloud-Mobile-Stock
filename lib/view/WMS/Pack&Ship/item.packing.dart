import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilestock/models/Packing.dart';
import 'package:mobilestock/view/Sales/Cart/cart.add.dart';

import '../../../models/Stock.dart';
import '../../../utils/global.colors.dart';
import 'PackingProvider.dart';

class ItemPacking extends StatefulWidget {
  ItemPacking({Key? key, required this.pakItems, required this.refreshMainPage})
      : super(key: key);
  List<PackingDetails> pakItems;
  final Function refreshMainPage;

  @override
  State<ItemPacking> createState() => _ItemPackingState();
}

class _ItemPackingState extends State<ItemPacking> {
  _ItemPackingState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.pakItems.length,
          itemBuilder: (BuildContext context, int i) {
            final item = widget.pakItems[i];
            final itemCode = widget.pakItems[i].stockCode;
            final batchNo = widget.pakItems[i].batchNo;
            final itemDescription = widget.pakItems[i].description;
            final uom = widget.pakItems[i].uom;
            final quantity = widget.pakItems[i].qty;

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
                      final packingProvider = PackingProvider.of(context);
                      if (packingProvider != null) {
                        setState(() {
                          final item = widget.pakItems[i];
                          packingProvider.packing.removePackingDetail(item);
                          widget.refreshMainPage();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Icon(Icons.delete),
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$itemCode',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'x $quantity',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: GlobalColors.mainColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '$itemDescription',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${batchNo ?? ""}',
                        ),
                        Text(
                          '$uom',
                        ),
                      ],
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
