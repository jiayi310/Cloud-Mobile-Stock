import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/StockTransfer.dart';
import 'package:mobilestock/view/WMS/StockTransfer/HistoryListing/StockTransfer.view.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../api/base.client.dart';
import '../../../../models/Company.dart';
import '../../../../models/StockTransfer.dart';
import '../../../../utils/global.colors.dart';
import '../../../Sales/OrderHistory/history.listing.dart';

class StockTransferListingScreen extends StatefulWidget {
  StockTransferListingScreen({Key? key, required this.docid}) : super(key: key);
  int docid;

  @override
  State<StockTransferListingScreen> createState() =>
      _StockTransferListingScreen();
}

class _StockTransferListingScreen extends State<StockTransferListingScreen> {
  _StockTransferListingScreen();
  StockTransfer stockTransfer = new StockTransfer();
  Company company = new Company();
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStockTransferDetail();
    getCompanyDetail();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/StockTransferHome': (context) => StockTransferHomeScreen(),
      },
      home: WillPopScope(
        onWillPop: () async {
          Navigator.popUntil(
              context, ModalRoute.withName('/StockTransferHome'));

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
              stockTransfer.docNo.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => StockTransferAdd(
                  //       isEdit: true,
                  //       StockTransfer: StockTransfer,
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

                      await getStockTransferReport(
                          userSessionDto, stockTransfer.docID!);
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
                                'assets/images/agiliti_logo.png',
                                height: 60,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Stock Transfer",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    stockTransfer.docNo.toString(),
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
                                    (stockTransfer.docDate != null &&
                                            stockTransfer.docDate
                                                    .toString()
                                                    .length >=
                                                10
                                        ? stockTransfer.docDate
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
                      // Container(
                      //   width: double.infinity,
                      //   child: DataTable(
                      //     horizontalMargin: 10,
                      //     columnSpacing: 10,
                      //     headingRowHeight: 30,
                      //     headingTextStyle: TextStyle(
                      //         fontWeight: FontWeight.bold, color: Colors.white),
                      //     headingRowColor: MaterialStateProperty.resolveWith(
                      //         (states) => Colors.black),
                      //     dataTextStyle:
                      //         TextStyle(fontSize: 11, color: Colors.black),
                      //     columns: _createColumns(),
                      //     rows: _createRows(),
                      //   ),
                      // ),
                      _buildStockTransferList(),
                    ],
                  )),
                ),
        ),
      ),
    );
  }

  Widget _buildStockTransferList() {
    return Column(
      children: _stockTransferList(), // Generate items here
    );
  }

  getStockTransferReport(
      UserSessionDto userSessionDto, int StockTransferid) async {
    final body = jsonEncode({
      'userid': userSessionDto.userid,
      'companyid': userSessionDto.companyid
    });
    final resp = await BaseClient().postPDF(
        '/Report/GetStockTransferReport?StockTransferid=' +
            StockTransferid.toString(),
        body);

    try {
      if (resp != null) {
        final Uint8List pdfBytes = resp;

        Directory documentsDirectory = await getApplicationDocumentsDirectory();

        String currentDate =
            DateFormat('yyyyMMddHHmmss').format(DateTime.now());
        String fileName = '${currentDate}_${stockTransfer.docNo}.pdf';
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

  Future<void> getStockTransferDetail() async {
    await Future.delayed(Duration(seconds: 2));
    if (widget.docid != null) {
      final response = await BaseClient().get(
          '/StockTransfer/GetStockTransfer?docid=' + widget.docid.toString());

      StockTransfer _stockTransfer =
          StockTransfer.fromJson(jsonDecode(response));

      if (mounted) {
        setState(() {
          stockTransfer = _stockTransfer;
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

  List<Widget> _stockTransferList() {
    return stockTransfer?.stockTransferDetails
            ?.map((stItem) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            10.0)), // Adjust the radius as needed
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  stItem.stockCode.toString(),
                                  style: TextStyle(
                                    fontSize: 14, // Adjust font size as needed
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .black, // Change text color as needed
                                  ),
                                ),
                                Text(
                                  stItem.description!.length > 35
                                      ? stItem.description!.substring(0, 30) +
                                          '...'
                                      : stItem.description ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors
                                        .black, // Change text color as needed
                                  ),
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
                                  stItem.uom.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors
                                        .black, // Change text color as needed
                                  ),
                                ),
                                Text(
                                  stItem.batchNo.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors
                                        .black, // Change text color as needed
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        stItem.fromLocation.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .black, // Change text color as needed
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        stItem.fromStorageCode.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .black, // Change text color as needed
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 24, // Set the desired width here
                                  child: Icon(Icons.arrow_forward_ios_sharp),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        stItem.toLocation.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .black, // Change text color as needed
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        stItem.toStorageCode.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .black, // Change text color as needed
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Qty: " + stItem.qty!.toStringAsFixed(0),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ))
            ?.toList() ??
        [];
  }
}

enum MenuItem { item1, item2, item3 }
