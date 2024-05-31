import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/Packing.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../api/base.client.dart';
import '../../../../models/Company.dart';
import '../../../../models/Packing.dart';
import '../../../../utils/global.colors.dart';
import '../../../Sales/OrderHistory/history.listing.dart';
import 'pack.view.dart';

class PackingListingScreen extends StatefulWidget {
  PackingListingScreen({Key? key, required this.docid}) : super(key: key);
  int docid;

  @override
  State<PackingListingScreen> createState() => _PackingListingScreen();
}

class _PackingListingScreen extends State<PackingListingScreen> {
  _PackingListingScreen();
  Packing packing = new Packing();
  Company company = new Company();
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPackingDetail();
    getCompanyDetail();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/PackingHome': (context) => PackingHomeScreen(),
      },
      home: WillPopScope(
        onWillPop: () async {
          Navigator.popUntil(context, ModalRoute.withName('/PackingHome'));

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
              packing.docNo.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => PackingAdd(
                  //       isEdit: true,
                  //       Packing: Packing,
                  //     ),
                  //   ),
                  // );
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

                      await getPackingReport(userSessionDto, packing.docID!);
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
                                    "Packing",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    packing.docNo.toString(),
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
                                    (packing.docDate != null &&
                                            packing.docDate.toString().length >=
                                                10
                                        ? packing.docDate
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
        ),
      ),
    );
  }

  getPackingReport(UserSessionDto userSessionDto, int Packingid) async {
    final body = jsonEncode({
      'userid': userSessionDto.userid,
      'companyid': userSessionDto.companyid
    });
    final resp = await BaseClient().postPDF(
        '/Report/GetPackingReport?packingid=' + Packingid.toString(), body);

    try {
      if (resp != null) {
        final Uint8List pdfBytes = resp;

        Directory documentsDirectory = await getApplicationDocumentsDirectory();

        String currentDate =
            DateFormat('yyyyMMddHHmmss').format(DateTime.now());
        String fileName = '${currentDate}_${packing.docNo}.pdf';
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

  Future<void> getPackingDetail() async {
    await Future.delayed(Duration(seconds: 2));
    if (widget.docid != null) {
      final response = await BaseClient()
          .get('/Packing/GetPacking?docid=' + widget.docid.toString());

      Packing _packing = Packing.fromJson(jsonDecode(response));

      if (mounted) {
        setState(() {
          packing = _packing;
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
      DataColumn(label: Text('Stock Code')),
      DataColumn(label: Text('Description')),
      DataColumn(label: Text('UOM')),
      DataColumn(
        label: Text(
          'Qty',
          textAlign: TextAlign.right, // Align text to the right
        ),
        numeric: true, // Set numeric to true to align content to the right
      ),
      DataColumn(
          label: Text(
            'Batch No',
            textAlign: TextAlign.right,
          ),
          numeric: true),
    ];
  }

  List<DataRow> _createRows() {
    return packing?.packingDetails
            ?.map((stItem) => DataRow(cells: [
                  // DataCell(Text(salesItem['#'].toString())),
                  DataCell(Text(stItem.stockCode.toString() ?? '')),
                  DataCell(Text(stItem.description.toString() ?? '')),
                  DataCell(Text(stItem.uom.toString() ?? '')),
                  DataCell(ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 4),
                      child: Text(
                        stItem?.qty?.toStringAsFixed(2) ?? '',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ))),
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 4,
                      ),
                      child: Text(
                        stItem?.batchNo.toString() ?? '',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right, // Align text to the right
                      ),
                    ),
                  ),
                ]))
            ?.toList() ??
        [];
  }
}

enum MenuItem { item1, item2, item3 }
