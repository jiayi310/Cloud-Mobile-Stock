import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/Picking.dart';
import 'package:mobilestock/view/WMS/Picking/HistoryListing/Picking.view.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../api/base.client.dart';
import '../../../../models/Company.dart';
import '../../../../models/Picking.dart';
import '../../../../utils/global.colors.dart';
import '../../../Sales/OrderHistory/history.listing.dart';
import '../picking.add.dart';
import '../picking.pickStock.dart';

class PickingListingScreen extends StatefulWidget {
  PickingListingScreen({Key? key, required this.docid}) : super(key: key);
  int docid;

  @override
  State<PickingListingScreen> createState() => _PickingListingScreen();
}

class _PickingListingScreen extends State<PickingListingScreen> {
  _PickingListingScreen();
  Picking picking = new Picking();
  Company company = new Company();
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPickingDetail();
    getCompanyDetail();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/PickingHome': (context) => PickingHomeScreen(),
      },
      home: WillPopScope(
        onWillPop: () async {
          Navigator.popUntil(context, ModalRoute.withName('/PickingHome'));

          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: GlobalColors.mainColor,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              picking.docNo.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PickingPickStock(
                        isEdit: true,
                        picking: picking,
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

                      await getPickingReport(userSessionDto, picking.docID!);
                    }
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            value: MenuItem.item2,
                            child: Text('Download Receipt'))
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/cubehous_logo.png',
                                height: 60,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Picking",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    picking.docNo.toString(),
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
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black38),
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
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black38),
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
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black38),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date: " +
                                    (picking.docDate != null &&
                                            picking.docDate.toString().length >=
                                                10
                                        ? picking.docDate
                                            .toString()
                                            .substring(0, 10)
                                        : "N/A"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Pick:",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        width: double.infinity,
                        child: DataTable(
                          horizontalMargin: 10,
                          columnSpacing: 10,
                          headingRowHeight: 50,
                          headingTextStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          headingRowColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.black),
                          dataTextStyle:
                              TextStyle(fontSize: 11, color: Colors.black),
                          columns: _createColumns2(),
                          rows: _createRows2(),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Picked:",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        width: double.infinity,
                        child: DataTable(
                          horizontalMargin: 10,
                          columnSpacing: 10,
                          headingRowHeight: 50,
                          headingTextStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          headingRowColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.black),
                          dataTextStyle:
                              TextStyle(fontSize: 11, color: Colors.black),
                          columns: _createColumns(),
                          rows: _createRows(context),
                        ),
                      ),
                    ],
                  )),
                ),
        ),
      ),
    );
  }

  getPickingReport(UserSessionDto userSessionDto, int Pickingid) async {
    final body = jsonEncode({
      'userid': userSessionDto.userid,
      'companyid': userSessionDto.companyid
    });
    final resp = await BaseClient().postPDF(
        '/Report/GetPickingReport?pickingid=' + Pickingid.toString(), body);

    try {
      if (resp != null) {
        final Uint8List pdfBytes = resp;

        Directory documentsDirectory = await getApplicationDocumentsDirectory();

        String currentDate =
            DateFormat('yyyyMMddHHmmss').format(DateTime.now());
        String fileName = '${currentDate}_${picking.docNo}.pdf';
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

  Future<void> getPickingDetail() async {
    await Future.delayed(Duration(seconds: 2));
    if (widget.docid != null) {
      final response = await BaseClient()
          .get('/Picking/GetPicking?docid=' + widget.docid.toString());

      Picking _picking = Picking.fromJson(jsonDecode(response));

      if (_picking.docNo != null) {
        print("PickingItems: ${_picking.docNo}");
      } else {
        print("PickingItems is null or empty.");
      }

      if (mounted) {
        setState(() {
          picking = _picking;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> getCompanyDetail() async {
    await Future.delayed(Duration(seconds: 2));
    final storage = new FlutterSecureStorage();
    String? _companyid = await storage.read(key: "companyid");
    print('companyid: ${widget.docid.toString()}');
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
      DataColumn(
        label: Flexible(
          child: Text(
            'Stock Code',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataColumn(
        label: Flexible(
          child: Text(
            'UOM',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataColumn(
        label: Flexible(
          child: Text(
            'Qty',
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        numeric: true,
      ),
      DataColumn(
        label: Flexible(
          child: Text(
            'Stor. Code',
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        numeric: true,
      ),
    ];
  }

  List<DataRow> _createRows(BuildContext context) {
    return picking?.pickingDetails
            ?.map((stItem) => DataRow(
                    color: MaterialStateProperty.resolveWith(
                        (states) => Colors.grey[200]),
                    cells: [
                      // DataCell(Text(salesItem['#'].toString())),
                      DataCell(Row(
                        children: [
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Text(stItem.stockCode.toString() ?? ''),
                          )
                        ],
                      )),
                      DataCell(
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(stItem.uom.toString() ?? ''),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                stItem?.qty?.toStringAsFixed(2) ?? '',
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Text(
                                stItem?.storageCode.toString() ?? '',
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))
            ?.toList() ??
        [];
  }

  List<DataColumn> _createColumns2() {
    return [
      DataColumn(
        label: Flexible(
          child: Text(
            'Stock Code',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataColumn(
        label: Flexible(
          child: Text(
            'UOM',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      DataColumn(
        label: Flexible(
          child: Text(
            'Qty',
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        numeric: true,
      ),
    ];
  }

  List<DataRow> _createRows2() {
    return picking?.pickingItems
            ?.map((stItem) => DataRow(
                    color: MaterialStateProperty.resolveWith(
                        (states) => Colors.grey[200]),
                    cells: [
                      // DataCell(Text(salesItem['#'].toString())),
                      DataCell(Row(
                        children: [
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Text(stItem.stockCode.toString() ?? ''),
                          )
                        ],
                      )),
                      DataCell(
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(stItem.uom.toString() ?? ''),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                stItem?.qty?.toStringAsFixed(2) ?? '',
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))
            ?.toList() ??
        [];
  }
}

enum MenuItem { item1, item2, item3 }
