import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/PutAway.dart';
import 'package:mobilestock/view/WMS/Putaway/product.putaway.dart';
import 'package:mobilestock/view/WMS/Putaway/receiving.list.dart';

import '../../../api/base.client.dart';
import '../../../models/Location.dart';
import '../../../models/PutAway.dart';
import '../../../models/Stock.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import '../../General/Location/location.home.dart';
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
      description = "",
      uom = "-",
      receivingDocNo = "";
  double balQty = 0;
  int stockid = 0, receivingID = 0, storageID = 0;
  final storage = new FlutterSecureStorage();
  Location? location = new Location();
  List<LocationDropDown> locationList = [];
  String storagecode = "";
  List<LocationDropDown> storageFromJson(String str) =>
      List<LocationDropDown>.from(
          json.decode(str).map((x) => LocationDropDown.fromJson(x)));

  int _quantity = 0;

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
                          description = value['description'];
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
                      "Stock",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(stockcode + " " + description),
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
                            receivingID = value['receivingID'];
                            receivingDocNo = value['receivingDocNo'];
                            balQty = value['balQty'];

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
                      child: Row(
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
                          Text(
                            "Balance Qty: " + balQty.toStringAsFixed(0),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.red,
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
          if (stockid != 0 &&
              stockcode != "-" &&
              uom != "-" &&
              receivingDocNo != "")
            Column(
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
                                      text: _quantity
                                          .toString()), // Use a controller to set the initial value
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
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _navigateTolocationScreen(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Location",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (location == null ||
                                    location!.location == null)
                                  Text("Select a location"),
                                if (location != null &&
                                    location!.location != null)
                                  Text(
                                    location!.location.toString(),
                                  ),
                                Icon(Icons.chevron_right_outlined),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        height: 20,
                      ),
                      SizedBox(
                        height: 10,
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
                              if (location!.locationID == null) {
                                Fluttertoast.showToast(
                                    msg: "Please select the location");
                              } else {
                                await getLocationData();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Choose an Item'),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            for (int i = 0;
                                                i <
                                                    locationList[0]
                                                        .storageDropdownDtoList!
                                                        .length;
                                                i++)
                                              ListTile(
                                                title: Text(locationList[0]
                                                    .storageDropdownDtoList![i]
                                                    .storageCode
                                                    .toString()),
                                                onTap: () {
                                                  setState(() {
                                                    storagecode = locationList[
                                                            0]
                                                        .storageDropdownDtoList![
                                                            i]
                                                        .storageCode
                                                        .toString();

                                                    storageID = locationList[0]
                                                        .storageDropdownDtoList![
                                                            i]
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
                                if (storagecode == "") Text("Select a storage"),
                                if (storagecode != "") Text(storagecode),
                                Icon(Icons.chevron_right_outlined),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
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
    if (stockid != 0) {
      if (receivingID != 0) {
        if (location!.locationID != null) {
          if (storageID != 0) {
            Map<String, dynamic> jsonData = {
              "putAwayID": 0,
              "docNo": docNo,
              "stockID": stockid,
              "stockCode": stockcode,
              "description": description,
              "uom": uom,
              "qty": _quantity,
              "receivingDocNo": receivingDocNo,
              "receivingDtlID": receivingID,
              "locationID": location!.locationID,
              "location": location!.location.toString(),
              "storageID": storageID,
              "storageCode": storagecode,
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

              if (response != null) {
                Map<String, dynamic> responseBody = json.decode(response);
                String docID = responseBody['putAwayID'].toString();

                print('API request successful');

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PutAwayListingScreen(docid: int.parse(docID)),
                  ),
                );
                PutAwayProviderData? providerData =
                    PutAwayProviderData.of(context);
                if (providerData != null) {
                  providerData.clearPutAway();
                }
              }
            } catch (e) {
              // Handle exceptions
              print('Exception during API request: $e');
            }
          } else {
            Fluttertoast.showToast(msg: "Please select the storage");
          }
        } else {
          Fluttertoast.showToast(msg: "Please select the location");
        }
      } else {
        Fluttertoast.showToast(msg: "Please select a Receiving Document");
      }
    } else {
      Fluttertoast.showToast(msg: "Please select a product");
    }
  }

  refreshMainPage() {
    setState(() {
      widget.putAway = widget.putAway;
    });
  }

  Future<void> _navigateTolocationScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationHomeScreen(
                  FromSource: "PutAway",
                )));

    setState(() {
      location = result;
    });
  }

  Future<List<LocationDropDown>> getLocationData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient().get(
          '/Location/GetLocationWithStorage?companyId=' +
              companyid +
              '&currentLocationId=' +
              location!.locationID.toString());
      List<LocationDropDown> _locationList = storageFromJson(response);

      setState(() {
        locationList = _locationList;
      });
    }
    return locationList;
  }
}
