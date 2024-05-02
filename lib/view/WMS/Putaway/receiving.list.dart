import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobilestock/models/Collection.dart';
import 'package:mobilestock/models/Receiving.dart';
import 'package:mobilestock/view/WMS/Putaway/HistoryListing/putaway.listing.dart';
import 'package:mobilestock/view/WMS/Putaway/putaway.add.dart';

import '../../../../api/base.client.dart';
import '../../../../models/PutAway.dart';
import '../../../../utils/global.colors.dart';
import '../../../../utils/loading.dart';

class ReceivingList extends StatefulWidget {
  ReceivingList({Key? key, required this.stockid, required this.uom})
      : super(key: key);
  int stockid;
  String uom;
  @override
  State<ReceivingList> createState() => _ReceivingListState();
}

class _ReceivingListState extends State<ReceivingList> {
  bool _visible = false;
  List<ReceivingPutAway> receivingList = [], receivingList_search = [];
  final storage = new FlutterSecureStorage();
  String companyid = "";
  List<ReceivingPutAway> receivingPutAwayFromJson(String str) =>
      List<ReceivingPutAway>.from(
          json.decode(str).map((x) => ReceivingPutAway.fromJson(x)));

  late final Future myfuture;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    myfuture = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.wmsColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: GlobalColors.mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Receiving List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                _toggle();
              },
              child: Icon(
                Icons.search,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), // Show CircularProgressIndicator while loading
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Visibility(
                    visible: _visible,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: GlobalColors.mainColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              height: 50,
                              width: MediaQuery.of(context).size.width - 110,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search"),
                                onChanged: searchQuery,
                              ),
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.filter_list_alt,
                                  color: GlobalColors.mainColor,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: myfuture,
                        builder: (context, snapshort) {
                          if (snapshort.hasData) {
                            return ListView.builder(
                                itemCount: receivingList.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int i) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pop(context, {
                                        'receivingDocNo':
                                            receivingList[i].docNo,
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 130,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Text(
                                                        receivingList[i]
                                                            .docNo
                                                            .toString(),
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: GlobalColors
                                                              .mainColor,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
                                                    Text(
                                                      receivingList[i]
                                                          .docDate
                                                          .toString()
                                                          .substring(0, 10),
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 15,
                                                        color: Colors.black
                                                            .withOpacity(0.8),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Text(
                                                        receivingList[i]
                                                                .stockCode! +
                                                            " " +
                                                            receivingList[i]
                                                                .description!,
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
                                                    Text(
                                                      receivingList[i].uom ??
                                                          "",
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Text(
                                                        receivingList[i]
                                                            .batchNo
                                                            .toString(),
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Text(
                                                        "Qty: " +
                                                            receivingList[i]
                                                                .qty!
                                                                .toStringAsFixed(
                                                                    0),
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Text(
                                                        "Put Away Qty: " +
                                                            receivingList[i]
                                                                .putAwayQty!
                                                                .toStringAsFixed(
                                                                    0),
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Text(
                                                        "Bal Qty: " +
                                                            receivingList[i]
                                                                .balQty!
                                                                .toStringAsFixed(
                                                                    0),
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          } else
                            return const LoadingPage();
                        }),
                  ),
                ],
              ),
            ),
    );
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  Future<List<ReceivingPutAway>> getData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient().get(
          '/Receiving/GetPutAwayReceivingListbyStockIdAndUom?stockId=' +
              widget.stockid.toString() +
              '&uom=' +
              widget.uom +
              '&companyId=' +
              companyid);
      List<ReceivingPutAway> _receivingList =
          receivingPutAwayFromJson(response);

      // Sort the collection list by docDate in descending order
      _receivingList.sort((a, b) => b.docDate!.compareTo(a.docDate!));

      // If docDate is the same, sort by docNo in descending order
      _receivingList.sort((a, b) => b.docNo!.compareTo(a.docNo!));

      setState(() {
        receivingList = _receivingList;
        receivingList_search = _receivingList;
        _isLoading = false;
      });
    }
    return receivingList;
  }

  void searchQuery(String query) {
    final suggestions = receivingList_search.where((sales) {
      final docNo = sales.docNo.toString().toLowerCase();
      // final supCode = sales.supplierCode.toString().toLowerCase() ?? "";
      // final supName = sales.supplierName.toString().toLowerCase() ?? "";
      final desc = sales.description.toString().toLowerCase();
      final input = query.toLowerCase();

      return docNo.contains(input) || desc.contains(input);
    }).toList();

    setState(() {
      receivingList = suggestions;
    });
  }
}

class ReceivingPutAway {
  int? dtlID;
  int? docID;
  String? docNo;
  String? docDate;
  int? stockID;
  Null? stockBatchID;
  String? batchNo;
  String? stockCode;
  String? description;
  String? uom;
  double? qty;
  double? putAwayQty;
  double? balQty;

  ReceivingPutAway(
      {this.dtlID,
      this.docID,
      this.docNo,
      this.docDate,
      this.stockID,
      this.stockBatchID,
      this.batchNo,
      this.stockCode,
      this.description,
      this.uom,
      this.qty,
      this.putAwayQty,
      this.balQty});

  ReceivingPutAway.fromJson(Map<String, dynamic> json) {
    dtlID = json['dtlID'];
    docID = json['docID'];
    docNo = json['docNo'];
    docDate = json['docDate'];
    stockID = json['stockID'];
    stockBatchID = json['stockBatchID'];
    batchNo = json['batchNo'];
    stockCode = json['stockCode'];
    description = json['description'];
    uom = json['uom'];
    qty = json['qty'];
    putAwayQty = json['putAwayQty'];
    balQty = json['balQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dtlID'] = this.dtlID;
    data['docID'] = this.docID;
    data['docNo'] = this.docNo;
    data['docDate'] = this.docDate;
    data['stockID'] = this.stockID;
    data['stockBatchID'] = this.stockBatchID;
    data['batchNo'] = this.batchNo;
    data['stockCode'] = this.stockCode;
    data['description'] = this.description;
    data['uom'] = this.uom;
    data['qty'] = this.qty;
    data['putAwayQty'] = this.putAwayQty;
    data['balQty'] = this.balQty;
    return data;
  }
}
