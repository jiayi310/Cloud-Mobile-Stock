import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/Receiving.dart';
import 'package:mobilestock/view/WMS/Receiving/product.receiving.dart';
import 'package:mobilestock/view/WMS/Receiving/receiving.item.dart';
import 'package:mobilestock/view/WMS/Receiving/receiving.supplier.dart';

import '../../../api/base.client.dart';
import '../../../models/Receiving.dart';
import '../../../models/Stock.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import 'HistoryListing/receiving.listing.dart';
import 'ReceivingProvider.dart';

class ReceivingAdd extends StatefulWidget {
  ReceivingAdd({Key? key, required this.isEdit, required this.receiving})
      : super(key: key);

  bool isEdit;
  Receiving receiving;

  @override
  State<ReceivingAdd> createState() => _ReceivingAddState();
}

class _ReceivingAddState extends State<ReceivingAdd> {
  String docNo = "";
  String companyid = "", userid = "";
  final storage = new FlutterSecureStorage();

  List<ReceivingDetails> receivingDetails = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!widget.isEdit) {
      final receivingProvider = ReceivingProvider.of(context);
      receivingDetails = receivingProvider?.receiving.receivingDetails ?? [];
    }
  }

  @override
  void initState() {
    if (widget.isEdit) {
      docNo = widget.receiving!.docNo!;
    } else {
      getDocNo();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      final receivingProvider = ReceivingProvider.of(context);
      if (receivingProvider != null) {
        receivingProvider.setReceiving(widget.receiving);
      }
      receivingDetails = widget.receiving.receivingDetails!;
      if (widget.isEdit &&
          receivingProvider!.receiving.receivingDetails!.isNotEmpty) {
        updateSalesItemsWithImages(
            receivingProvider.receiving.receivingDetails!);
      }
    }
    widget.receiving = ReceivingProvider.of(context)!.receiving;
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
                widget.isEdit ? updateReceivingData() : sendReceivingData();
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
                    "Supplier",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
            ),
          ),
          SupReceiving(),
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
                            builder: (context) => ReceivingProductList(),
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
          ItemReceiving(
            receivingDetails: receivingDetails,
            refreshMainPage: refreshMainPage,
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
            .get('/Receiving/GetNewReceivingDoc?companyId=' + companyid);

        setState(() {
          docNo = response.toString();
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }

  updateReceivingData() async {
    companyid = (await storage.read(key: "companyid"))!;
    userid = (await storage.read(key: "userid"))!;
    if (widget.receiving!.supplierCode != null) {
      Map<String, dynamic> jsonData = {
        "docID": widget.receiving!.docID,
        "docNo": docNo,
        "docDate": widget.receiving!.docDate,
        "supplierID": widget.receiving!.supplierID,
        "supplierCode": widget.receiving!.supplierCode.toString(),
        "supplierName": widget.receiving!.supplierName.toString(),
        "address1": widget.receiving!.address1.toString(),
        "address2": widget.receiving!.address2.toString(),
        "address3": widget.receiving!.address3.toString(),
        "address4": widget.receiving!.address4.toString(),
        "phone": widget.receiving!.phone.toString(),
        "email": widget.receiving!.email.toString(),
        "isVoid": false,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": widget.receiving!.createdDateTime,
        "createdUserID": widget.receiving!.createdUserID,
        "companyID": companyid,
        "receivingDetails": receivingDetails.map((quoteItem) {
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
          '/Receiving/UpdateReceiving?ReceivingId=' +
              widget.receiving.docID.toString(),
          jsonString,
        );

        // Check the status code of the response
        if (response == "true") {
          print('API request successful');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ReceivingListingScreen(
                  docid: int.parse(widget.receiving.docID.toString())),
            ),
          );
          ReceivingProviderData? providerData =
              ReceivingProviderData.of(context);
          if (providerData != null) {
            providerData.clearReceiving();
          }
        }
      } catch (e) {
        // Handle exceptions
        print('Exception during API request: $e');
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please select a supplier",
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

  sendReceivingData() async {
    if (widget.receiving!.supplierCode != null) {
      Map<String, dynamic> jsonData = {
        "docID": 0,
        "docNo": docNo,
        "docDate": getCurrentDateTime(),
        "supplierID": widget.receiving!.supplierID,
        "supplierCode": widget.receiving!.supplierCode.toString(),
        "supplierName": widget.receiving!.supplierName.toString(),
        "address1": widget.receiving!.address1.toString(),
        "address2": widget.receiving!.address2.toString(),
        "address3": widget.receiving!.address3.toString(),
        "address4": widget.receiving!.address4.toString(),
        "phone": widget.receiving!.phone.toString(),
        "email": widget.receiving!.email.toString(),
        "isVoid": false,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": getCurrentDateTime(),
        "createdUserID": userid,
        "companyID": companyid,
        "receivingDetails": receivingDetails.map((quoteItem) {
          return {
            "dtlID": 0,
            "docID": 0,
            "stockID": quoteItem.stockID,
            "stockCode": quoteItem.stockCode.toString(),
            "description": quoteItem.description.toString(),
            "uom": quoteItem.uom.toString(),
            "qty": quoteItem.qty ?? 0,
            "locationID": 1,
            "location": "HQ",
          };
        }).toList(),
      };

      // Encode the JSON data
      String jsonString = jsonEncode(jsonData);

      try {
        final response = await BaseClient().post(
          '/Receiving/CreateReceiving',
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
                  ReceivingListingScreen(docid: int.parse(docID)),
            ),
          );
          ReceivingProviderData? providerData =
              ReceivingProviderData.of(context);
          if (providerData != null) {
            providerData.clearReceiving();
          }
        }
      } catch (e) {
        // Handle exceptions
        print('Exception during API request: $e');
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please select a supplier",
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
      receivingDetails = receivingDetails;
    });
  }

  void updateSalesItemsWithImages(
      List<ReceivingDetails> ReceivingDetailsList) async {
    for (final receivingitem in ReceivingDetailsList) {
      if (receivingitem.stockID != null && receivingitem.image == null) {
        // Check if image is null
        final response = await BaseClient()
            .get('/Stock/GetStock?stockId=' + receivingitem.stockID.toString());

        final _product = StockDetail.fromJson(jsonDecode(response));

        setState(() {
          receivingitem.image =
              Base64Decoder().convert(_product.image.toString());
        });
      }
    }
  }
}
