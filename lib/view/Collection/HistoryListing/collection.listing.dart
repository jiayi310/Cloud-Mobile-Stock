import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/Collection.dart';
import 'package:mobilestock/view/Collection/HistoryListing/listing.details.dart';
import 'package:mobilestock/view/Collection/HistoryListing/listing.header.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../api/base.client.dart';
import '../../../utils/global.colors.dart';
import '../../Sales/OrderHistory/history.listing.dart';

class CollectionListingScreen extends StatefulWidget {
  const CollectionListingScreen({Key? key, required this.collection})
      : super(key: key);
  final Collection collection;

  @override
  State<CollectionListingScreen> createState() =>
      _CollectionListingScreen(collection: collection);
}

class _CollectionListingScreen extends State<CollectionListingScreen> {
  _CollectionListingScreen({required this.collection});
  final Collection collection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCollectionDetail();
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
          collection.docNo.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
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

                  await getCollectionReport(userSessionDto, collection.docID!);
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: MenuItem.item2, child: Text('Download Receipt'))
                  ]),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            ListingHeader(
              collection: collection,
            ),
            SizedBox(
              height: 20,
            ),
            ListingDetails(collection: collection),
          ],
        )),
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
    if (docid != null) {
      final response =
          await BaseClient().get('/Sales/GetSales?docid=' + docid.toString());

      Sales _sales = Sales.fromJson2(jsonDecode(response));

      setState(() {
        sales = _sales;
      });
    }
  }
}

enum MenuItem { item1, item2, item3 }
