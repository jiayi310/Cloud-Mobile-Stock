import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/models/Picking.dart';
import 'package:mobilestock/models/Sales.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/utils/loading.dart';
import 'package:mobilestock/view/WMS/Picking/PickingProvider.dart';

import '../../../api/base.client.dart';
import '../../../size.config.dart';

class PickingSalesList extends StatefulWidget {
  final List<int> previouslySelectedIds;

  PickingSalesList({Key? key, required this.previouslySelectedIds})
      : super(key: key);

  @override
  State<PickingSalesList> createState() => _PickingSalesListState();
}

class _PickingSalesListState extends State<PickingSalesList> {
  List<Sales> sales = [];
  List<Sales> salesList_search = [];
  Set<int> selectedSalesIds = Set(); // Use a set to track selected sales
  String companyid = "";
  final storage = FlutterSecureStorage();
  bool _visible = false;
  bool _isLoading = true;
  late final Future myfuture;

  @override
  void initState() {
    super.initState();
    selectedSalesIds.addAll(widget.previouslySelectedIds);
    myfuture = getData();
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pop(context, selectedSalesIds.toList());
                  print('selected: ${selectedSalesIds.length}');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                      color: GlobalColors.mainColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'Confirm',
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
          title: Text(
            "Picking List",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
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
                child: CircularProgressIndicator(),
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
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: sales.length,
                              itemBuilder: (BuildContext context, int i) {
                                return buildSalesItem(sales[i], i);
                              },
                            );
                          } else {
                            return Center(child: Text("No data available"));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }

  Widget buildSalesItem(Sales sale, int index) {
    final isSelected = selectedSalesIds.contains(sale.docID);

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sale.docNo.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: GlobalColors.mainColor,
                    ),
                  ),
                  Text(
                    sale.docDate.toString().substring(0, 10),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    '${sale.customerCode.toString()}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${sale.customerName.toString()}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              //contentPadding: EdgeInsets.only(left: 0, right: 50), // Add padding to the right to make space for the trailing icon
            ),
          ),
        ),
        // Add space for the trailing icon
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              setState(() {
                if (isSelected) {
                  selectedSalesIds.remove(sale.docID);
                } else {
                  selectedSalesIds.add(sale.docID!);
                }
              });
            },
            child: Icon(
              isSelected ? Icons.check_circle : Icons.check_circle_outline,
              color: isSelected ? GlobalColors.mainColor : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  void searchQuery(String query) {
    final suggestions = salesList_search.where((sales) {
      final docNo = sales.docNo.toString().toLowerCase();
      // final supCode = sales.supplierCode.toString().toLowerCase() ?? "";
      // final supName = sales.supplierName.toString().toLowerCase() ?? "";
      final custCode = sales.customerCode.toString().toLowerCase() ?? "";
      final custName = sales.customerName.toString().toLowerCase() ?? "";
      final input = query.toLowerCase();

      return docNo.contains(input) ||
          custCode.contains(input) ||
          custName.contains(input);
    }).toList();

    setState(() {
      sales = suggestions;
    });
  }

  Future<List<Sales>> getData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/Sales/GetSalesListAvailableForPicking?companyId=' + companyid);
      List<Sales> _salesList = salesFromJson(response);

      setState(() {
        sales = _salesList;
        salesList_search = _salesList;
        _isLoading = false;
      });
    }
    return sales;
  }

  List<Sales> salesFromJson(String str) =>
      List<Sales>.from(json.decode(str).map((x) => Sales.fromJson(x)));
}
