import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api/base.client.dart';
import '../../../models/Company.dart';
import '../../../models/Sales.dart';
import '../../../utils/global.colors.dart';
import '../home.sales.dart';

class HistoryListingScreen extends StatefulWidget {
  HistoryListingScreen({Key? key, required this.docid}) : super(key: key);
  int docid;

  @override
  State<HistoryListingScreen> createState() =>
      _HistoryListingScreen(docid: docid);
}

class UserSessionDto {
  final int userid;
  final int companyid;

  UserSessionDto(this.userid, this.companyid);

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'companyid': companyid,
    };
  }
}

class _HistoryListingScreen extends State<HistoryListingScreen> {
  _HistoryListingScreen({required this.docid});
  int docid;
  Sales sales = new Sales();
  int _currentSortColumn = 0;
  bool _isSortAsc = true;
  bool _isLoading = true;
  Company company = new Company();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSalesDetail();
    getCompanyDetail();
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
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeSalesScreen(
                    isEdit: true,
                    sales: sales,
                  ),
                ),
              );
            },
          ),
          PopupMenuButton<MenuItem>(
              onSelected: (value) async {
                if (value == MenuItem.item1) {
                  //Clicked
                } else if (value == MenuItem.item2) {
                  final storage = new FlutterSecureStorage();
                  String? _userid = await storage.read(key: "userid");
                  String? _companyid = await storage.read(key: "companyid");
                  final userSessionDto = UserSessionDto(
                      int.parse(_userid!), int.parse(_companyid!));

                  await getSalesReport(userSessionDto, sales.docID!);
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: MenuItem.item2, child: Text('Download Receipt'))
                  ]),
        ],
      ),
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), // Show CircularProgressIndicator while loading
            )
          : Padding(
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
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black38),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Approved",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.green),
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
                            company.companyName.toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
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
                            company.address1?.toString() ?? "",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black38),
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
                            company.address2?.toString() ?? "",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black38),
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
                            company.address3?.toString() ?? "",
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
                            company.address4?.toString() ?? "",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black38),
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
                            "RM " +
                                (sales.finalTotal?.toStringAsFixed(2) ??
                                    "0.00"),
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
                            sales.address1?.toString() ?? "",
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
                            sales.address2?.toString() ?? "",
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
                            sales.address3?.toString() ?? "",
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
                            sales.address4?.toString() ?? "",
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
                      headingTextStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.black),
                      dataTextStyle:
                          TextStyle(fontSize: 11, color: Colors.black),
                      columns: _createColumns(),
                      rows: _createRows(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      // Text("Authorised Signature:"),
                      // Image.asset(
                      //   'assets/images/agiliti_logo.png',
                      //   height: 100,
                      // ),
                    ],
                  )
                ],
              )),
            ),
    );
  }

  Future<void> getSalesReport(
      UserSessionDto userSessionDto, int salesid) async {
    final body = jsonEncode({
      'userid': userSessionDto.userid,
      'companyid': userSessionDto.companyid
    });
    final resp = await BaseClient()
        .postPDF('/Report/GetSalesReport?salesid=' + salesid.toString(), body);

    try {
      if (resp != null) {
        // Successfully received the response
        // Download the PDF file
        final Uint8List pdfBytes = resp;

        Directory documentsDirectory = await getApplicationDocumentsDirectory();

        String currentDate =
            DateFormat('yyyyMMddHHmmss').format(DateTime.now());
        String fileName = '${currentDate}_${sales.docNo}.pdf';
        String filePath = '${documentsDirectory.path}/$fileName';

        // Save the PDF file to local storage
        File file = File(filePath);
        await file.writeAsBytes(pdfBytes);

        // Open and view the PDF using open_file
        await OpenFile.open(file.path);
      } else {
        // Handle errors based on the response status code
        print('Error: ${resp.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }

  Future<void> getSalesDetail() async {
    await Future.delayed(Duration(seconds: 2));
    if (docid != null) {
      final response =
          await BaseClient().get('/Sales/GetSales?docid=' + docid.toString());

      Sales _sales = Sales.fromJson2(jsonDecode(response));

      if (mounted) {
        setState(() {
          sales = _sales;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> getCompanyDetail() async {
    await Future.delayed(Duration(seconds: 2));
    final storage = new FlutterSecureStorage();
    String? _companyid = await storage.read(key: "companyid");
    if (_companyid != null) {
      final response = await BaseClient()
          .get('/Company/GetCompany?companyid=' + _companyid.toString());

      Company _company = Company.fromJson(jsonDecode(response));

      if (mounted) {
        setState(() {
          company = _company;
        });
      }
    }
  }

  List<DataColumn> _createColumns() {
    return [
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
                      child: Text(salesItem?.total?.toStringAsFixed(2) ?? ''))),
                ]))
            ?.toList() ??
        [];
  }
}

enum MenuItem { item1, item2, item3 }
