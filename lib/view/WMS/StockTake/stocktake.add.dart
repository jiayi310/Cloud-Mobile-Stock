import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/StockTake.dart';
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
      // final stockTakeProvider = StockTakeProvider.of(context);
      // StockTakeDetails = StockTakeProvider?.StockTake.StockTakeDetails ?? [];
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
      // final StockTakeProvider = StockTakeProvider.of(context);
      // if (StockTakeProvider != null) {
      //   StockTakeProvider.setStockTake(widget.StockTake);
      // }
      // StockTakeDetails = widget.StockTake.StockTakeDetails!;
      // if (widget.isEdit &&
      //     StockTakeProvider!.StockTake.StockTakeDetails.isNotEmpty) {
      //   updateSalesItemsWithImages(
      //       StockTakeProvider.StockTake.StockTakeDetails);
      // }
    }
    // widget.stockTake = StockTakeProvider.of(context)!.StockTake;
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductList(),
                          )).then((value) => refreshMainPage());
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // ItemStockTake(
          //   StockTakeDetails: StockTakeDetails,
          //   refreshMainPage: refreshMainPage,
          // ),
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
    if (widget.stockTake!.docNo != null) {
      Map<String, dynamic> jsonData = {
        "docID": widget.stockTake!.docID,
        "docNo": docNo,
        "docDate": widget.stockTake!.docDate,
        "isVoid": false,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": widget.stockTake!.createdDateTime,
        "createdUserID": widget.stockTake!.createdUserID,
        "companyID": companyid,
        "stockTakeDetails": stockTakeDetails.map((quoteItem) {
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
          '/StockTake/UpdateStockTake?StockTakeId=' +
              widget.stockTake.docID.toString(),
          jsonString,
        );

        // Check the status code of the response
        if (response == "true") {
          print('API request successful');

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => StockTakeListingScreen(
          //         docid: int.parse(widget.StockTake.docID.toString())),
          //   ),
          // );
          // StockTakeProviderData? providerData =
          // StockTakeProviderData.of(context);
          // if (providerData != null) {
          //   providerData.clearStockTake();
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

  sendStockTakeData() async {
    if (widget.stockTake!.docID != null) {
      Map<String, dynamic> jsonData = {
        "docID": 0,
        "docNo": docNo,
        "docDate": getCurrentDateTime(),
        "isVoid": false,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": getCurrentDateTime(),
        "createdUserID": userid,
        "companyID": companyid,
        "StockTakeDetails": stockTakeDetails.map((quoteItem) {
          return {
            "dtlID": 0,
            "docID": 0,
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
          '/StockTake/CreateStockTake',
          jsonString,
        );

        // Check the status code of the response
        if (response != null) {
          Map<String, dynamic> responseBody = json.decode(response);
          String docID = responseBody['docID'].toString();

          print('API request successful');

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         StockTakeListingScreen(docid: int.parse(docID)),
          //   ),
          // );
          // StockTakeProviderData? providerData =
          // StockTakeProviderData.of(context);
          // if (providerData != null) {
          //   providerData.clearStockTake();
          // }
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
      stockTakeDetails = stockTakeDetails;
    });
  }
}
