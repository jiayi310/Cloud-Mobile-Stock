import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/StockTake.dart';
import 'package:mobilestock/view/WMS/StockTake/item.stocktake.dart';
import 'package:mobilestock/view/WMS/StockTake/product.list.dart';

import '../../../api/base.client.dart';
import '../../../models/Stock.dart';
import '../../../models/StockTake.dart';
import '../../../models/StockTake.dart';
import '../../../models/StockTake.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import '../../Quotation/NewQuotation/product.quotation.dart';
import '../../Sales/CheckOut/checkout.view.dart';
import 'HistoryListing/stocktake.listing.dart';
import 'StockTakeProvider.dart';
import 'location.stocktake.dart';

class StockTakeAdd extends StatefulWidget {
  StockTakeAdd({Key? key, required this.isEdit, required this.stockTake})
      : super(key: key);

  bool isEdit;
  StockTake stockTake;

  @override
  State<StockTakeAdd> createState() => _StockTakeAddState();
}

class _StockTakeAddState extends State<StockTakeAdd> {
  String docNo = "";
  String companyid = "", userid = "";
  final storage = new FlutterSecureStorage();

  List<StockTakeDetails> stockTakeDetails = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!widget.isEdit) {
      final stockTakeProvider = StockTakeProvider.of(context);
      stockTakeDetails = stockTakeProvider?.stockTake.stockTakeDetails ?? [];
    }
  }

  @override
  void initState() {
    if (widget.isEdit) {
      docNo = widget.stockTake!.docNo!;
    } else {
      getDocNo();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      final stockTakeProvider = StockTakeProvider.of(context);
      if (stockTakeProvider != null) {
        stockTakeProvider.setStockTake(widget.stockTake);
      }
      stockTakeDetails = widget.stockTake.stockTakeDetails!;
      if (widget.isEdit &&
          stockTakeProvider!.stockTake.stockTakeDetails!.isNotEmpty) {
        //updateStockTakeDetails(stockTakeProvider.stockTake.stockTakeDetails);
      }
    }
    widget.stockTake = StockTakeProvider.of(context)!.stockTake;
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
            Row(
              children: [
                Text(
                  "Total (" + stockTakeDetails.length.toString() + "): ",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                widget.isEdit ? updateStockTakeData() : sendStockTakeData();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  widget.isEdit ? "Update" : "Confirm",
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
                    "Location",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
            ),
          ),
          LocStockTake(),
          Container(
            color: GlobalColors.mainColor,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Product",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (widget.stockTake!.location != null) {
                        var stProvider = Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductList(
                                    fromSource: "StockTake",
                                  ),
                                ))
                            .then((value) => refreshMainPage())
                            .then((returnedData) {
                          if (returnedData != null) {
                            setState(() {
                              stockTakeDetails = returnedData;
                            });
                          }
                        });
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please select a location",
                          toastLength:
                              Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
                          gravity: ToastGravity
                              .BOTTOM, // You can set the position (TOP, CENTER, BOTTOM)
                          timeInSecForIosWeb:
                              1, // Time in seconds before the toast disappears on iOS and web
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ItemStockTake(
            stItems: stockTakeDetails,
            refreshMainPage: refreshMainPage,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }

  void getDocNo() async {
    try {
      companyid = (await storage.read(key: "companyid"))!;
      userid = (await storage.read(key: "userid"))!;
      if (companyid != null) {
        String response = await BaseClient()
            .get('/StockTake/GetNewStockTakeDoc?companyId=' + companyid);

        setState(() {
          docNo = response.toString();
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }

  updateStockTakeData() async {
    companyid = (await storage.read(key: "companyid"))!;
    userid = (await storage.read(key: "userid"))!;
    if (widget.stockTake!.stockTakeDetails != null) {
      Map<String, dynamic> jsonData = {
        "docID": widget.stockTake!.docID,
        "docNo": docNo,
        "docDate": widget.stockTake!.docDate,
        "description": widget.stockTake!.description,
        "remark": widget.stockTake!.remark,
        "isMerge": widget.stockTake!.isMerge,
        "mergeDocID": widget.stockTake!.mergeDocID,
        "mergeDocNo": widget.stockTake!.mergeDocNo,
        "mergeDate": widget.stockTake!.mergeDate,
        "isAdjustment": widget.stockTake!.isAdjustment,
        "adjustmentDocID": widget.stockTake!.adjustmentDocID,
        "adjustmentDocNo": widget.stockTake!.adjustmentDocNo,
        "adjustmentDate": widget.stockTake!.adjustmentDate,
        "isVoid": false,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": widget.stockTake!.createdDateTime,
        "createdUserID": widget.stockTake!.createdUserID,
        "locationID": widget.stockTake!.locationID,
        "location": widget.stockTake!.location,
        "companyID": companyid,
        "stockTakeDetails": stockTakeDetails.map((quoteItem) {
          return {
            "dtlID": quoteItem.dtlID != null ? quoteItem.dtlID : 0,
            "docID": quoteItem.docID != null ? quoteItem.docID : 0,
            "stockID": quoteItem.stockID,
            "stockBatchID": quoteItem.stockBatchID,
            "batchNo": quoteItem.batchNo,
            "stockCode": quoteItem.stockCode.toString(),
            "description": quoteItem.description.toString(),
            "uom": quoteItem.uom.toString(),
            "qty": quoteItem.qty ?? 0,
            "locationID": 1,
            "storageID": quoteItem.storageID ?? 0,
            "storageCode": quoteItem.storageCode.toString(),
          };
        }).toList(),
      };

      // Encode the JSON data
      String jsonString = jsonEncode(jsonData);
      print("--------------------------------");
      print("jsonData: ${jsonString}");
      print("--------------------------------");

      try {
        final response = await BaseClient().post(
          '/StockTake/UpdateStockTake?docId=' +
              widget.stockTake.docID.toString(),
          jsonString,
        );

        // Check the status code of the response
        if (response == null) {
          print('Response is null');
          Fluttertoast.showToast(
            msg: "Update failed: No response from server",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          // Check the status code of the response
          if (response == "true") {
            print('API request successful');

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StockTakeListingScreen(
                  docid: int.parse(widget.stockTake.docID.toString()),
                ),
              ),
            );
            StockTakeProviderData? providerData =
                StockTakeProviderData.of(context);
            if (providerData != null) {
              providerData.clearStockTake();
            }
          } else {
            print('Edit: Running here5');
            print('API request unsuccessful: ${response.body}');
            Fluttertoast.showToast(
              msg: "Update failed: ${response.body}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
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
        msg: "Update failed: No stock take details",
        toastLength: Toast.LENGTH_SHORT,
        // or Toast.LENGTH_LONG
        gravity: ToastGravity.BOTTOM,
        // You can set the position (TOP, CENTER, BOTTOM)
        timeInSecForIosWeb: 1,
        // Time in seconds before the toast disappears on iOS and web
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(now.toUtc());
    return formattedDate;
  }

  sendStockTakeData() async {
    if (widget.stockTake!.locationID != null) {
      Map<String, dynamic> jsonData = {
        "docID": 0,
        "docNo": docNo,
        "docDate": getCurrentDateTime(),
        "description": null,
        "remark": null,
        "isMerge": false,
        "isAdjustment": false,
        "isVoid": false,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": getCurrentDateTime(),
        "createdUserID": userid,
        "locationID": widget.stockTake.locationID,
        "location": widget.stockTake.location,
        "companyID": companyid,
        "stockTakeDetails": stockTakeDetails.map((stItem) {
          return {
            "dtlID": 0,
            "docID": 0,
            "stockID": stItem.stockID,
            "stockBatchID": stItem.stockBatchID,
            "batchNo": stItem.batchNo,
            "stockCode": stItem.stockCode.toString(),
            "description": stItem.description.toString(),
            "uom": stItem.uom,
            "qty": stItem.qty ?? 0,
            "locationID": stItem.locationID,
            "storageID": stItem.storageID,
            "storageCode": stItem.storageCode
          };
        }).toList(),
      };

      // Encode the JSON data
      String jsonString = jsonEncode(jsonData);

      try {
        final response = await BaseClient().post(
          '/StockTake/CreateStockTake',
          jsonString,
        );

        // Check the status code of the response
        if (response != null) {
          Map<String, dynamic> responseBody = json.decode(response);
          String docID = responseBody['docID'].toString();

          print('API request successful');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  StockTakeListingScreen(docid: int.parse(docID)),
            ),
          );
          StockTakeProviderData? providerData =
              StockTakeProviderData.of(context);
          if (providerData != null) {
            providerData.clearStockTake();
          }
        }
      } catch (e) {
        // Handle exceptions
        print('Exception during API request: $e');
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please select a location",
        toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
        gravity: ToastGravity
            .BOTTOM, // You can set the position (TOP, CENTER, BOTTOM)
        timeInSecForIosWeb:
            1, // Time in seconds before the toast disappears on iOS and web
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  refreshMainPage() {
    setState(() {
      final stockTakeProvider = StockTakeProvider.of(context);
      if (stockTakeProvider != null) {
        stockTakeDetails = stockTakeProvider!.stockTake.stockTakeDetails!;
      }
    });
  }

  // void updateStockTakeDetails(
  //     List<StockTakeDetails>? stockTakeDetailsList) async {
  //   for (final stockTakeItem in stockTakeDetailsList!) {
  //     if (stockTakeItem.stockID != null) {
  //       final response = await BaseClient()
  //           .get('/Stock/GetStock?stockId=' + stockTakeItem.stockID.toString());
  //
  //       final _product = StockTakeDetails.fromJson(jsonDecode(response));
  //
  //       setState(() {});
  //     }
  //   }
  // }
}
