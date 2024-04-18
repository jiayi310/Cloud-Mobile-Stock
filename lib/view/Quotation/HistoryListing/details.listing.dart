import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/Quotation.dart';
import 'package:mobilestock/view/Quotation/NewQuotation/quotation.add.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../api/base.client.dart';
import '../../../models/Company.dart';
import '../../../utils/global.colors.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../Sales/OrderHistory/history.listing.dart';

class QuotationListingScreen extends StatefulWidget {
  QuotationListingScreen({Key? key, required this.docid}) : super(key: key);
  final int docid;

  @override
  State<QuotationListingScreen> createState() => _DetailsListingScreen();
}

class _DetailsListingScreen extends State<QuotationListingScreen> {
  _DetailsListingScreen();
  Quotation quotation = new Quotation();
  Company company = new Company();
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCompanyDetail();
    getQuotationDetail();
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
          quotation.docNo.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuotationAdd(
                      isEdit: true,
                      quotation: quotation,
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.edit,
                size: 25,
                color: Colors.white,
              ),
            ),
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

                  await getQuotationReport(userSessionDto, quotation.docID!);
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: MenuItem.item1, child: Text('Convert to Sales')),
                    PopupMenuItem(
                        value: MenuItem.item2, child: Text('Print Receipt'))
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
                                "QUOTATION",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                quotation.docNo.toString(),
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
                                (quotation.finalTotal ?? 0.0)
                                    .toStringAsFixed(2),
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
                            quotation.customerCode.toString() +
                                " " +
                                quotation.customerName.toString(),
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
                            quotation.address1 ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                          Text(
                            "Date:   " +
                                (quotation.docDate != null &&
                                        quotation.docDate.toString().length >=
                                            10
                                    ? quotation.docDate
                                        .toString()
                                        .substring(0, 10)
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
                            quotation.address2 ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                          Text(
                            "Agent:   " + quotation.salesAgent.toString(),
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
                            quotation.address3 ?? "",
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
                            quotation.address4 ?? "",
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
                ],
              )),
            ),
    );
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
    return quotation?.quotationDetails
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

  Future<void> getQuotationDetail() async {
    if (widget.docid != null) {
      final response = await BaseClient()
          .get('/Quotation/GetQuotation?docid=' + widget.docid.toString());

      Quotation _quotation = Quotation.fromJson(jsonDecode(response));

      setState(() {
        quotation = _quotation;
      });
    }
  }

  getQuotationReport(UserSessionDto userSessionDto, int quotationid) async {
    final body = jsonEncode({
      'userid': userSessionDto.userid,
      'companyid': userSessionDto.companyid
    });
    final resp = await BaseClient().postPDF(
        '/Report/GetQuotationReport?quotationid=' + quotationid.toString(),
        body);

    try {
      if (resp != null) {
        // Successfully received the response
        // Download the PDF file
        final Uint8List pdfBytes = resp;

        Directory documentsDirectory = await getApplicationDocumentsDirectory();

        String currentDate =
            DateFormat('yyyyMMddHHmmss').format(DateTime.now());
        String fileName = '${currentDate}_${quotation.docNo}.pdf';
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
          _isLoading = false;
        });
      }
    }
  }
}

enum MenuItem { item1, item2, item3 }
