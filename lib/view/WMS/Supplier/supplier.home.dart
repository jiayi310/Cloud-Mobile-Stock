import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/WMS/Supplier/supplier.add.dart';
import 'package:mobilestock/view/WMS/Supplier/supplier.details.dart';

import '../../../api/base.client.dart';
import '../../../models/Supplier.dart';
import '../../../utils/loading.dart';

class SupplierHomeScreen extends StatefulWidget {
  SupplierHomeScreen({Key? key, this.FromSource}) : super(key: key);
  String? FromSource;

  @override
  State<SupplierHomeScreen> createState() =>
      _SupplierHomeScreen(FromSource: FromSource);
}

class _SupplierHomeScreen extends State<SupplierHomeScreen> {
  String? FromSource;
  _SupplierHomeScreen({Key? key, this.FromSource});
  bool shouldShowFB = true;
  bool _visible = false;
  List<Supplier> Supplierlist = [];
  List<Supplier> Supplierlist_search = [];
  String companyid = "";
  final storage = new FlutterSecureStorage();
  List<Supplier> userFromJson(String str) =>
      List<Supplier>.from(json.decode(str).map((x) => Supplier.fromJson(x)));

  late final Future myfuture;

  @override
  void initState() {
    super.initState();
    myfuture = getSupplierData();
    if (FromSource != null) {
      shouldShowFB = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.wmsColor,
      floatingActionButton: Visibility(
        visible: shouldShowFB,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewSupplier(
                          isEdit: false,
                          supplier: Supplier(),
                        ))).then((value) {
              if (value == "Done") getSupplierData();
            });
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.pinkAccent,
        ),
      ),
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Supplier",
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
      body: SingleChildScrollView(
        child: Padding(
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
                        color: GlobalColors.mainColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: 50,
                          width: MediaQuery.of(context).size.width - 118,
                          child: TextFormField(
                            onChanged: searchQuery,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Search"),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(Icons.camera_alt)),
                      ],
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                  future: myfuture,
                  builder: (context, snapshort) {
                    if (snapshort.hasData) {
                      return ListView.builder(
                          itemCount: Supplierlist.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            return InkWell(
                              onLongPress: () {
                                if (FromSource == null)
                                  Get.defaultDialog(
                                      cancelTextColor: GlobalColors.mainColor,
                                      confirmTextColor: Colors.white,
                                      buttonColor: GlobalColors.mainColor,
                                      titlePadding: EdgeInsets.only(top: 20),
                                      title: "Warning",
                                      onConfirm: () {
                                        deleteSupplier(Supplierlist[i]);
                                      },
                                      content: Container(
                                        padding: EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                "Are you sure want to delete " +
                                                    Supplierlist[i]
                                                        .supplierCode
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      textConfirm: "Confirm",
                                      textCancel: "Cancel");
                              },
                              onTap: () {
                                if (FromSource != null) {
                                  Navigator.pop(context, Supplierlist[i]);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SupplierDetails(
                                            supplierid:
                                                Supplierlist[i].supplierID!),
                                      ));
                                }
                              },
                              child: Container(
                                height: 120,
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
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 200,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                        Supplierlist[i].name ??
                                                            "",
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17,
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                        color: GlobalColors
                                                            .mainColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Text(
                                                      Supplierlist[i]
                                                          .supplierCode
                                                          .toString(),
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                        Supplierlist[i].name2 ??
                                                            "",
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  if (Supplierlist[i].email !=
                                                      null)
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.pinkAccent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: Text(
                                                        Supplierlist[i]
                                                            .email
                                                            .toString(),
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                        Supplierlist[i]
                                                            .attention
                                                            .toString(),
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (Supplierlist[i].phone1 !=
                                                      null)
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: Text(
                                                        Supplierlist[i]
                                                            .phone1
                                                            .toString(),
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else
                      return const LoadingPage();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  Future<List<Supplier>> getSupplierData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/Supplier/GetSupplierList?companyid=' + companyid);
      List<Supplier> _Supplierlist = userFromJson(response);

      setState(() {
        Supplierlist_search = _Supplierlist;
        Supplierlist = _Supplierlist;
      });
    }
    return Supplierlist;
  }

  void searchQuery(String query) {
    final suggestions = Supplierlist_search.where((cus) {
      final cusCode = cus.supplierCode?.toString().toLowerCase() ?? "";
      final cusName = cus.name!.toString().toLowerCase() ?? "";
      final salesAgent = cus.supplierType.toString().toLowerCase();
      final cusName2 = cus.name2.toString().toLowerCase();
      final email = cus.email.toString().toLowerCase();
      final phone = cus.phone1.toString().toLowerCase();
      final input = query.toLowerCase();

      return cusName.contains(input) ||
          cusCode.contains(input) ||
          cusName2.contains(input) ||
          email.contains(input) ||
          phone.contains(input) ||
          salesAgent.contains(input);
    }).toList();

    setState(() {
      Supplierlist = suggestions;
    });
  }

  Future<void> deleteSupplier(Supplier Supplier) async {
    String response = await BaseClient().post(
        '/Supplier/DeleteSupplier',
        jsonEncode({
          "SupplierID": Supplier.supplierID.toString(),
          "SupplierCode": Supplier.supplierCode.toString(),
          "name": Supplier.name.toString(),
          "companyID": companyid
        }));

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
      await getSupplierData();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Supplier deleted successfully')),
      );
    } else {}
  }
}
