import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/WMS/Picking/HistoryListing/picking.listing.dart';
import 'package:mobilestock/view/WMS/Picking/picking.pickStock.itemEdit.dart';
import 'package:mobilestock/view/WMS/Picking/picking.pickStock.item.dart';

import '../../../api/base.client.dart';
import '../../../models/Picking.dart';
import '../../../models/Sales.dart';
import '../../../size.config.dart';
import 'PickingProvider.dart';

class PickingPickStock extends StatefulWidget {
  PickingPickStock({Key? key, required this.isEdit, required this.picking})
      : super(key: key);

  bool isEdit;
  Picking picking;

  @override
  State<PickingPickStock> createState() => _PickingPickStockState();
}

class _PickingPickStockState extends State<PickingPickStock> {
  String docNo = "";
  String companyid = "", userid = "";
  final storage = new FlutterSecureStorage();
  double totalQty = 0.0;

  List<PickingItems> pickingItems = [];
  List<PickingDetails> pickingDetails = [];

  int pTotalQty = 0;
  int pTotalPickedQty = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      docNo = widget.picking?.docNo ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total quantity as integer
    final totalQty = (widget.picking.pickingItems
                ?.fold(0.0, (sum, item) => sum + (item.qty ?? 0.0)) ??
            0.0)
        .toInt();
    pTotalQty = totalQty;

    // Calculate total picked quantity as integer
    final totalPickedQty = (widget.picking.pickingDetails
                ?.fold(0.0, (sum, detail) => sum + (detail.qty ?? 0.0)) ??
            0.0)
        .toInt();
    pTotalPickedQty = totalPickedQty;

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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                if (widget.isEdit) {
                  updatePickingData();
                } else {
                  updatePickingData();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          docNo,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          SizedBox(
            height: 10,
          ),
          if (widget.picking.pickingItems != null)
            ItemStockTake(
              //pickItems: widget.picking.pickingItems!,
              picking: widget.picking,
              refreshMainPage: refreshMainPage,
            ),
          SizedBox(
            height: 10,
          ),
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
          Container(
            height: 110,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Item',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${widget.picking.pickingItems?.length ?? 0}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Quantity ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${totalQty}',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Picked Quantity',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${totalPickedQty}',
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(now.toUtc());
    return formattedDate;
  }

  updatePickingData() async {
    if (pTotalQty == pTotalPickedQty) {
      saveData();
    } else if (pTotalQty > pTotalPickedQty) {
      // Show a dialog indicating that the picked number exceeds the quantity
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Warning'),
            content: Text(
                'Picked quantity is less than the total quantity. Do you want to continue?'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Return without saving
                },
                child: Text('No'),
              ),
            ],
          );
        },
      );
    } else if (pTotalQty < pTotalPickedQty) {
      // Show a dialog indicating that the picked number exceeds the total quantity
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Warning'),
            content: Text('Picked quantity exceeds the total quantity.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Return without saving
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  refreshMainPage() {
    setState(() {
      pickingItems = pickingItems;
    });
  }

  saveData() async {
    // Read the company ID and user ID from storage
    companyid = (await storage.read(key: "companyid"))!;
    userid = (await storage.read(key: "userid"))!;

    if (widget.picking != null) {
      // Create the JSON payload
      Map<String, dynamic> jsonData = {
        "docID": widget.picking!.docID,
        "docNo": docNo,
        "docDate": widget.picking!.docDate,
        "description": widget.picking.description,
        "remark": widget.picking.remark,
        "isVoid": false,
        "isTransactPending": widget.picking.isTransactPending,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": widget.picking!.createdDateTime,
        "createdUserID": widget.picking!.createdUserID,
        "companyID": companyid,
        "pickingDetails": widget.picking.pickingDetails!.map((pickingDetails) {
          return {
            "dtlID": pickingDetails.dtlID ?? 0,
            "docID": pickingDetails.docID ?? 0,
            "stockID": pickingDetails.stockID,
            "stockBatchID": pickingDetails.stockBatchID ?? 0,
            "batchNo": pickingDetails.batchNo ?? "",
            "stockCode": pickingDetails.stockCode.toString(),
            "description": pickingDetails.description.toString(),
            "uom": pickingDetails.uom.toString(),
            "qty": pickingDetails.qty ?? 0,
            "locationID": pickingDetails.locationID ?? 0,
            "location": pickingDetails.location.toString(),
            "storageID": pickingDetails.storageID ?? 0,
            "storageCode": pickingDetails.storageCode.toString(),
          };
        }).toList(),
        "pickingItems": widget.picking.pickingItems!.map((pickingItems) {
          return {
            "pickingItemID": pickingItems.pickingItemID != null
                ? pickingItems.pickingItemID
                : 0,
            "docID": pickingItems.docID != null ? pickingItems.docID : 0,
            "stockID": pickingItems.stockID,
            "stockCode": pickingItems.stockCode.toString(),
            "description": pickingItems.description.toString(),
            "uom": pickingItems.uom.toString(),
            "qty": pickingItems.qty ?? 0,
            "packingQty": pickingItems.packingQty ?? 0,
            "transactQty": pickingItems.transactQty ?? 0,
            "editTransactQty": pickingItems.editTransactQty ?? 0,
            "locationID": pickingItems.locationID ?? 0,
            "location": pickingItems.location.toString(),
          };
        }).toList(),
      };

      String jsonString = jsonEncode(jsonData);

      try {
        final response = await BaseClient().post(
          '/Picking/CreatePickingDtl?pickingId=${widget.picking.docID}&userId=${widget.picking.createdUserID}',
          jsonString,
        );

        if (response != null) {
          final responseBody = jsonDecode(response);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PickingListingScreen(
                docid: int.parse(widget.picking.docID.toString()),
              ),
            ),
          );

          // Clear stock take data from the provider if it exists
          PickingProviderData? providerData = PickingProviderData.of(context);
          if (providerData != null) {
            providerData.clearPicking();
          }
        } else {
          Fluttertoast.showToast(
            msg: "Update failed: ${response}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (e) {
        // Handle exceptions
        print('Exception during API request: $e');
        Fluttertoast.showToast(
          msg: "Update failed: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please choose a picking",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
