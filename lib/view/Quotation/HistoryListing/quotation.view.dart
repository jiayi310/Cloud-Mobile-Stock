import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobilestock/view/Quotation/HistoryListing/details.listing.dart';
import 'package:mobilestock/view/Quotation/NewQuotation/quotation.add.dart';

import '../../../api/base.client.dart';
import '../../../models/Quotation.dart';
import '../../../utils/global.colors.dart';

class QuotationHomeScreen extends StatefulWidget {
  const QuotationHomeScreen({Key? key}) : super(key: key);

  @override
  State<QuotationHomeScreen> createState() => _QuotationHomeScreen();
}

class _QuotationHomeScreen extends State<QuotationHomeScreen> {
  bool _visible = false;
  List<Quotation> quotationList = [], quotationList_search = [];
  final storage = new FlutterSecureStorage();
  String companyid = "";
  List<Quotation> quotationFromJson(String str) =>
      List<Quotation>.from(json.decode(str).map((x) => Quotation.fromJson(x)));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QuotationAdd(
                        isEdit: false,
                        quotation: new Quotation(),
                      )));
        },
        child: Icon(Icons.add),
        backgroundColor: GlobalColors.mainColor,
      ),
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Quotation",
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
              Column(
                children: [
                  for (int i = 0; i < quotationList.length; i++)
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
                                          quotationList[i].docNo.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onConfirm: () {
                              removeQuotation(quotationList[i].docID);

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
                              builder: (context) => QuotationListingScreen(
                                docid: quotationList[i].docID ?? 0,
                              ),
                            ));
                      },
                      child: Container(
                        height: 130,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      quotationList[i].docNo.toString(),
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: GlobalColors.mainColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    quotationList[i].docDate != null &&
                                            quotationList[i].docDate!.isNotEmpty
                                        ? quotationList[i]
                                            .docDate!
                                            .toString()
                                            .substring(
                                                0,
                                                min(
                                                    quotationList[i]
                                                        .docDate!
                                                        .length,
                                                    10))
                                        : 'No Date Available',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.8),
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
                                      quotationList[i].customerCode.toString(),
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
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
                                      overflow: TextOverflow.ellipsis,
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
                                      quotationList[i].customerName.toString(),
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
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
                                      quotationList[i].salesAgent.toString(),
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "RM" +
                                        quotationList[i]
                                            .finalTotal!
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void searchQuery(String query) {
    final suggestions = quotationList_search.where((sales) {
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
      quotationList = suggestions;
    });
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  Future<List<Quotation>> getData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/Quotation/GetQuotationListByCompanyId?companyId=' + companyid);
      List<Quotation> _quotationlist = quotationFromJson(response);

      _quotationlist.sort((a, b) => b.docDate!.compareTo(a.docDate!));

      _quotationlist.sort((a, b) => b.docNo!.compareTo(a.docNo!));

      setState(() {
        quotationList = _quotationlist;
        quotationList_search = _quotationlist;
      });
    }
    return quotationList;
  }

  Future<void> removeQuotation(int? docID) async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient().get2(
          '/Quotation/RemoveQuotation?docId=' +
              docID.toString() +
              '&companyId=' +
              companyid);

      if (response != "null") {
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
      } else {
        Fluttertoast.showToast(
          msg: 'Cannot delete Sales which payment is collected',
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
