import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../api/base.client.dart';
import '../../../models/StockTransfer.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import '../StockTake/product.list.dart';
import 'HistoryListing/StockTransfer.listing.dart';
import 'item.stocktransfer.dart';

class StockTransferAdd extends StatefulWidget {
  StockTransferAdd(
      {Key? key, required this.isEdit, required this.stockTransfer})
      : super(key: key);

  bool isEdit;
  StockTransfer stockTransfer;

  @override
  State<StockTransferAdd> createState() => _StockTransferAddState();
}

class _StockTransferAddState extends State<StockTransferAdd> {
  String docNo = "";
  String companyid = "", userid = "";
  final storage = new FlutterSecureStorage();

  List<StockTransferDetails> stockTransferDetails = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (!widget.isEdit) {
    //   final stockTransferProvider = StockTransferProvider.of(context);
    //   StockTransferDetails = StockTransferProvider?.StockTransfer.StockTransferDetails ?? [];
    // }
  }

  @override
  void initState() {
    if (widget.isEdit) {
      docNo = widget.stockTransfer!.docNo!;
    } else {
      getDocNo();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      // final StockTransferProvider = StockTransferProvider.of(context);
      // if (StockTransferProvider != null) {
      //   StockTransferProvider.setStockTransfer(widget.StockTransfer);
      // }
      // StockTransferDetails = widget.StockTransfer.StockTransferDetails!;
    }
    //  widget.StockTransfer = StockTransferProvider.of(context)!.StockTransfer;
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
                  "Total (" + stockTransferDetails.length.toString() + "): ",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                widget.isEdit
                    ? updateStockTransferData()
                    : sendStockTransferData();
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Stock Transfer Details",
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
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductList(
                                  fromSource: "StockTransfer",
                                ),
                              ))
                          .then((value) => refreshMainPage())
                          .then((returnedData) {
                        if (returnedData != null) {
                          setState(() {
                            stockTransferDetails = returnedData;
                          });
                        }
                      });
                      //   } else {
                      //     Fluttertoast.showToast(
                      //       msg: "Please select a location",
                      //       toastLength:
                      //       Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
                      //       gravity: ToastGravity
                      //           .BOTTOM, // You can set the position (TOP, CENTER, BOTTOM)
                      //       timeInSecForIosWeb:
                      //       1, // Time in seconds before the toast disappears on iOS and web
                      //       backgroundColor: Colors.black,
                      //       textColor: Colors.white,
                      //       fontSize: 16.0,
                      //     );
                      //
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ItemStockTransfer(
              //stItems: StockTransferDetails,
              // refreshMainPage: refreshMainPage,
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
        String response = await BaseClient().get(
            '/StockTransfer/GetNewStockTransferDoc?companyId=' + companyid);

        setState(() {
          docNo = response.toString();
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }

  updateStockTransferData() async {
    companyid = (await storage.read(key: "companyid"))!;
    userid = (await storage.read(key: "userid"))!;
    if (widget.stockTransfer!.docID != null) {
      Map<String, dynamic> jsonData = {
        "docID": widget.stockTransfer!.docID,
        "docNo": docNo,
        "docDate": widget.stockTransfer!.docDate,
        "isVoid": false,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": widget.stockTransfer!.createdDateTime,
        "createdUserID": widget.stockTransfer!.createdUserID,
        "companyID": companyid,
        "StockTransferDetails": stockTransferDetails.map((quoteItem) {
          return {
            "dtlID": quoteItem.dtlID != null ? quoteItem.dtlID : 0,
            "docID": quoteItem.docID != null ? quoteItem.docID : 0,
            "stockID": quoteItem.stockID,
            "stockCode": quoteItem.stockCode.toString(),
            "description": quoteItem.description.toString(),
            "uom": quoteItem.uom.toString(),
            "qty": quoteItem.qty ?? 0,
            "taxableAmt": 0,
            "taxRate": 0,
            "locationID": 1,
            "location": "HQ",
          };
        }).toList(),
      };

      // Encode the JSON data
      String jsonString = jsonEncode(jsonData);

      try {
        final response = await BaseClient().post(
          '/StockTransfer/UpdateStockTransfer?StockTransferId=' +
              widget.stockTransfer.docID.toString(),
          jsonString,
        );

        // Check the status code of the response
        if (response == "true") {
          print('API request successful');

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => StockTransferListingScreen(
          //         docid: int.parse(widget.StockTransfer.docID.toString())),
          //   ),
          // );
          // StockTransferProviderData? providerData =
          // StockTransferProviderData.of(context);
          // if (providerData != null) {
          //   providerData.clearStockTransfer();
          // }
        }
      } catch (e) {
        // Handle exceptions
        print('Exception during API request: $e');
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please select a location",
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

  sendStockTransferData() async {
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
      "companyID": companyid,
      "StockTransferDetails": stockTransferDetails.map((stItem) {
        return {
          "dtlID": 0,
          "docID": 0,
          "stockID": stItem.stockID,
          "stockBatchID": stItem.stockBatchID,
          "batchNo": stItem.batchNo,
          "stockCode": stItem.stockCode.toString(),
          "description": stItem.description.toString(),
          "uom": stItem.uom,
          "qty": stItem.qty ?? 0
        };
      }).toList(),
    };

    // Encode the JSON data
    String jsonString = jsonEncode(jsonData);

    try {
      final response = await BaseClient().post(
        '/StockTransfer/CreateStockTransfer',
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
                StockTransferListingScreen(docid: int.parse(docID)),
          ),
        );
        // StockTransferProviderData? providerData =
        // StockTransferProviderData.of(context);
        // if (providerData != null) {
        //   providerData.clearStockTransfer();
        // }
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during API request: $e');
    }
  }

  refreshMainPage() {
    setState(() {
      // final StockTransferProvider = stockTransferProvider.of(context);
      // if (StockTransferProvider != null) {
      //   stockTransferDetails = StockTransferProvider!.StockTransfer.StockTransferDetails!;
      // }
    });
  }
}
