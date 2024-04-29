import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobilestock/models/Collection.dart';
import 'package:mobilestock/view/WMS/StockTake/HistoryListing/stocktake.listing.dart';

import '../../../../api/base.client.dart';
import '../../../../models/StockTake.dart';
import '../../../../utils/global.colors.dart';
import '../../../../utils/loading.dart';
import '../stocktake.add.dart';

class StockTakeHomeScreen extends StatefulWidget {
  const StockTakeHomeScreen({Key? key}) : super(key: key);

  @override
  State<StockTakeHomeScreen> createState() => _StockTakeHomeScreen();
}

class _StockTakeHomeScreen extends State<StockTakeHomeScreen> {
  bool _visible = false;
  List<StockTake> stockTakeList = [], stockTakeList_search = [];
  final storage = new FlutterSecureStorage();
  String companyid = "";
  List<StockTake> StockTakeFromJson(String str) =>
      List<StockTake>.from(json.decode(str).map((x) => StockTake.fromJson(x)));

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // StockTakeProviderData? providerData =
          //     StockTakeProviderData.of(context);
          // if (providerData != null) {
          //   providerData.clearStockTake();
          // }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StockTakeAdd(
                        isEdit: false,
                        stockTake: new StockTake(),
                      ))).then((value) => getData());
        },
        child: Icon(Icons.add),
        backgroundColor: GlobalColors.mainColor,
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: GlobalColors.mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "StockTake",
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
                                itemCount: stockTakeList.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int i) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onLongPress: () {
                                          Get.defaultDialog(
                                            cancelTextColor:
                                                GlobalColors.mainColor,
                                            confirmTextColor: Colors.white,
                                            buttonColor: GlobalColors.mainColor,
                                            titlePadding:
                                                EdgeInsets.only(top: 20),
                                            title: "Warning",
                                            content: Container(
                                              padding: EdgeInsets.all(20.0),
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      "Are you sure want to delete " +
                                                          stockTakeList[i]
                                                              .docNo
                                                              .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            textConfirm: "Confirm",
                                            textCancel: "Cancel",
                                            onConfirm: () {
                                              removeStockTake(
                                                  stockTakeList[i].docID);

                                              // Close the dialog
                                              Get.back();
                                            },
                                          );
                                        },
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StockTakeListingScreen(
                                                  docid:
                                                      stockTakeList[i].docID!,
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          height: 100,
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
                                                        stockTakeList[i]
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
                                                      stockTakeList[i]
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
                                                        stockTakeList[i]
                                                                .location ??
                                                            "",
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Text(
                                                        (stockTakeList[i]
                                                                    ?.isAdjustment ??
                                                                false)
                                                            ? "Adjustment"
                                                            : (stockTakeList[i]
                                                                        ?.isMerge ??
                                                                    false)
                                                                ? "Merge"
                                                                : "",
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          color: Colors.purple,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
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

  Future<List<StockTake>> getData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/StockTake/GetstockTakeListByCompanyId?companyId=' + companyid);
      List<StockTake> _stockTakeList = StockTakeFromJson(response);

      // Sort the StockTake list by docDate in descending order
      _stockTakeList.sort((a, b) => b.docDate!.compareTo(a.docDate!));

      // If docDate is the same, sort by docNo in descending order
      _stockTakeList.sort((a, b) => b.docNo!.compareTo(a.docNo!));

      setState(() {
        stockTakeList = _stockTakeList;
        stockTakeList_search = _stockTakeList;
        _isLoading = false;
      });
    }
    return stockTakeList;
  }

  void searchQuery(String query) {
    final suggestions = stockTakeList_search.where((sales) {
      final docNo = sales.docNo.toString().toLowerCase();
      final loc = sales.location.toString().toLowerCase() ?? "";
      final desc = sales.description.toString().toLowerCase();
      final input = query.toLowerCase();

      return docNo.contains(input) ||
          loc.contains(input) ||
          desc.contains(input);
    }).toList();

    setState(() {
      stockTakeList = suggestions;
    });
  }

  Future<void> removeStockTake(int? docID) async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      var response = await BaseClient().get(
          '/StockTake/RemoveStockTake?docId=' +
              docID.toString() +
              '&companyId=' +
              companyid);

      if (response != null) {
        Fluttertoast.showToast(
          msg: 'Deleted successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        getData();
      } else {
        Fluttertoast.showToast(
          msg: 'Cannot be deleted',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }
}
