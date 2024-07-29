import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/WMS/Picking/HistoryListing/picking.listing.dart';
import 'package:mobilestock/view/WMS/Picking/picking.sales.dart';
import 'package:mobilestock/view/WMS/Picking/picking.item.dart';

import '../../../api/base.client.dart';
import '../../../models/Picking.dart';
import '../../../models/Sales.dart';
import '../../../size.config.dart';
import 'PickingProvider.dart';

class PickingAdd extends StatefulWidget {
  PickingAdd({Key? key, required this.isEdit, required this.picking})
      : super(key: key);

  bool isEdit;
  Picking picking;

  @override
  State<PickingAdd> createState() => _PickingAddState();
}

class _PickingAddState extends State<PickingAdd> {
  String docNo = "";
  String companyid = "", userid = "";
  final storage = new FlutterSecureStorage();
  double totalQty = 0.0;

  List<PickingItems> pickingItems = [];
  List<PickingDetails> pickingDetails = [];
  List<String> selectedSalesDocNos = [];
  List<int> selectedSalesDocIds = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      docNo = widget.picking?.docNo ?? '';
      if (widget.picking != null) {
        _fetchSales();
        getSalesByCompanyID();
      } else {
        print("Picking is null or empty.");
      }
    } else {
      getDocNo();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total quantity as integer
    final totalQty = (widget.picking.pickingItems
                ?.fold(0.0, (sum, item) => sum + (item.qty ?? 0.0)) ??
            0.0)
        .toInt();

    // Calculate total picked quantity as integer
    final totalPickedQty = (widget.picking.pickingDetails
                ?.fold(0.0, (sum, detail) => sum + (detail.qty ?? 0.0)) ??
            0.0)
        .toInt();

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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                if (widget.isEdit) {
                  updatePickingData();
                } else {
                  sendPickingData();
                }
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
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            color: GlobalColors.mainColor,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sales No",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final List<int>? selectedSalesIds = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PickingSalesList(
                            previouslySelectedIds: selectedSalesDocIds,
                          ),
                        ),
                      );

                      if (selectedSalesIds != null) {
                        // Fetch the sales details for the selected invoices
                        final List<String> docNoList =
                            await getSalesDocNos(selectedSalesIds);
                        final Map<String, PickingItems> itemMap = {};

                        for (var id in selectedSalesIds) {
                          final sales = await getSalesDetails(id);
                          for (var detail in sales.salesDetails) {
                            final key = '${detail.stockCode}_${detail.uom}';
                            if (itemMap.containsKey(key)) {
                              // Update quantity if item already exists in map
                              itemMap[key]!.qty =
                                  (itemMap[key]!.qty ?? 0) + (detail.qty ?? 0);
                            } else {
                              // Add new item to map
                              itemMap[key] = PickingItems(
                                stockID: detail.stockID,
                                batchNo: detail.batchNo,
                                stockCode: detail.stockCode,
                                description: detail.description,
                                uom: detail.uom,
                                qty: detail.qty ?? 0, // Ensure qty is not null
                                locationID: detail.locationID,
                                location: detail.location,
                              );
                            }
                          }
                        }

                        // Convert the map to a list of PickingItems
                        final List<PickingItems> pickingItems =
                            itemMap.values.toList();

                        setState(() {
                          selectedSalesDocIds =
                              selectedSalesIds; // Update selected IDs
                          selectedSalesDocNos =
                              docNoList; // Update selected doc numbers
                          widget.picking?.pickingItems =
                              pickingItems; // Update picking items

                          // Debug: Print the updated picking items
                          print('Updated pickingItems: $pickingItems');
                        });
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
          if (selectedSalesDocNos.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...selectedSalesDocNos.map((docNo) => Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          docNo,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      )),
                ],
              ),
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
                    "Product",
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
          if (widget.picking.pickingItems != null)
            ItemPicking(
              //pickItems: widget.picking.pickingItems!,
              picking: widget.picking,
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
                      'Total Item',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${widget.picking.pickingItems?.length ?? 0}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Quantity ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${totalQty}',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Picked Quantity',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${totalPickedQty}',
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  void _fetchSales() async {
    try {
      final sales = await getSalesByCompanyID();
      if (mounted) {
        setState(() {
          // Use the sales data here
          print('Sales data: $sales');
        });
      }
    } catch (e) {
      print('Error fetching sales: $e');
    }
  }

  Future<void> printSalesDetails(List<int> ids) async {
    try {
      for (int id in ids) {
        // Fetch the sales details for each ID
        final Sales sales = await getSalesDetails(id);

        // Print the details
        print('Sales Details for ID $id:');
        print('Doc No: ${sales.docNo}');
        print('Doc Date: ${sales.docDate}');
        print('Customer ID: ${sales.customerID}');
        print('Customer Code: ${sales.customerCode}');
        print('Customer Name: ${sales.customerName}');
        print(
            'Address: ${sales.address1}, ${sales.address2}, ${sales.address3}, ${sales.address4}');
        print(
            'Deliver Address: ${sales.deliverAddr1}, ${sales.deliverAddr2}, ${sales.deliverAddr3}, ${sales.deliverAddr4}');
        print('Sales Agent: ${sales.salesAgent}');
        print('Phone: ${sales.phone}');
        print('Email: ${sales.email}');
        print('Subtotal: ${sales.subtotal}');
        print('Taxable Amount: ${sales.taxableAmt}');
        print('Tax Amount: ${sales.taxAmt}');
        print('Final Total: ${sales.finalTotal}');
        print('Payment Total: ${sales.paymentTotal}');
        print('Outstanding: ${sales.outstanding}');
        print('Description: ${sales.description}');
        print('Remark: ${sales.remark}');
        print('Shipping Method ID: ${sales.shippingMethodID}');
        print('QT Doc ID: ${sales.qTDocID}');
        print('QT Doc No: ${sales.qTDocNo}');
        print('Is Void: ${sales.isVoid}');
        print('Last Modified User ID: ${sales.lastModifiedUserID}');
        print('Last Modified Date Time: ${sales.lastModifiedDateTime}');
        print('Created User ID: ${sales.createdUserID}');
        print('Created Date Time: ${sales.createdDateTime}');
        print('Company ID: ${sales.companyID}');
        print(
            'Sales Details: ${sales.salesDetails.map((detail) => detail.toString()).toList()}'); // Adjust toString() as needed
        print('---------------------------------');
        print('Sales Details:');
        sales.salesDetails.forEach((detail) {
          print('Item ID: ${detail.stockCode}');
          print('Item Name: ${detail.description}');
          print('Quantity: ${detail.qty}');
          // Print other properties as needed
        });
        print('---------------------------------');
      }
    } catch (e) {
      print('Error fetching sales details: $e');
    }
  }

  Future<Sales> getSalesDetails(int docID) async {
    try {
      final response =
          await BaseClient().get('/Sales/GetSales?docid=' + docID.toString());

      if (response != null) {
        final Map<String, dynamic> jsonData = jsonDecode(response);
        Sales sales = Sales.fromJson2(jsonData);

        return sales;
      } else {
        throw Exception('Failed to load sales details');
      }
    } catch (e) {
      print('Error fetching sales details for ID $docID: $e');
      throw e;
    }
  }

  Future<List<String>> getSalesDocNos(List<int> ids) async {
    List<String> docNos = [];

    for (int id in ids) {
      try {
        Sales sales = await getSalesDetails(id);
        if (sales.docNo != null) {
          docNos.add(sales.docNo!);
        }
      } catch (e) {
        print('Error fetching details for ID $id: $e');
      }
    }

    return docNos;
  }

  void getDocNo() async {
    try {
      companyid = (await storage.read(key: "companyid"))!;
      userid = (await storage.read(key: "userid"))!;
      if (companyid != null) {
        String response = await BaseClient()
            .get('/Picking/GetNewPickingDoc?companyId=' + companyid);

        setState(() {
          docNo = response.toString();
          print('docNo: ${docNo}');
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }

  getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(now.toUtc());
    return formattedDate;
  }

  updatePickingData() async {
    // Read the company ID and user ID from storage
    companyid = (await storage.read(key: "companyid"))!;
    userid = (await storage.read(key: "userid"))!;

    if (widget.picking != null) {
      // Create the JSON payload
      Map<String, dynamic> jsonData = {
        "docID": widget.picking!.docID,
        "docNo": docNo,
        "docDate": widget.picking!.docDate,
        "description": widget.picking.description,
        "remark": widget.picking.remark,
        "isVoid": false,
        "isTransactPending": widget.picking.isTransactPending,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": widget.picking!.createdDateTime,
        "createdUserID": widget.picking!.createdUserID,
        "companyID": companyid,
        "pickingDetails": widget.picking.pickingDetails!.map((pickingDetails) {
          return {
            "dtlID": pickingDetails.dtlID ?? 0,
            "docID": pickingDetails.docID ?? 0,
            "stockID": pickingDetails.stockID,
            "stockBatchID": pickingDetails.stockBatchID ?? 0,
            "batchNo": pickingDetails.batchNo ?? "",
            "stockCode": pickingDetails.stockCode.toString(),
            "description": pickingDetails.description.toString(),
            "uom": pickingDetails.uom.toString(),
            "qty": pickingDetails.qty ?? 0,
            "locationID": pickingDetails.locationID ?? 0,
            "location": pickingDetails.location.toString(),
            "storageID": pickingDetails.storageID ?? 0,
            "storageCode": pickingDetails.storageCode.toString(),
          };
        }).toList(),
        "pickingItems": widget.picking.pickingItems!.map((pickingItems) {
          return {
            "pickingItemID": pickingItems.pickingItemID != null
                ? pickingItems.pickingItemID
                : 0,
            "docID": pickingItems.docID != null ? pickingItems.docID : 0,
            "stockID": pickingItems.stockID,
            "stockCode": pickingItems.stockCode.toString(),
            "description": pickingItems.description.toString(),
            "uom": pickingItems.uom.toString(),
            "qty": pickingItems.qty ?? 0,
            "packingQty": pickingItems.packingQty ?? 0,
            "transactQty": pickingItems.transactQty ?? 0,
            "editTransactQty": pickingItems.editTransactQty ?? 0,
            "locationID": pickingItems.locationID ?? 0,
            "location": pickingItems.location.toString(),
          };
        }).toList(),
      };

      String jsonString = jsonEncode(jsonData);

      try {
        final response = await BaseClient().post(
          '/Picking/UpdatePicking?pickingId=' + widget.picking.docID.toString(),
          jsonString,
        );

        if (response != null) {
          final responseBody = jsonDecode(response);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PickingListingScreen(
                docid: int.parse(widget.picking.docID.toString()),
              ),
            ),
          );

          // Clear stock take data from the provider if it exists
          PickingProviderData? providerData = PickingProviderData.of(context);
          if (providerData != null) {
            providerData.clearPicking();
          }
        } else {
          Fluttertoast.showToast(
            msg: "Update failed: ${response}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (e) {
        // Handle exceptions
        print('Exception during API request: $e');
        Fluttertoast.showToast(
          msg: "Update failed: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please enter a picking doc",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  sendPickingData() async {
    print('picking: ${widget.picking}');
    print('pickingDocMo: ${widget.picking.docNo}');
    print('pickingDocDate: ${widget.picking.docDate}');
    print('pickingItems: ${widget.picking.pickingItems}');
    print('pickingDetails: ${widget.picking.pickingDetails}');

    if (widget.picking.pickingItems != null) {
      Map<String, dynamic> jsonData = {
        "docID": 0,
        "docNo": docNo,
        "docDate": getCurrentDateTime(),
        "isVoid": false,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": getCurrentDateTime(),
        "createdUserID": userid,
        "companyID": companyid,
        "pickingDetails": widget.picking.pickingDetails?.map((pickingDetail) {
          return {
            "dtlID": 0,
            "docID": 0,
            "stockID": pickingDetail.stockID,
            "stockBatchID": pickingDetail.stockBatchID,
            "batchNo": pickingDetail.batchNo ?? "",
            "stockCode": pickingDetail.stockCode.toString(),
            "description": pickingDetail.description.toString(),
            "uom": pickingDetail.uom.toString(),
            "qty": pickingDetail.qty ?? 0,
            "locationID": pickingDetail.locationID ?? 0,
            "location": pickingDetail.location.toString(),
            "storageID": pickingDetail.storageID ?? 0,
            "storageCode": pickingDetail.storageCode.toString(),
          };
        }).toList(),
        "pickingItems": widget.picking!.pickingItems!.map((pickingItem) {
          return {
            "pickingItemID": 0,
            "docID": 0,
            "stockID": pickingItem.stockID,
            "stockCode": pickingItem.stockCode.toString(),
            "description": pickingItem.description.toString(),
            "uom": pickingItem.uom.toString(),
            "qty": pickingItem.qty ?? 0,
            "packingQty": pickingItem.packingQty ?? 0,
            "transactQty": pickingItem.transactQty ?? 0,
            "editTransactQty": pickingItem.editTransactQty ?? 0,
            "locationID": pickingItem.locationID ?? 0,
            "location": pickingItem.location.toString(),
          };
        }).toList(),
      };

      String jsonString = jsonEncode(jsonData);

      print('Request Payload: $jsonString'); // Log the request payload

      try {
        var response = await BaseClient().post(
          '/Picking/CreatePicking',
          jsonString,
        );
        print('Test Response: $response');

        if (response != null) {
          Map<String, dynamic> responseBody = json.decode(response);
          String docID = responseBody['docID'].toString();

          //await updateSalesData();

          print('API request successful');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PickingListingScreen(docid: int.parse(docID)),
            ),
          );

          PickingProviderData? providerData = PickingProviderData.of(context);
          if (providerData != null) {
            providerData.clearPicking();
          }
        } else {
          Fluttertoast.showToast(
            msg: "Data upload failed: ${response}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (e) {
        print('Exception: $e');
      }
    } else {
      print('picking item data is null');
    }
  }

  Future<void> updateSalesData() async {
    if (selectedSalesDocIds.isEmpty) {
      print('No sales ID selected.');
      Fluttertoast.showToast(
        msg: "No sales ID selected.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    // Use the first value in selectedSalesDocIds
    String salesId = selectedSalesDocIds.first.toString();

    Map<String, dynamic> jsonData = {
      "isPicking": true,
      //"pickingDocID": widget.picking.docID ?? 0,
      "pickingDocNo": widget.picking.docNo ?? 'PCK-00027',
    };

    String jsonString = jsonEncode(jsonData);

    print('Sending request to /Sales/UpdateSales?salesId=$salesId');
    print('Request body: $jsonString');

    try {
      final response = await BaseClient().post(
        '/Sales/UpdateSales?salesId=$salesId',
        jsonString,
      );

      print('Response: $response');

      if (response == "true") {
        print('Sales update successful for salesId: $salesId');
        Fluttertoast.showToast(
          msg: "Sales update successful for salesId: $salesId",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print('Sales update failed for salesId: $salesId');
        Fluttertoast.showToast(
          msg: "Sales update failed for salesId: $salesId",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print('Exception during Sales API request for salesId: $salesId: $e');
      Fluttertoast.showToast(
        msg: "Sales update failed for salesId: $salesId: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<List<Sales>> getSalesByCompanyID() async {
    try {
      companyid = (await storage.read(key: "companyid"))!;
      final response = await BaseClient()
          .get('/Sales/GetSalesListByCompanyId?companyId=' + companyid);

      if (response != null) {
        final List<dynamic> jsonData = jsonDecode(response);

        List<Sales> salesList =
            jsonData.map((item) => Sales.fromJson(item)).toList();

        print(salesList);

        return salesList;
      } else {
        throw Exception('Failed to load sales details');
      }
    } catch (e) {
      print('Error fetching sales details for company ID $companyid: $e');
      throw e;
    }
  }

  // Future<List<Sales>> getSalesByPickingDocNo(String pickingDocNo) async {
  //   int nCompanyID = int.parse(companyid!);
  //   List<Sales> allSales = await getSalesByCompanyID(nCompanyID);
  //   List<Sales> filteredSales =
  //       allSales.where((sale) => sale.pickingDocNo == pickingDocNo).toList();
  //
  //   // Print the filtered sales list
  //   print('Filtered sales with pickingDocNo $pickingDocNo: $filteredSales');
  //
  //   return filteredSales;
  // }

  refreshMainPage() {
    setState(() {
      pickingItems = pickingItems;
    });
  }
}
