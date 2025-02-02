import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobilestock/models/Collection.dart';
import '../../../api/base.client.dart';
import '../../../utils/global.colors.dart';
import '../../../utils/loading.dart';
import '../CollectionProvider.dart';
import '../collection.add.dart';
import 'collection.listing.dart';

class CollectionHomeScreen extends StatefulWidget {
  const CollectionHomeScreen({Key? key}) : super(key: key);

  @override
  State<CollectionHomeScreen> createState() => _CollectionHomeScreen();
}

class _CollectionHomeScreen extends State<CollectionHomeScreen> {
  bool _visible = false;
  List<Collection> collectionlist = [], collectionlist_search = [];
  final storage = new FlutterSecureStorage();
  String companyid = "";
  List<Collection> collectionFromJson(String str) => List<Collection>.from(
      json.decode(str).map((x) => Collection.fromJson(x)));

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CollectionProviderData? providerData =
              CollectionProviderData.of(context);
          if (providerData != null) {
            providerData.clearCollection();
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CollectionAdd(
                        isEdit: false,
                        collection: new Collection(paymentTotal: 0),
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
          "Collection",
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
                                itemCount: collectionlist.length,
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
                                                          collectionlist[i]
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
                                                  collectionlist[i].docID);

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
                                                    CollectionListingScreen(
                                                  docid:
                                                      collectionlist[i].docID!,
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
                                                        collectionlist[i]
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
                                                      collectionlist[i]
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
                                                        collectionlist[i]
                                                            .customerCode
                                                            .toString(),
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
                                                      "Approved",
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 15,
                                                        color: Colors.green,
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
                                                        collectionlist[i]
                                                                .customerName ??
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
                                                        collectionlist[i]
                                                                .salesAgent ??
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
                                                    Text(
                                                      "RM" +
                                                              collectionlist[i]
                                                                  .paymentTotal
                                                                  .toStringAsFixed(
                                                                      2) ??
                                                          "0.00",
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.bold,
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

  Future<List<Collection>> getData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/Collection/GetCollectListByCompany?companyid=' + companyid);
      List<Collection> _collectionlist = collectionFromJson(response);

      // Sort the collection list by docDate in descending order
      _collectionlist.sort((a, b) => b.docDate!.compareTo(a.docDate!));

      // If docDate is the same, sort by docNo in descending order
      _collectionlist.sort((a, b) => b.docNo!.compareTo(a.docNo!));

      setState(() {
        collectionlist = _collectionlist;
        collectionlist_search = _collectionlist;
        _isLoading = false;
      });
    }
    return collectionlist;
  }

  void searchQuery(String query) {
    final suggestions = collectionlist_search.where((sales) {
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
      collectionlist = suggestions;
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
