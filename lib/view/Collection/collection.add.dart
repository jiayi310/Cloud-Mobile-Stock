import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  XFile? _selectedImage;

  List<CollectMappings> collectionItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access context and salesProvider here
    final collectProvider = CollectionProvider.of(context);
    collectionItems = collectProvider?.collection.collectMappings ?? [];
  }

  @override
  void initState() {
    // TODO: implement initState
    getDocNo();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
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
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => _pickImage(ImageSource.camera),
          ),
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: () => _pickImage(ImageSource.gallery),
          ),
        ],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Image",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
          if (_selectedImage != null)
            GestureDetector(
              onTap: () {
                // Show larger image in a dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        width: 300, // Adjust the width as needed
                        height: 300, // Adjust the height as needed
                        child: Image.file(
                          File(_selectedImage!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: GlobalColors.mainColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.file(
                        File(_selectedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedImage = null;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: Text('Delete Image'),
                    )
                  ],
                ),
              ),
            ),
          Container(
            color: GlobalColors.mainColor,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Invoice",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
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
                          toastLength:
                              Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
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
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InvoiceCollection(
            collectionItems: collectionItems,
          ),
          SizedBox(
            height: 10,
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

  Future<void> sendCollectionData() async {
    if (collection!.customerCode != null) {
      Map<String, dynamic> jsonData = {
        "docID": 0,
        "docNo": docNo,
        "docDate": getCurrentDateTime(),
        "customerID": collection!.customerID,
        "customer": {
          "customerID": collection!.customerID,
          "customerCode": collection!.customerCode.toString(),
          "name": collection!.customerName.toString(),
          "lastModifiedDateTime": getCurrentDateTime(),
          "lastModifiedUserID": 1,
          "createdDateTime": getCurrentDateTime(),
          "createdUserID": 1,
          "companyID": 1
        },
        "customerCode": collection!.customerCode.toString(),
        "customerName": collection!.customerName.toString(),
        "paymentTotal": 0,
        "image": "",
        "lastModifiedDateTime": "2024-03-07T03:59:07.897Z",
        "lastModifiedUserID": 0,
        "createdDateTime": "2024-03-07T03:59:07.897Z",
        "createdUserID": 1,
        "companyID": 1,
        "collectMappings": [
          {
            "collectMappingID": 0,
            "collectDocID": 0,
            "collect": "string",
            "paymentAmt": 0,
            "salesDocID": 0,
            "sales": {
              "docID": 0,
              "docNo": "string",
              "docDate": "2024-03-07T03:59:07.897Z",
              "customerID": 0,
              "customerCode": "string",
              "customerName": "string",
              "address1": "string",
              "address2": "string",
              "address3": "string",
              "address4": "string",
              "deliverAddr1": "string",
              "deliverAddr2": "string",
              "deliverAddr3": "string",
              "deliverAddr4": "string",
              "salesAgent": "string",
              "phone": "string",
              "fax": "string",
              "email": "string",
              "attention": "string",
              "subtotal": 0,
              "taxableAmt": 0,
              "taxAmt": 0,
              "finalTotal": 0,
              "paymentTotal": 0,
              "outstanding": 0,
              "description": "string",
              "remark": "string",
              "shippingMethodID": 0,
              "shippingMethodDescription": "string",
              "qtDocID": 0,
              "qtDocNo": "string",
              "isVoid": true,
              "lastModifiedUserID": 0,
              "lastModifiedDateTime": "2024-03-07T03:59:07.897Z",
              "createdUserID": 0,
              "createdDateTime": "2024-03-07T03:59:07.897Z",
              "companyID": 0,
              "salesDetails": [
                {
                  "dtlID": 0,
                  "docID": 0,
                  "stockID": 0,
                  "stockCode": "string",
                  "stockBatchID": 0,
                  "batchNo": "string",
                  "description": "string",
                  "uom": "string",
                  "qty": 0,
                  "unitPrice": 0,
                  "discount": 0,
                  "total": 0,
                  "taxTypeID": 0,
                  "taxableAmt": 0,
                  "taxRate": 0,
                  "taxAmt": 0,
                  "locationID": 0,
                  "location": "string"
                }
              ]
            },
            "editOutstanding": 0,
            "editPaymentAmt": 0
          }
        ]
      };

      // Encode the JSON data
      String jsonString = jsonEncode(jsonData);

      // Make the API request
      try {
        final response = await BaseClient().post(
          '/Collection/CreateCollection',
          jsonString,
        );

        // Check the status code of the response
        if (response != null) {
          Map<String, dynamic> responseBody = json.decode(response);
          String docID = responseBody['docID'].toString();

          print('API request successful');
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         HistoryListingScreen(docid: int.parse(docID)),
          //   ),
          // );
        }
      } catch (e) {
        // Handle exceptions
        print('Exception during API request: $e');
      }
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

  getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(now.toUtc());
    return formattedDate;
  }
}
