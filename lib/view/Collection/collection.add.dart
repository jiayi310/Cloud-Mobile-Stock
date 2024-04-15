import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

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
import 'package:path_provider/path_provider.dart';

import '../../api/base.client.dart';
import '../../models/Customer.dart';
import '../../size.config.dart';
import '../../utils/global.colors.dart';
import 'HistoryListing/collection.listing.dart';
import 'invoice.customer.dart';

class CollectionAdd extends StatefulWidget {
  CollectionAdd({Key? key, required this.isEdit, required this.collection})
      : super(key: key);
  bool isEdit;
  Collection collection;

  @override
  State<CollectionAdd> createState() => _CollectionAddState();
}

class _CollectionAddState extends State<CollectionAdd> {
  String docNo = "";
  String companyid = "", userid = "";
  final storage = new FlutterSecureStorage();
  XFile? _selectedImage;

  List<CollectMappings> collectionItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!widget.isEdit) {
      final collectProvider = CollectionProvider.of(context);
      collectionItems = collectProvider?.collection.collectMappings ?? [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.isEdit) {
      docNo = widget.collection!.docNo!;
      saveImageToTempDirectory(widget.collection!.image!.split(',').last);
    } else {
      getDocNo();
    }
  }

  Future<void> saveImageToTempDirectory(String base64String) async {
    // Decode the base64 string into bytes
    Uint8List bytes = base64.decode(base64String.split(',').last);

    // Decode the bytes into an image using the 'image' package
    img.Image image = img.decodeImage(bytes)!;

    // Get the temporary directory using path_provider package
    Directory tempDir = await getTemporaryDirectory();

    // Create a temporary folder path
    String tempFolderPath = '${tempDir.path}/your_temp_folder';

    // Check if the temporary folder exists, if not, create it
    if (!(await Directory(tempFolderPath).exists())) {
      await Directory(tempFolderPath).create(recursive: true);
    }

    // Create a temporary file name
    String tempFileName = 'temp_image.png';

    // Construct the temporary file path
    String tempFilePath = '$tempFolderPath/$tempFileName';

    // Write the image to the temporary file
    File(tempFilePath).writeAsBytesSync(img.encodePng(image));

    setState(() {
      _selectedImage = XFile(tempFilePath);
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _selectedImage = image;
        widget.collection!.image = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      final collectionProvider = CollectionProvider.of(context);
      if (collectionProvider != null) {
        collectionProvider.setCollection(widget.collection);
      }
      collectionItems = widget.collection.collectMappings!;
    }
    widget.collection = CollectionProvider.of(context)!.collection;
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
                  "RM ${widget.collection!.paymentTotal!.toStringAsFixed(2)}",
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
                widget.isEdit ? updateCollectionData() : sendCollectionData();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  widget.isEdit ? "Update" : "Confirm",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        onPressed: () => _pickImage(ImageSource.camera),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.photo_library,
                          color: Colors.white,
                        ),
                        onPressed: () => _pickImage(ImageSource.gallery),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
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
                      List<int> _customerIds = [];

                      for (int i = 0; i < collectionItems.length; i++) {
                        _customerIds.add(collectionItems[i].salesDocID!);
                      }

                      if (widget.collection!.customerID != null) {
                        var collectionProvider = Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CollectionInvoiceList(
                                customerid: widget.collection!.customerID!,
                                customerIds: _customerIds,
                              ),
                            )).then((returnedData) {
                          if (returnedData != null) {
                            setState(() {
                              collectionItems = returnedData;
                            });
                          }
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
            refreshMainPage: refreshMainPage,
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
                      widget.collection!.paymentTotal.toStringAsFixed(2),
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
                      widget.collection!.paymentTotal.toStringAsFixed(2),
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
      throw error;
    }
  }

  Future<void> sendCollectionData() async {
    if (widget.collection!.customerCode != null) {
      String? base64Image;

      // Encode image to base64 only if it's not null
      if (widget.collection!.image != null) {
        base64Image =
            base64Encode(File(widget.collection!.image!).readAsBytesSync());
      }
      Map<String, dynamic> jsonData = {
        "docID": 0,
        "docNo": docNo,
        "docDate": getCurrentDateTime(),
        "customerID": widget.collection!.customerID,
        "customerCode": widget.collection!.customerCode.toString(),
        "customerName": widget.collection!.customerName.toString(),
        "salesAgent": widget.collection!.salesAgent.toString(),
        "paymentTotal": widget.collection!.paymentTotal.toString(),
        "image": base64Image,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": getCurrentDateTime(),
        "createdUserID": userid,
        "companyID": companyid,
        "collectMappings": collectionItems.map((collectItem) {
          return {
            "collectMappingID": 0,
            "collectDocID": 0,
            "paymentAmt": collectItem.paymentAmt ?? 0,
            "salesDocID": collectItem.salesDocID ?? 0,
            "salesDocNo": collectItem.salesDocNo,
            "salesDocDate": collectItem.salesDocDate!.toIso8601String(),
            "salesAgent": collectItem.salesAgent.toString(),
            "salesFinalTotal": collectItem.salesFinalTotal ?? 0,
            "salesOutstanding": collectItem.salesOutstanding ?? 0,
            "editOutstanding": 0,
            "editPaymentAmt": 0
          };
        }).toList(),
      };

      // Encode the JSON data
      String jsonString = jsonEncode(jsonData);

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

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CollectionListingScreen(docid: int.parse(docID)),
            ),
          );
          CollectionProviderData? providerData =
              CollectionProviderData.of(context);
          if (providerData != null) {
            providerData.clearCollection();
          }
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

  String? getImageBase64(XFile? imageFile) {
    if (imageFile != null) {
      Uint8List bytes = File(imageFile.path).readAsBytesSync();
      return base64Encode(bytes);
    }
    return null;
  }

  updateCollectionData() async {
    companyid = (await storage.read(key: "companyid"))!;
    userid = (await storage.read(key: "userid"))!;
    if (widget.collection!.customerCode != null) {
      String? base64Image;

      Map<String, dynamic> jsonData = {
        "docID": widget.collection.docID,
        "docNo": docNo,
        "docDate": widget.collection.docDate,
        "customerID": widget.collection!.customerID,
        "customerCode": widget.collection!.customerCode.toString(),
        "customerName": widget.collection!.customerName.toString(),
        "salesAgent": widget.collection!.salesAgent.toString(),
        "paymentTotal": widget.collection!.paymentTotal.toString(),
        "image": getImageBase64(_selectedImage),
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": widget.collection.createdDateTime,
        "createdUserID": widget.collection.createdUserID,
        "companyID": companyid,
        "collectMappings": collectionItems.map((collectItem) {
          return {
            "collectMappingID": collectItem.collectMappingID,
            "collectDocID": collectItem.collectDocID,
            "paymentAmt": collectItem.paymentAmt ?? 0,
            "salesDocID": collectItem.salesDocID ?? 0,
            "salesDocNo": collectItem.salesDocNo,
            "salesDocDate": collectItem.salesDocDate!.toIso8601String(),
            "salesAgent": collectItem.salesAgent.toString(),
            "salesFinalTotal": collectItem.salesFinalTotal ?? 0,
            "salesOutstanding": collectItem.salesOutstanding ?? 0,
            "editOutstanding": collectItem.editOutstanding ?? 0,
            "editPaymentAmt": collectItem.editPaymentAmt ?? 0
          };
        }).toList(),
      };

      // Encode the JSON data
      String jsonString = jsonEncode(jsonData);

      try {
        final response = await BaseClient().post(
          '/Collection/UpdateCollection?collectId=' +
              widget.collection.docID.toString(),
          jsonString,
        );

        // Check the status code of the response
        if (response == "true") {
          print('API request successful');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CollectionListingScreen(
                  docid: int.parse(widget.collection.docID.toString())),
            ),
          );
          CollectionProviderData? providerData =
              CollectionProviderData.of(context);
          if (providerData != null) {
            providerData.clearCollection();
          }
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

  refreshMainPage() {
    setState(() {
      collectionItems = collectionItems;
    });
  }
}
