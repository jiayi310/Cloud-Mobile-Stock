import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilestock/models/Collection.dart';
import 'package:mobilestock/view/Collection/CollectionProvider.dart';
import 'package:mobilestock/view/Collection/collection.invoice.dart';
import 'package:mobilestock/view/Collection/customer.collection.dart';
import 'package:mobilestock/view/Quotation/NewQuotation/quotation.customer.dart';
import 'package:mobilestock/view/Quotation/NewQuotation/quotation.total.dart';

import '../../api/base.client.dart';
import '../../size.config.dart';
import '../../utils/global.colors.dart';
import '../Sales/CheckOut/checkout.view.dart';
import 'invoice.customer.dart';

class CollectionAdd extends StatefulWidget {
  const CollectionAdd({Key? key}) : super(key: key);

  @override
  State<CollectionAdd> createState() => _CollectionAddState();
}

class _CollectionAddState extends State<CollectionAdd> {
  String docNo = "";
  String companyid = "", userid = "";
  final storage = new FlutterSecureStorage();
  Collection? collection;

  List<CollectionDetails> collectionItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access context and salesProvider here
    final collectProvider = CollectionProvider.of(context);
    collectionItems = collectProvider?.collection.collectionDetails ?? [];
  }

  @override
  void initState() {
    // TODO: implement initState
    getDocNo();
  }

  @override
  Widget build(BuildContext context) {
    collection = CollectionProvider.of(context)?.collection;

    if (collection == null) {
      // Handle the case where Sales is not available
      return Text('Collection data not available');
    }
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.only(
            left: defaultPadding, right: defaultPadding, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Total (" + collectionItems.length.toString() + "): ",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                Text(
                  "RM ${collection!.paymentTotal!.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ],
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                sendCollectionData();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          docNo,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            color: GlobalColors.mainColor,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Customer",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
            ),
          ),
          CusCollection(),
          Container(
            color: GlobalColors.mainColor,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Invoice",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  if (collection!.customerID != null) {
                    var collectionProvider = Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CollectionInvoiceList(
                              customerid: collection!.customerID!),
                        )).then((returnedData) {
                      setState(() {
                        collectionItems = returnedData;
                      });
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: "Please select a customer",
                      toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
                      gravity: ToastGravity
                          .BOTTOM, // You can set the position (TOP, CENTER, BOTTOM)
                      timeInSecForIosWeb:
                          1, // Time in seconds before the toast disappears on iOS and web
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(20),
                  dashPattern: [10, 10],
                  color: GlobalColors.mainColor.withOpacity(0.50),
                  strokeWidth: 2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: GlobalColors.mainColor,
                        ),
                      ),
                    ),
                  ),
                ),
              )),
          InvoiceCollection(
            collectionItems: collectionItems,
          ),
          Container(
            color: GlobalColors.mainColor,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 110,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SubTotal',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      collection!.paymentTotal.toStringAsFixed(2),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tax',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '0.00',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '0.00',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      collection!.paymentTotal.toStringAsFixed(2),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  void getDocNo() async {
    try {
      companyid = (await storage.read(key: "companyid"))!;
      userid = (await storage.read(key: "userid"))!;
      if (companyid != null) {
        String response = await BaseClient()
            .get('/Collection/GetNewCollectionDoc?companyid=' + companyid);

        setState(() {
          docNo = response.toString();
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw error; // Rethrow the error to be caught by the FutureBuilder
    }
  }

  void sendCollectionData() {
    if (collection!.customerCode != null) {
    } else {
      Fluttertoast.showToast(
        msg: "Please select a customer",
        toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
        gravity: ToastGravity
            .BOTTOM, // You can set the position (TOP, CENTER, BOTTOM)
        timeInSecForIosWeb:
            1, // Time in seconds before the toast disappears on iOS and web
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
