import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobilestock/models/Collection.dart';
import 'package:mobilestock/view/WMS/Picking/HistoryListing/picking.listing.dart';

import '../../../../api/base.client.dart';
import '../../../../models/Picking.dart';
import '../../../../utils/global.colors.dart';
import '../../../../utils/loading.dart';

class PickingHomeScreen extends StatefulWidget {
  const PickingHomeScreen({Key? key}) : super(key: key);

  @override
  State<PickingHomeScreen> createState() => _PickingHomeScreen();
}

class _PickingHomeScreen extends State<PickingHomeScreen> {
  bool _visible = false;
  List<Picking> Pickinglist = [], Pickinglist_search = [];
  final storage = new FlutterSecureStorage();
  String companyid = "";
  List<Picking> PickingFromJson(String str) =>
      List<Picking>.from(json.decode(str).map((x) => Picking.fromJson(x)));

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
          // PickingProviderData? providerData =
          //     PickingProviderData.of(context);
          // if (providerData != null) {
          //   providerData.clearPicking();
          // }
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => PickingAdd(
          //               isEdit: false,
          //               Picking: new Picking(paymentTotal: 0),
          //             ))).then((value) => getData());
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
          "Picking",
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
                                itemCount: Pickinglist.length,
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
                                                          Pickinglist[i]
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
                                              removeCollection(
                                                  Pickinglist[i].docID);

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
                                                    PickingListingScreen(
                                                  docid: Pickinglist[i].docID!,
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          height: 70,
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
                                                        Pickinglist[i]
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
                                                      Pickinglist[i]
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
                                                        Pickinglist[i]
                                                                .description ??
                                                            "",
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          color: Colors.black,
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

  Future<List<Picking>> getData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/Picking/GetPickingListByCompanyId?companyId=' + companyid);
      List<Picking> _Pickinglist = PickingFromJson(response);

      // Sort the collection list by docDate in descending order
      _Pickinglist.sort((a, b) => b.docDate!.compareTo(a.docDate!));

      // If docDate is the same, sort by docNo in descending order
      _Pickinglist.sort((a, b) => b.docNo!.compareTo(a.docNo!));

      setState(() {
        Pickinglist = _Pickinglist;
        Pickinglist_search = _Pickinglist;
        _isLoading = false;
      });
    }
    return Pickinglist;
  }

  void searchQuery(String query) {
    final suggestions = Pickinglist_search.where((sales) {
      final docNo = sales.docNo.toString().toLowerCase();
      final desc = sales.description.toString().toLowerCase();
      final input = query.toLowerCase();

      return docNo.contains(input) || desc.contains(input);
    }).toList();

    setState(() {
      Pickinglist = suggestions;
    });
  }

  Future<void> removeCollection(int? docID) async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient().get(
          '/Collection/RemoveCollection?docId=' +
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
