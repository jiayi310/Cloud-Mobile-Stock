import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/PutAway.dart';
import 'package:mobilestock/view/WMS/PutAway/HistoryListing/PutAway.view.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../api/base.client.dart';
import '../../../../models/Company.dart';
import '../../../../models/PutAway.dart';
import '../../../../utils/global.colors.dart';
import '../../../Sales/OrderHistory/history.listing.dart';

class PutAwayListingScreen extends StatefulWidget {
  PutAwayListingScreen({Key? key, required this.docid}) : super(key: key);
  int docid;

  @override
  State<PutAwayListingScreen> createState() => _PutAwayListingScreen();
}

class _PutAwayListingScreen extends State<PutAwayListingScreen> {
  _PutAwayListingScreen();
  PutAway putAway = new PutAway();
  Company company = new Company();
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPutAwayDetail();
    getCompanyDetail();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/PutAwayHome': (context) => PutAwayHomeScreen(),
      },
      home: WillPopScope(
        onWillPop: () async {
          Navigator.popUntil(context, ModalRoute.withName('/PutAwayHome'));

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
              putAway.docNo.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              // IconButton(
              //   icon: Icon(Icons.edit),
              //   onPressed: () {
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //     builder: (context) => PutAwayAdd(
              //     //       isEdit: true,
              //     //       PutAway: PutAway,
              //     //     ),
              //     //   ),
              //     // );
              //   },
              // ),
              // PopupMenuButton<MenuItem>(
              //     onSelected: (value) async {
              //       if (value == MenuItem.item1) {
              //         //Clicked
              //       } else if (value == MenuItem.item2) {
              //         final storage = new FlutterSecureStorage();
              //         String? _userid = await storage.read(key: "userid");
              //         String? _companyid = await storage.read(key: "companyid");
              //         final userSessionDto = UserSessionDto(
              //             int.parse(_userid!), int.parse(_companyid!));
              //
              //         await getPutAwayReport(
              //             userSessionDto, putAway.putAwayID!);
              //       }
              //     },
              //     itemBuilder: (context) => [
              //           PopupMenuItem(
              //               value: MenuItem.item2,
              //               child: Text('Download Receipt'))
              //         ]),
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
                                    "PutAway",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    putAway.docNo.toString(),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black38),
                                  ),
                                  SizedBox(
                                    height: 5,
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
                                    (putAway.createdDateTime != null &&
                                            putAway.createdDateTime
                                                    .toString()
                                                    .length >=
                                                10
                                        ? putAway.createdDateTime
                                            .toString()
                                            .substring(0, 10)
                                        : "N/A"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Details:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                "Item:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                putAway.stockCode! + " " + putAway.description!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                "UOM:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                putAway.uom.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                "Batch No:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                putAway.batchNo.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                "Quantity:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                putAway.qty!.toStringAsFixed(0),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                "Location:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                putAway.location.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                "Storage:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                putAway.storageCode.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                "Transfer From:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                putAway.receivingDocNo.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
        ),
      ),
    );
  }

  getPutAwayReport(UserSessionDto userSessionDto, int PutAwayid) async {
    final body = jsonEncode({
      'userid': userSessionDto.userid,
      'companyid': userSessionDto.companyid
    });
    final resp = await BaseClient().postPDF(
        '/Report/GetPutAwayReport?PutAwayid=' + PutAwayid.toString(), body);

    try {
      if (resp != null) {
        final Uint8List pdfBytes = resp;

        Directory documentsDirectory = await getApplicationDocumentsDirectory();

        String currentDate =
            DateFormat('yyyyMMddHHmmss').format(DateTime.now());
        String fileName = '${currentDate}_${putAway.putAwayID}.pdf';
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

  Future<void> getPutAwayDetail() async {
    await Future.delayed(Duration(seconds: 2));
    if (widget.docid != null) {
      final response = await BaseClient()
          .get('/PutAway/GetPutAway?docid=' + widget.docid.toString());

      PutAway _putAway = PutAway.fromJson(jsonDecode(response));

      if (mounted) {
        setState(() {
          putAway = _putAway;
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
}

enum MenuItem { item1, item2, item3 }
