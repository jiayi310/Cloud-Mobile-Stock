import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobilestock/models/Collection.dart';
import 'package:mobilestock/view/WMS/Putaway/HistoryListing/putaway.listing.dart';
import 'package:mobilestock/view/WMS/Putaway/putaway.add.dart';

import '../../../../api/base.client.dart';
import '../../../../models/PutAway.dart';
import '../../../../utils/global.colors.dart';
import '../../../../utils/loading.dart';
import '../PutAwayProvider.dart';

class PutAwayHomeScreen extends StatefulWidget {
  const PutAwayHomeScreen({Key? key}) : super(key: key);

  @override
  State<PutAwayHomeScreen> createState() => _PutAwayHomeScreen();
}

class _PutAwayHomeScreen extends State<PutAwayHomeScreen> {
  bool _visible = false;
  List<PutAway> PutAwaylist = [], PutAwaylist_search = [];
  final storage = new FlutterSecureStorage();
  String companyid = "";
  List<PutAway> PutAwayFromJson(String str) =>
      List<PutAway>.from(json.decode(str).map((x) => PutAway.fromJson(x)));

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
          PutAwayProviderData? providerData = PutAwayProviderData.of(context);
          if (providerData != null) {
            providerData.clearPutAway();
          }
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PutAwayAdd(putAway: new PutAway())))
              .then((value) => getData());
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
          "PutAway",
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
                                itemCount: PutAwaylist.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int i) {
                                  return Column(
                                    children: [
                                      // for (int i = 0; i < saleslist.length; i++)
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
                                                          PutAwaylist[i]
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
                                              removePutAway(
                                                  PutAwaylist[i].putAwayID);

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
                                                    PutAwayListingScreen(
                                                  docid:
                                                      PutAwaylist[i].putAwayID!,
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
                                                        PutAwaylist[i]
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
                                                      PutAwaylist[i]
                                                          .createdDateTime
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
                                                        (PutAwaylist[i]
                                                                    .stockCode! +
                                                                " " +
                                                                PutAwaylist[i]
                                                                    .description!) ??
                                                            "",
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
                                                      PutAwaylist[i]
                                                          .uom
                                                          .toString(),
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Text(
                                                        PutAwaylist[i]
                                                            .batchNo
                                                            .toString(),
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Text(
                                                        PutAwaylist[i]
                                                            .qty
                                                            .toString(),
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
                                                        PutAwaylist[i]
                                                                .location! +
                                                            " / " +
                                                            PutAwaylist[i]
                                                                .storageCode!,
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
                                                        PutAwaylist[i]
                                                                .receivingDocNo ??
                                                            "",
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

  Future<List<PutAway>> getData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/PutAway/GetPutAwayListByCompanyId?companyId=' + companyid);
      List<PutAway> _PutAwaylist = PutAwayFromJson(response);

      // Sort the collection list by docDate in descending order
      _PutAwaylist.sort(
          (a, b) => b.createdDateTime!.compareTo(a.createdDateTime!));

      // If docDate is the same, sort by docNo in descending order
      _PutAwaylist.sort((a, b) => b.docNo!.compareTo(a.docNo!));

      setState(() {
        PutAwaylist = _PutAwaylist;
        PutAwaylist_search = _PutAwaylist;
        _isLoading = false;
      });
    }
    return PutAwaylist;
  }

  void searchQuery(String query) {
    final suggestions = PutAwaylist_search.where((sales) {
      final docNo = sales.receivingDocNo.toString().toLowerCase();
      // final supCode = sales.supplierCode.toString().toLowerCase() ?? "";
      // final supName = sales.supplierName.toString().toLowerCase() ?? "";
      final desc = sales.description.toString().toLowerCase();
      final input = query.toLowerCase();

      return docNo.contains(input) || desc.contains(input);
    }).toList();

    setState(() {
      PutAwaylist = suggestions;
    });
  }

  Future<void> removePutAway(int? docID) async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient().get('/PutAway/RemovePutAway?docId=' +
          docID.toString() +
          '&companyId=' +
          companyid);

      if (response != 0) {
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
      }
    }
  }
}
