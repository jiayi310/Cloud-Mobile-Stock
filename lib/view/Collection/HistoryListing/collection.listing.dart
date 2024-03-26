import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/Collection.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../api/base.client.dart';
import '../../../utils/global.colors.dart';
import '../../Sales/OrderHistory/history.listing.dart';
import '../collection.add.dart';
import '../collection.view.dart';

class CollectionListingScreen extends StatefulWidget {
  CollectionListingScreen({Key? key, required this.docid}) : super(key: key);
  int docid;

  @override
  State<CollectionListingScreen> createState() => _CollectionListingScreen();
}

class _CollectionListingScreen extends State<CollectionListingScreen> {
  _CollectionListingScreen();
  Collection collection = new Collection(paymentTotal: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCollectionDetail();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/collectionHome': (context) => CollectionHomeScreen(),
      },
      home: WillPopScope(
        onWillPop: () async {
          Navigator.popUntil(context, ModalRoute.withName('/collectionHome'));

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
              collection.docNo.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CollectionAdd(
                        isEdit: true,
                        collection: collection,
                      ),
                    ),
                  );
                },
              ),
              if (collection!.image != "")
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {
                    // Show larger image in a dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            width: 300, // Adjust the width as needed
                            height: 300, // Adjust the height as needed
                            child: Image.memory(
                              base64Decode(collection!
                                  .image!), // Decode the Base64 string to bytes
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
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

                      await getCollectionReport(
                          userSessionDto, collection.docID!);
                    }
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            value: MenuItem.item2,
                            child: Text('Download Receipt'))
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
                              "AR Payment",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              collection.docNo.toString(),
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black38),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Approved",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.green),
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
                          collection.paymentTotal.toStringAsFixed(2),
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
                          "CUSTOMER",
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
                          (collection.customerCode ?? "") +
                              " " +
                              (collection.customerName ?? ""),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Date: " +
                              (collection.docDate != null &&
                                      collection.docDate.toString().length >= 10
                                  ? collection.docDate
                                      .toString()
                                      .substring(0, 10)
                                  : "N/A"),
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
                          collection.customer?.address1?.toString() ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                          ),
                        ),
                        Text(
                          "Agent: " + (collection.salesAgent?.toString() ?? ""),
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
                          collection.customer?.address2?.toString() ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                          ),
                        ),
                        Text(""),
                      ],
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       collection.customer?.address3?.toString() ?? "",
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         color: Colors.black38,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       collection.customer?.address4?.toString() ?? "",
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         color: Colors.black38,
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
                    dataTextStyle: TextStyle(fontSize: 11, color: Colors.black),
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

  getCollectionReport(UserSessionDto userSessionDto, int collectionid) async {
    final body = jsonEncode({
      'userid': userSessionDto.userid,
      'companyid': userSessionDto.companyid
    });
    final resp = await BaseClient().postPDF(
        '/Report/GetCollectionReport?collectionid=' + collectionid.toString(),
        body);

    try {
      if (resp != null) {
        // Successfully received the response
        // Download the PDF file
        final Uint8List pdfBytes = resp;

        Directory documentsDirectory = await getApplicationDocumentsDirectory();

        String currentDate =
            DateFormat('yyyyMMddHHmmss').format(DateTime.now());
        String fileName = '${currentDate}_${collection.docNo}.pdf';
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

  Future<void> getCollectionDetail() async {
    if (widget.docid != null) {
      final response = await BaseClient()
          .get('/Collection/GetCollection?docid=' + widget.docid.toString());

      Collection _collection = Collection.fromJson(jsonDecode(response));

      setState(() {
        collection = _collection;
      });
    }
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Invoice No')),
      DataColumn(
          label: Text(
        'Total',
      )),
    ];
  }

  List<DataRow> _createRows() {
    return collection?.collectMappings
            ?.map((collectItem) => DataRow(cells: [
                  // DataCell(Text(salesItem['#'].toString())),
                  DataCell(Text(collectItem?.salesDocNo.toString() ?? '')),
                  DataCell(ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 4),
                      child: Text(
                        collectItem?.paymentAmt?.toString() ?? '',
                        overflow: TextOverflow.ellipsis,
                      ))),
                ]))
            ?.toList() ??
        [];
  }
}

enum MenuItem { item1, item2, item3 }
