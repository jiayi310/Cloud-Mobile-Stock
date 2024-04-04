import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../api/base.client.dart';
import '../../../models/Sales.dart';
import '../../../utils/global.colors.dart';
import '../../../utils/loading.dart';
import 'history.listing.dart';

class OrderHistoryScreen extends StatefulWidget {
  OrderHistoryScreen();

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreen();
}

class _OrderHistoryScreen extends State<OrderHistoryScreen> {
  List<Sales> saleslist = [], saleslist_search = [];
  bool _visible = false;
  final storage = new FlutterSecureStorage();
  String companyid = "";
  List<Sales> salesFromJson(String str) =>
      List<Sales>.from(json.decode(str).map((x) => Sales.fromJson(x)));

  late final Future myfuture;

  @override
  void initState() {
    super.initState();
    myfuture = getData();
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
          "Order History",
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
                color: GlobalColors.mainColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
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
                              border: InputBorder.none, hintText: "Search"),
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
                          itemCount: saleslist.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int i) {
                            return Column(
                              children: [
                                // for (int i = 0; i < saleslist.length; i++)
                                InkWell(
                                  onLongPress: () {
                                    Get.defaultDialog(
                                        cancelTextColor: GlobalColors.mainColor,
                                        confirmTextColor: Colors.white,
                                        buttonColor: GlobalColors.mainColor,
                                        titlePadding: EdgeInsets.only(top: 20),
                                        title: "Warning",
                                        content: Container(
                                          padding: EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Are you sure want to delete " +
                                                      saleslist[i]
                                                          .docNo
                                                          .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        onConfirm: () {
                                          removeSales(saleslist[i].docID);

                                          // Close the dialog
                                          Get.back();
                                        },
                                        textConfirm: "Confirm",
                                        textCancel: "Cancel");
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HistoryListingScreen(
                                            docid: saleslist[i]!.docID!,
                                          ),
                                        ));
                                  },
                                  child: Container(
                                    height: 130,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                  saleslist[i].docNo.toString(),
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color:
                                                        GlobalColors.mainColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                saleslist[i]
                                                    .docDate
                                                    .toString()
                                                    .substring(0, 10),
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                  saleslist[i]
                                                      .customerCode
                                                      .toString(),
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                "Approved",
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 15,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                  saleslist[i].customerName ??
                                                      "",
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                  saleslist[i].salesAgent ?? "",
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                "RM" +
                                                        saleslist[i]
                                                            .finalTotal
                                                            .toString() ??
                                                    "0.00",
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                    } else
                      return const LoadingPage();
                  }),
            ),

            // SalesCard(
            //   saleslist: saleslist,
            // ),
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

  Future<List<Sales>> getData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/Sales/GetSalesListByCompanyId?companyid=' + companyid);
      List<Sales> _saleslist = salesFromJson(response);

      setState(() {
        saleslist = _saleslist;
        saleslist_search = _saleslist;
      });
    }
    return saleslist;
  }

  void searchQuery(String query) {
    final suggestions = saleslist_search.where((sales) {
      final docNo = sales.docNo.toString().toLowerCase();
      final cusCode = sales.customerCode.toString().toLowerCase() ?? "";
      final cusName = sales.customerName.toString().toLowerCase() ?? "";
      final salesAgent = sales.salesAgent.toString().toLowerCase();
      final input = query.toLowerCase();

      return docNo.contains(input) ||
          cusName.contains(input) ||
          cusCode.contains(input) ||
          salesAgent.contains(input);
    }).toList();

    setState(() {
      saleslist = suggestions;
    });
  }

  Future<void> removeSales(int? docID) async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient().get('/Sales/RemoveSales?docId=' +
          docID.toString() +
          '&companyId=' +
          companyid);

      if (response != 0) {
        getData();
      }
    }
  }
}
