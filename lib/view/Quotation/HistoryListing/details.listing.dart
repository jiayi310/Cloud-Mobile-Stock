import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobilestock/models/Quotation.dart';
import 'package:mobilestock/view/Quotation/HistoryListing/listing.details.dart';
import 'package:mobilestock/view/Quotation/listing.header.dart';
import 'package:share_plus/share_plus.dart';

import '../../../api/base.client.dart';
import '../../../utils/global.colors.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DetailsListingScreen extends StatefulWidget {
  const DetailsListingScreen({Key? key, required this.docid}) : super(key: key);
  final int docid;

  @override
  State<DetailsListingScreen> createState() => _DetailsListingScreen();
}

class _DetailsListingScreen extends State<DetailsListingScreen> {
  _DetailsListingScreen();
  Quotation quotation = new Quotation();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                //share button
                Share.share('check out my website https://example.com',
                    subject: 'Look what I made!');

                //share pdf
                //Share.shareXFiles([XFile('assets/hello.txt')], text: 'Great picture');
              },
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
                } else if (value == MenuItem.item2) {
                  //Print Receipt
                  _createPdf();
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            ListingHeader(
              quotation: quotation,
            ),
            SizedBox(
              height: 20,
            ),
            ListingDetails(quotation: quotation),
          ],
        )),
      ),
    );
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
}

void _createPdf() async {
  final doc = pw.Document();

  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('hello world, agility'),
        );
      }));

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save());
}

enum MenuItem { item1, item2, item3 }
