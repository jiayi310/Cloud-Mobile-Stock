import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api/base.client.dart';
import '../../../models/Location.dart';
import '../../../models/Stock.dart';
import '../../../models/StockTransfer.dart';
import '../../../models/Stock_.dart' as StockModel;
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import 'dart:math' as math;

import '../StockTake/StockTakeProvider.dart';
import 'StockTransferProvider.dart';

class TransferSelection extends StatefulWidget {
  TransferSelection({Key? key, required this.stock}) : super(key: key);
  Stock stock;

  @override
  State<TransferSelection> createState() => _TransferSelectionState();
}

class _TransferSelectionState extends State<TransferSelection> {
  StockModel.StockUOMDtoList? uomSelected;
  StockModel.StockBatchDtoList? batchSelected;
  String companyid = "";
  List<Location> locationList = [];
  List<LocationDropDown> storageList = [];
  String fromstoragecode = "",
      tostoragecode = "",
      fromlocation = "",
      tolocation = "";
  int fromstorageID = 0, tostorageID = 0, fromlocationID = 0, tolocationID = 0;
  final storage = new FlutterSecureStorage();
  List<Location> locationFromJson(String str) =>
      List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));
  List<LocationDropDown> storageFromJson(String str) =>
      List<LocationDropDown>.from(
          json.decode(str).map((x) => LocationDropDown.fromJson(x)));
  StockModel.Stock_ stock = new StockModel.Stock_();
  StockModel.Stock_ stockFromJson(String str) =>
      StockModel.Stock_.fromJson(json.decode(str));

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
  void initState() {
    // TODO: implement initState
    getStock(widget.stock.stockID!);
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
                //!widget.isEdit ? postData() : updateData();
                addItem();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
                      DropdownButton<StockModel.StockUOMDtoList>(
                        value: uomSelected,
                        onChanged: (StockModel.StockUOMDtoList? newValue) {
                          setState(() {
                            uomSelected = newValue!;
                          });
                        },
                        items: (stock.stockUOMDtoList ?? [])
                            .map<DropdownMenuItem<StockModel.StockUOMDtoList>>(
                                (uom) {
                          return DropdownMenuItem<StockModel.StockUOMDtoList>(
                            value: uom,
                            child: Text(uom.uom ??
                                ''), // Accessing properties with dot notation
                          );
                        }).toList(),
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
                        "Batch",
                        style: TextStyle(
                            color: GlobalColors.mainColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<StockModel.StockBatchDtoList>(
                        value: batchSelected,
                        onChanged: (StockModel.StockBatchDtoList? newValue) {
                          setState(() {
                            batchSelected = newValue;
                          });
                        },
                        items: (stock.stockBatchDtoList ??
                                []) // Check if stockUOMDtoList is null
                            .map<
                                DropdownMenuItem<
                                    StockModel.StockBatchDtoList>>((batch) {
                          return DropdownMenuItem<StockModel.StockBatchDtoList>(
                            value:
                                batch, // Accessing properties with dot notation
                            child: Text(
                              batch.batchNo ?? '',
                            ), // Accessing properties with dot notation
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //Transfer From
            Container(
              color: GlobalColors.mainColor,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Transfer From",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () async {
                          await getLocationData();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Choose a Location'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      for (int i = 0;
                                          i < locationList.length;
                                          i++)
                                        ListTile(
                                          title: Text(locationList[i]
                                              .location
                                              .toString()),
                                          onTap: () {
                                            setState(() {
                                              fromlocationID =
                                                  locationList[i].locationID!;
                                              fromlocation = locationList[i]
                                                  .location
                                                  .toString();
                                            });

                                            Navigator.pop(context);
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (fromlocation == "")
                              Text(
                                "Select a location",
                                style: TextStyle(color: Colors.red),
                              ),
                            if (fromlocation != "") Text(fromlocation),
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
                        "Storage",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () async {
                          if (fromlocationID == 0) {
                            Fluttertoast.showToast(
                                msg: "Please select the location");
                          } else {
                            await getStorageData(fromlocationID);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Choose a Storage'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        for (int i = 0;
                                            i <
                                                storageList[0]
                                                    .storageDropdownDtoList!
                                                    .length;
                                            i++)
                                          ListTile(
                                            title: Text(storageList[0]
                                                .storageDropdownDtoList![i]
                                                .storageCode
                                                .toString()),
                                            onTap: () {
                                              setState(() {
                                                fromstoragecode = storageList[0]
                                                    .storageDropdownDtoList![i]
                                                    .storageCode
                                                    .toString();

                                                fromstorageID = storageList[0]
                                                    .storageDropdownDtoList![i]
                                                    .storageID!;
                                              });

                                              Navigator.pop(context);
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (fromstoragecode == "")
                              Text(
                                "Select a storage",
                                style: TextStyle(color: Colors.red),
                              ),
                            if (fromstoragecode != "") Text(fromstoragecode),
                            Icon(Icons.chevron_right_outlined),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Transform.rotate(
              angle: 180 * math.pi / 360,
              child: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColors.mainColor,
              ),
            ),
            Transform.rotate(
              angle: 180 * math.pi / 360,
              child: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColors.mainColor,
              ),
            ),
            Transform.rotate(
              angle: 180 * math.pi / 360,
              child: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColors.mainColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //Transfer To
            Container(
              color: GlobalColors.mainColor,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Transfer To",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () async {
                          await getLocationData();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Choose a Location'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      for (int i = 0;
                                          i < locationList.length;
                                          i++)
                                        ListTile(
                                          title: Text(locationList[i]
                                              .location
                                              .toString()),
                                          onTap: () {
                                            setState(() {
                                              tolocationID =
                                                  locationList[i].locationID!;
                                              tolocation = locationList[i]
                                                  .location
                                                  .toString();
                                            });

                                            Navigator.pop(context);
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (tolocation == "")
                              Text(
                                "Select a location",
                                style: TextStyle(color: Colors.red),
                              ),
                            if (tolocation != "") Text(tolocation),
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
                        "Storage",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () async {
                          if (tolocationID == 0) {
                            Fluttertoast.showToast(
                                msg: "Please select the location");
                          } else {
                            await getStorageData(tolocationID);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Choose a Storage'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        for (int i = 0;
                                            i <
                                                storageList[0]
                                                    .storageDropdownDtoList!
                                                    .length;
                                            i++)
                                          ListTile(
                                            title: Text(storageList[0]
                                                .storageDropdownDtoList![i]
                                                .storageCode
                                                .toString()),
                                            onTap: () {
                                              setState(() {
                                                tostoragecode = storageList[0]
                                                    .storageDropdownDtoList![i]
                                                    .storageCode
                                                    .toString();

                                                tostorageID = storageList[0]
                                                    .storageDropdownDtoList![i]
                                                    .storageID!;
                                              });

                                              Navigator.pop(context);
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (tostoragecode == "")
                              Text(
                                "Select a storage",
                                style: TextStyle(color: Colors.red),
                              ),
                            if (tostoragecode != "") Text(tostoragecode),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              textAlign: TextAlign.right,
                              controller: TextEditingController(
                                  text: _quantity.toStringAsFixed(
                                      0)), // Use a controller to set the initial value
                              readOnly:
                                  true, // Make the TextFormField read-only
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
          ],
        ),
      ),
    );
  }

  Future<List<Location>> getLocationData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/Location/GetLocationList?companyid=' + companyid);
      List<Location> _locationList = locationFromJson(response);

      setState(() {
        locationList = _locationList;
      });
    }
    return locationList;
  }

  Future<List<LocationDropDown>> getStorageData(int locationID) async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient().get(
          '/Location/GetLocationWithStorage?companyId=' +
              companyid +
              '&currentLocationId=' +
              locationID.toString());
      List<LocationDropDown> _storageList = storageFromJson(response);

      setState(() {
        storageList = _storageList;
      });
    }
    return storageList;
  }

  void addItem() {
    if (uomSelected == null || uomSelected!.uom!.isEmpty) {
      Fluttertoast.showToast(msg: "Please select a UOM");
      return;
    }

    if (batchSelected == null || batchSelected!.batchNo!.isEmpty) {
      Fluttertoast.showToast(msg: "Please select a batch");
      return;
    }

    if (fromlocation!.isEmpty || fromlocation == "") {
      Fluttertoast.showToast(msg: "Please select a location");
      return;
    }

    if (fromstoragecode!.isEmpty || fromstoragecode == "") {
      Fluttertoast.showToast(msg: "Please select a storage");
      return;
    }

    if (tolocation.isEmpty || tolocation == "") {
      Fluttertoast.showToast(msg: "Please select a location");
      return;
    }

    if (tostoragecode!.isEmpty || tostoragecode == "") {
      Fluttertoast.showToast(msg: "Please select a storage");
      return;
    }

    if (fromlocation == tolocation && fromstoragecode == tostoragecode) {
      Fluttertoast.showToast(msg: "Transfer From and Transfer To is same");
      return;
    }

    if (_quantity == 0) {
      Fluttertoast.showToast(msg: "Quantity cannot be zero");
      return;
    }

    StockTransferDetails stockTransferDetail = new StockTransferDetails();
    stockTransferDetail.stockID = widget.stock.stockID;
    if (batchSelected != null) {
      stockTransferDetail.stockBatchID = batchSelected!.stockBatchID;
    }

    stockTransferDetail.batchNo = batchSelected!.batchNo;
    stockTransferDetail.stockCode = stock.stockCode;
    stockTransferDetail.description = stock.description;
    stockTransferDetail.uom = uomSelected!.uom;
    stockTransferDetail.qty = _quantity;
    stockTransferDetail.fromLocationID = fromlocationID;
    stockTransferDetail.fromLocation = fromlocation;
    stockTransferDetail.fromStorageID = fromstorageID;
    stockTransferDetail.fromStorageCode = fromstoragecode;
    stockTransferDetail.toLocationID = tolocationID;
    stockTransferDetail.toLocation = tolocation;
    stockTransferDetail.toStorageID = tostorageID;
    stockTransferDetail.toStorageCode = tostoragecode;

    final stockTransferProvider = StockTransferProvider.of(context);
    if (stockTransferProvider != null) {
      stockTransferProvider!.addstockTransferDetail(stockTransferDetail);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Future<StockModel.Stock_> getStock(int stockID) async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/Stock/GetStock?stockId=' + stockID.toString());
      StockModel.Stock_ _stock = stockFromJson(response);

      setState(() {
        stock = _stock;
      });
    }
    return stock;
  }
}
