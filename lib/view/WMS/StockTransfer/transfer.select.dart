import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/Stock.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';

class TransferSelection extends StatefulWidget {
  TransferSelection({Key? key, required this.stock}) : super(key: key);
  Stock stock;

  @override
  State<TransferSelection> createState() => _TransferSelectionState();
}

class _TransferSelectionState extends State<TransferSelection> {
  double _quantity = 0;

  void _decrement() {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
      }
    });
  }

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.stock.stockCode.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [],
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.only(
            left: defaultPadding, right: defaultPadding, bottom: 30, top: 20),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                // //!widget.isEdit ? postData() : updateData();
                // addItem();
                // StockTakeDetails stockTakeDetail = new StockTakeDetails();
                // stockTakeDetail.stockID = stock.stockID;
                // stockTakeDetail.stockBatchID = batchSelected!.stockBatchID;
                // stockTakeDetail.batchNo = batchSelected!.batchNo;
                // stockTakeDetail.stockCode = stock.stockCode;
                // stockTakeDetail.description = stock.description;
                // stockTakeDetail.uom = uomSelected!.uom;
                // stockTakeDetail.qty = _quantity;
                // stockTakeDetail.storageID = storageID;
                // stockTakeDetail.storageCode = storagecode;
                //
                // final stockTakeProvider = StockTakeProvider.of(context);
                // if (stockTakeProvider != null) {
                //   stockTakeDetail.locationID =
                //       stockTakeProvider.stockTake.locationID;
                //   stockTakeProvider!.addStockTakeDetail(stockTakeDetail);
                // }stockTakeDetail
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 110,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "UOM",
                  style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                // DropdownButton<StockModel.StockUOMDtoList>(
                //   value: uomSelected,
                //   onChanged: (StockModel.StockUOMDtoList? newValue) {
                //     setState(() {
                //       uomSelected = newValue!;
                //     });
                //   },
                //   items: (stock.stockUOMDtoList ?? [])
                //       .map<DropdownMenuItem<StockModel.StockUOMDtoList>>((uom) {
                //     return DropdownMenuItem<StockModel.StockUOMDtoList>(
                //       value: uom,
                //       child: Text(uom.uom ??
                //           ''), // Accessing properties with dot notation
                //     );
                //   }).toList(),
                // )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Batch",
                  style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                // DropdownButton<StockModel.StockBatchDtoList>(
                //   value: batchSelected,
                //   onChanged: (StockModel.StockBatchDtoList? newValue) {
                //     setState(() {
                //       batchSelected = newValue;
                //     });
                //   },
                //   items: (stock.stockBatchDtoList ??
                //       []) // Check if stockUOMDtoList is null
                //       .map<DropdownMenuItem<StockModel.StockBatchDtoList>>(
                //           (batch) {
                //         return DropdownMenuItem<StockModel.StockBatchDtoList>(
                //           value: batch, // Accessing properties with dot notation
                //           child: Text(
                //             batch.batchNo ?? '',
                //           ), // Accessing properties with dot notation
                //         );
                //       }).toList(),
                // ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Storage",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                InkWell(
                  onTap: () async {
                    // int locationID = 0;
                    // final stockTakeProvider = StockTakeProvider.of(context);
                    // if (stockTakeProvider != null &&
                    //     stockTakeProvider.stockTake.locationID != null) {
                    //   locationID = stockTakeProvider.stockTake.locationID!;
                    // }
                    //
                    // if (locationID == 0) {
                    //   Fluttertoast.showToast(msg: "Please select the location");
                    // } else {
                    //   await getLocationData(locationID);
                    //   showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return AlertDialog(
                    //         title: Text('Choose an Item'),
                    //         content: SingleChildScrollView(
                    //           child: Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: <Widget>[
                    //               for (int i = 0;
                    //               i <
                    //                   locationList[0]
                    //                       .storageDropdownDtoList!
                    //                       .length;
                    //               i++)
                    //                 ListTile(
                    //                   title: Text(locationList[0]
                    //                       .storageDropdownDtoList![i]
                    //                       .storageCode
                    //                       .toString()),
                    //                   onTap: () {
                    //                     setState(() {
                    //                       storagecode = locationList[0]
                    //                           .storageDropdownDtoList![i]
                    //                           .storageCode
                    //                           .toString();
                    //
                    //                       storageID = locationList[0]
                    //                           .storageDropdownDtoList![i]
                    //                           .storageID!;
                    //                     });
                    //
                    //                     Navigator.pop(context);
                    //                   },
                    //                 ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   );
                    // }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // if (storagecode == "") Text("Select a storage"),
                      // if (storagecode != "") Text(storagecode),
                      Icon(Icons.chevron_right_outlined),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Qty",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: _decrement,
                    ),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]')), // Allow only numbers
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        textAlign: TextAlign.right,
                        controller: TextEditingController(
                            text: _quantity.toStringAsFixed(
                                0)), // Use a controller to set the initial value
                        readOnly: true, // Make the TextFormField read-only
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _increment,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
