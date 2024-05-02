import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/PutAway.dart';
import 'package:mobilestock/view/WMS/Putaway/product.putaway.dart';
import 'package:mobilestock/view/WMS/Putaway/receiving.list.dart';

import '../../../api/base.client.dart';
import '../../../models/PutAway.dart';
import '../../../models/Stock.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import 'HistoryListing/PutAway.listing.dart';
import 'PutAwayProvider.dart';

class PutAwayAdd extends StatefulWidget {
  PutAwayAdd({Key? key, required this.putAway}) : super(key: key);
  PutAway putAway;

  @override
  State<PutAwayAdd> createState() => _PutAwayAddState();
}

class _PutAwayAddState extends State<PutAwayAdd> {
  String docNo = "";
  String companyid = "",
      userid = "",
      stockcode = "-",
      uom = "-",
      receivingDocNo = "";
  int stockid = 0;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    getDocNo();
  }

  @override
  Widget build(BuildContext context) {
    //  widget.putAway = PutAwayProvider.of(context)!.putAway;
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
                sendPutAwayData();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Confirm",
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
                          builder: (context) => PutAwayProductList(),
                        ),
                      ).then((value) {
                        if (value != null) {
                          stockid = value['stockId'];
                          stockcode = value['stockCode'];
                          uom = value['selectedUOM'];

                          refreshMainPage();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Stock Code",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(stockcode),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "UOM",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(uom)
                  ],
                )
              ],
            ),
          ),
          Container(
            color: GlobalColors.mainColor,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select a Receiving Doc:",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (stockid != 0 && stockcode != "-" && uom != "-") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ReceivingList(stockid: stockid, uom: uom),
                          ),
                        ).then((value) {
                          if (value != null) {
                            receivingDocNo = value['receivingDocNo'];

                            refreshMainPage();
                          }
                        });
                      } else {
                        Fluttertoast.showToast(msg: "Please select a product");
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
          if (receivingDocNo != "")
            Container(
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 200,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            receivingDocNo,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Storage",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Qty",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Quantity',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter quantity';
                          }
                          // You can add additional validation if needed
                          return null;
                        },
                        onSaved: (value) {
                          // You can handle the value here when the form is saved
                        },
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
                      "Location",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Quantity',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter quantity';
                          }
                          // You can add additional validation if needed
                          return null;
                        },
                        onSaved: (value) {
                          // You can handle the value here when the form is saved
                        },
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
                      "Storage",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Quantity',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter quantity';
                          }
                          // You can add additional validation if needed
                          return null;
                        },
                        onSaved: (value) {
                          // You can handle the value here when the form is saved
                        },
                      ),
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
            .get('/PutAway/GetNewPutAwayDoc?companyId=' + companyid);

        setState(() {
          docNo = response.toString();
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }

  getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(now.toUtc());
    return formattedDate;
  }

  sendPutAwayData() async {
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
    };

    // Encode the JSON data
    String jsonString = jsonEncode(jsonData);

    try {
      final response = await BaseClient().post(
        '/PutAway/CreatePutAway',
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
            builder: (context) => PutAwayListingScreen(docid: int.parse(docID)),
          ),
        );
        PutAwayProviderData? providerData = PutAwayProviderData.of(context);
        if (providerData != null) {
          providerData.clearPutAway();
        }
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during API request: $e');
    }
  }

  refreshMainPage() {
    setState(() {
      widget.putAway = widget.putAway;
    });
  }
}
