import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/Quotation.dart';
import 'package:mobilestock/view/Quotation/HistoryListing/details.listing.dart';
import 'package:mobilestock/view/Quotation/NewQuotation/product.quotation.dart';
import 'package:mobilestock/view/Quotation/NewQuotation/quotation.customer.dart';
import 'package:mobilestock/view/Quotation/quotation.item.dart';

import '../../../api/base.client.dart';
import '../../../models/Stock.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import '../../Sales/CheckOut/checkout.view.dart';
import '../QuotationProvider.dart';

class QuotationAdd extends StatefulWidget {
  QuotationAdd({Key? key, required this.isEdit, required this.quotation})
      : super(key: key);

  bool isEdit;
  Quotation quotation;

  @override
  State<QuotationAdd> createState() => _QuotationAddState();
}

class _QuotationAddState extends State<QuotationAdd> {
  String docNo = "";
  String companyid = "", userid = "";
  final storage = new FlutterSecureStorage();

  List<QuotationDetails> quotationDetails = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!widget.isEdit) {
      final quotationProvider = QuotationProvider.of(context);
      quotationDetails = quotationProvider?.quotation.quotationDetails ?? [];
    }
  }

  @override
  void initState() {
    if (widget.isEdit) {
      docNo = widget.quotation!.docNo!;
    } else {
      getDocNo();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      final quotationProvider = QuotationProvider.of(context);
      if (quotationProvider != null) {
        quotationProvider.setQuotation(widget.quotation);
      }
      quotationDetails = widget.quotation.quotationDetails!;
      if (widget.isEdit &&
          quotationProvider!.quotation.quotationDetails.isNotEmpty) {
        updateSalesItemsWithImages(
            quotationProvider.quotation.quotationDetails);
      }
    }
    widget.quotation = QuotationProvider.of(context)!.quotation;
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
                  "Total (" + quotationDetails.length.toString() + "): ",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                Text(
                  "RM ${widget.quotation?.calculateTotalPrice()?.toStringAsFixed(2) ?? '0.00'}",
                  style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ],
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                widget.isEdit ? updateQuotationData() : sendQuotationData();
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
                    "Customer",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
            ),
          ),
          CusQuotation(),
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
                            builder: (context) => QuotationProductList(),
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
          ItemQuotation(
            quotationDetails: quotationDetails,
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
                      'SubTotal',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " ${widget.quotation?.finalTotal?.toStringAsFixed(2) ?? '0.00'}",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tax',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '0.00',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '0.00',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.quotation?.finalTotal?.toStringAsFixed(2) ?? '0.00'}",
                    ),
                  ],
                ),
              ],
            ),
          )
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
            .get('/Quotation/GetNewQuoteDoc?companyId=' + companyid);

        setState(() {
          docNo = response.toString();
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }

  updateQuotationData() async {
    companyid = (await storage.read(key: "companyid"))!;
    userid = (await storage.read(key: "userid"))!;
    if (widget.quotation!.customerCode != null) {
      Map<String, dynamic> jsonData = {
        "docID": widget.quotation!.docID,
        "docNo": docNo,
        "docDate": widget.quotation!.docDate,
        "customerID": widget.quotation!.customerID,
        "customerCode": widget.quotation!.customerCode.toString(),
        "customerName": widget.quotation!.customerName.toString(),
        "address1": widget.quotation!.address1.toString(),
        "address2": widget.quotation!.address2.toString(),
        "address3": widget.quotation!.address3.toString(),
        "address4": widget.quotation!.address4.toString(),
        "salesAgent": widget.quotation!.salesAgent ?? null,
        "phone": widget.quotation!.phone.toString(),
        "email": widget.quotation!.email.toString(),
        "subtotal": widget.quotation!.subtotal ?? 0.00,
        "taxableAmt": widget.quotation!.taxableAmt ?? 0.00,
        "taxAmt": widget.quotation!.taxAmt ?? 0.00,
        "finalTotal": widget.quotation!.finalTotal ?? 0.00,
        "isVoid": false,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": widget.quotation!.createdDateTime,
        "createdUserID": widget.quotation!.createdUserID,
        "companyID": companyid,
        "quotationDetails": quotationDetails.map((quoteItem) {
          return {
            "dtlID": quoteItem.dtlID != null ? quoteItem.dtlID : 0,
            "docID": quoteItem.docID != null ? quoteItem.docID : 0,
            "stockID": quoteItem.stockID,
            "stockCode": quoteItem.stockCode.toString(),
            "description": quoteItem.description.toString(),
            "uom": quoteItem.uom.toString(),
            "qty": quoteItem.qty ?? 0,
            "unitPrice": quoteItem.unitPrice ?? 0,
            "discount": quoteItem.discount ?? 0,
            "total": quoteItem.total,
            "taxableAmt": 0,
            "taxRate": 0,
            "taxAmt": quoteItem.taxAmt ?? 0,
            "locationID": 1,
            "location": "HQ",
          };
        }).toList(),
      };

      // Encode the JSON data
      String jsonString = jsonEncode(jsonData);

      try {
        final response = await BaseClient().post(
          '/Quotation/UpdateQuotation?quotationId=' +
              widget.quotation.docID.toString(),
          jsonString,
        );

        // Check the status code of the response
        if (response == "true") {
          print('API request successful');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => QuotationListingScreen(
                  docid: int.parse(widget.quotation.docID.toString())),
            ),
          );
          QuotationProviderData? providerData =
              QuotationProviderData.of(context);
          if (providerData != null) {
            providerData.clearQuotation();
          }
        }
      } catch (e) {
        // Handle exceptions
        print('Exception during API request: $e');
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please select a customer",
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

  sendQuotationData() async {
    if (widget.quotation!.customerCode != null) {
      Map<String, dynamic> jsonData = {
        "docID": 0,
        "docNo": docNo,
        "docDate": getCurrentDateTime(),
        "customerID": widget.quotation!.customerID,
        "customerCode": widget.quotation!.customerCode.toString(),
        "customerName": widget.quotation!.customerName.toString(),
        "address1": widget.quotation!.address1 ?? "",
        "address2": widget.quotation!.address2 ?? "",
        "address3": widget.quotation!.address3 ?? "",
        "address4": widget.quotation!.address4 ?? "",
        "salesAgent": widget.quotation!.salesAgent ?? null,
        "phone": widget.quotation!.phone ?? "",
        "email": widget.quotation!.email ?? "",
        "subtotal": widget.quotation!.subtotal ?? 0.00,
        "taxableAmt": widget.quotation!.taxableAmt ?? 0.00,
        "taxAmt": widget.quotation!.taxAmt ?? 0.00,
        "finalTotal": widget.quotation!.finalTotal ?? 0.00,
        "isVoid": false,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": getCurrentDateTime(),
        "createdUserID": userid,
        "companyID": companyid,
        "quotationDetails": quotationDetails.map((quoteItem) {
          return {
            "dtlID": 0,
            "docID": 0,
            "stockID": quoteItem.stockID,
            "stockCode": quoteItem.stockCode.toString(),
            "description": quoteItem.description.toString(),
            "uom": quoteItem.uom.toString(),
            "qty": quoteItem.qty ?? 0,
            "unitPrice": quoteItem.unitPrice ?? 0,
            "discount": quoteItem.discount ?? 0,
            "total": quoteItem.total,
            "taxableAmt": 0,
            "taxRate": 0,
            "taxAmt": quoteItem.taxAmt ?? 0,
            "locationID": 1,
            "location": "HQ",
          };
        }).toList(),
      };

      // Encode the JSON data
      String jsonString = jsonEncode(jsonData);

      try {
        final response = await BaseClient().post(
          '/Quotation/CreateQuotation',
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
                  QuotationListingScreen(docid: int.parse(docID)),
            ),
          );
          QuotationProviderData? providerData =
              QuotationProviderData.of(context);
          if (providerData != null) {
            providerData.clearQuotation();
          }

          widget.quotation.customerID = null;
          widget.quotation.customerCode = null;
          widget.quotation.customerName = null;
          widget.quotation.address1 = null;
          widget.quotation.address2 = null;
          widget.quotation.address3 = null;
          widget.quotation.address4 = null;
          widget.quotation.salesAgent = null;
          widget.quotation.phone = null;
          widget.quotation.email = null;
        }
      } catch (e) {
        // Handle exceptions
        print('Exception during API request: $e');
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please select a customer",
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
      quotationDetails = quotationDetails;
    });
  }

  void updateSalesItemsWithImages(
      List<QuotationDetails> quotationDetailsList) async {
    for (final salesItem in quotationDetailsList) {
      if (salesItem.stockID != null && salesItem.image == null) {
        // Check if image is null
        final response = await BaseClient()
            .get('/Stock/GetStock?stockId=' + salesItem.stockID.toString());

        final _product = StockDetail.fromJson(jsonDecode(response));

        setState(() {
          salesItem.image = Base64Decoder().convert(_product.image.toString());
        });
      }
    }
  }
}
