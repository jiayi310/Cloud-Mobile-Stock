import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../api/base.client.dart';
import '../../../models/Sales.dart';
import '../../../utils/global.colors.dart';
import 'listingsales.details.dart';

class HistoryListingScreen extends StatefulWidget {
  HistoryListingScreen({Key? key, required this.docid}) : super(key: key);
  int docid;

  @override
  State<HistoryListingScreen> createState() =>
      _HistoryListingScreen(docid: docid);
}

class _HistoryListingScreen extends State<HistoryListingScreen> {
  _HistoryListingScreen({required this.docid});
  int docid;
  Sales sales = new Sales();
  int _currentSortColumn = 0;
  bool _isSortAsc = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSalesDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: GlobalColors.mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          sales.docNo.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.share,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          PopupMenuButton<MenuItem>(
              onSelected: (value) {
                if (value == MenuItem.item1) {
                  //Clicked
                } else if (value == MenuItem.item2) {}
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: MenuItem.item2, child: Text('Print Receipt'))
                  ]),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/agiliti_logo.png',
                      height: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Sales",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          sales.docNo.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.black38),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Approved",
                          style: TextStyle(fontSize: 12, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Presoft (M) Sdn Bhd",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "98, Lorong 3/4, Jalan Kinara",
                      style: TextStyle(fontSize: 14, color: Colors.black38),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "37100 Bandar Puteri Puchong",
                      style: TextStyle(fontSize: 14, color: Colors.black38),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Selangor",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                    ),
                    Text(
                      "",
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Malaysia",
                      style: TextStyle(fontSize: 14, color: Colors.black38),
                    ),
                    Text(
                      "TOTAL",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: GlobalColors.mainColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "",
                    ),
                    Text(
                      "RM " + (sales.finalTotal?.toStringAsFixed(2) ?? "0.00"),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "BILL TO",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "",
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sales.customerCode.toString() +
                          " " +
                          sales.customerName.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "",
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sales.address1 ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                    ),
                    Text(
                      "Date:   " +
                          (sales.docDate != null &&
                                  sales.docDate.toString().length >= 10
                              ? sales.docDate.toString().substring(0, 10)
                              : "N/A"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sales.address2 ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                    ),
                    Text(
                      "Agent:   " + sales.salesAgent.toString(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sales.address3 ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sales.address4 ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: DataTable(
                horizontalMargin: 10,
                columnSpacing: 10,
                headingRowHeight: 30,
                headingTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                headingRowColor:
                    MaterialStateProperty.resolveWith((states) => Colors.black),
                dataTextStyle: TextStyle(fontSize: 11, color: Colors.black),
                columns: _createColumns(),
                rows: _createRows(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text("Authorised Signature:"),
                Image.asset(
                  'assets/images/agiliti_logo.png',
                  height: 100,
                ),
              ],
            )
          ],
        )),
      ),
    );
  }

  Future<void> getSalesDetail() async {
    if (docid != null) {
      final response =
          await BaseClient().get('/Sales/GetSales?docid=' + docid.toString());

      Sales _sales = Sales.fromJson2(jsonDecode(response));

      setState(() {
        sales = _sales;
      });
    }
  }

  List<DataColumn> _createColumns() {
    return [
      // DataColumn(
      //   label: Text('#'),
      //   onSort: (columnIndex, _) {
      //     setState(() {
      //       _currentSortColumn = columnIndex;
      //       // if (_isSortAsc) {
      //       //   sales.items.sort((a, b) => b.stockID.compareTo(a.stockID));
      //       // } else {
      //       //   _salesItems.sort((a, b) => a['#'].compareTo(b['#']));
      //       // }
      //       _isSortAsc = !_isSortAsc;
      //     });
      //   },
      // ),
      DataColumn(label: Text('ItemCode')),
      DataColumn(
          label: Text(
        'Desc',
      )),
      DataColumn(
          label: Expanded(
        child: Text(
          'UOM',
          textAlign: TextAlign.center,
        ),
      )),
      DataColumn(
          label: Expanded(
        child: Text(
          'Qty',
          textAlign: TextAlign.center,
        ),
      )),
      DataColumn(
          label: Expanded(
              child: Text(
        'Total',
        textAlign: TextAlign.right,
      ))),
    ];
  }

  List<DataRow> _createRows() {
    return sales?.salesDetails
            ?.map((salesItem) => DataRow(cells: [
                  // DataCell(Text(salesItem['#'].toString())),
                  DataCell(Text(salesItem?.stockCode?.toString() ?? '')),
                  DataCell(ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 4),
                      child: Text(
                        salesItem?.description?.toString() ?? '',
                        overflow: TextOverflow.ellipsis,
                      ))),
                  DataCell(
                      Center(child: Text(salesItem?.uom?.toString() ?? ''))),
                  DataCell(
                      Center(child: Text(salesItem?.qty?.toString() ?? ''))),
                  DataCell(Align(
                      alignment: Alignment.centerRight,
                      child: Text(salesItem?.total?.toString() ?? ''))),
                ]))
            ?.toList() ??
        [];
  }
}

enum MenuItem { item1, item2, item3 }
