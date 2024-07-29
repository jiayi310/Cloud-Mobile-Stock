import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/models/Packing.dart';
import 'package:mobilestock/models/StockTake.dart';
import 'package:mobilestock/view/WMS/Pack&Ship/packing.invoice.dart';
import 'package:mobilestock/view/WMS/StockTake/item.stocktake.dart';
import 'package:mobilestock/view/WMS/StockTake/product.list.dart';

import '../../../api/base.client.dart';
import '../../../models/Packing.dart';
import '../../../models/Sales.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import '../../Quotation/NewQuotation/product.quotation.dart';
import '../../Sales/CheckOut/checkout.view.dart';
import 'HistoryListing/pack.listing.dart';
import 'PackingProvider.dart';
import 'item.packing.dart';

class PackingAdd extends StatefulWidget {
  PackingAdd({Key? key, required this.isEdit, required this.packing})
      : super(key: key) {
    print('Navigating to PackingAdd with the following info:');
    print('isEdit: $isEdit');
    print('Packing docID: ${packing.docID}');
    print('Packing docNo: ${packing.docNo}');
    print('Packing shipmethod 1: ${packing.shippingMethodID}');
    print('Packing shipmethod 2: ${packing.shippingMethodDescription}');
    print('Packing shippingRefNo: ${packing.shippingRefNo}');
    print('Packing salesDocNo: ${packing.salesDocNo}');
    // Add more fields as needed
  }

  final bool isEdit;
  Packing packing;

  @override
  State<PackingAdd> createState() => _PackingAddState();
}

class _PackingAddState extends State<PackingAdd> {
  String docNo = "";
  String companyid = "", userid = "";
  final storage = new FlutterSecureStorage();
  ShippingMethod? selectedShippingMethod;
  List<ShippingMethod> shippingMethods = [];
  TextEditingController shippingRefController = TextEditingController();
  int? nSelectedSalesId;

  List<PackingDetails> packingDetails = [];
  String selectedInvoiceDocNo = "";

  String selectedSalesNo = "";
  String selectedDebCode = "";
  String selectedDebName = "";
  String selectedDebAdd1 = "";
  String selectedDebAdd2 = "";
  String selectedDebAdd3 = "";
  String selectedDebAdd4 = "";
  String selectedDebPhone = "";
  String selectedDebAtten = "";
  String selectedPackingNo = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (!widget.isEdit) {
    //   final packingProvider = PackingProvider.of(context);
    //   packingDetails = packingProvider?.packing.packingDetails ?? [];
    // }
  }

  @override
  void initState() {
    if (widget.isEdit) {
      print('packing: ${widget.packing.packingDetails}');
      print('packing: ${widget.packing.shippingRefNo}');
      print('packing: ${widget.packing.shippingMethodID}');
      print('packing: ${widget.packing.shippingMethodDescription}');

      docNo = widget.packing!.docNo!;
      //selectedShippingMethod = widget.packing!.shippingMethodDescription!;
      shippingRefController = TextEditingController(
        text: widget.packing.shippingRefNo ?? '',
      );
    } else {
      getDocNo();
    }
    fetchShippingMethods();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      final packingProvider = PackingProvider.of(context);

      if (packingProvider != null) {
        packingProvider.setPacking(widget.packing);
      } else {
        print('packing provider is null');
      }
      packingDetails = widget.packing.packingDetails!;
      fetchShippingMethods();
    }
    //widget.packing = PackingProvider.of(context)!.packing;

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
                widget.isEdit ? updatePackingData() : sendPackingData();
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
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: GlobalColors.mainColor,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.packing.salesDocNo != null ? "Sales No" : "Sales No",
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
                      final int? selectedSalesId = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PackingInvoice(selectedSalesId: nSelectedSalesId),
                        ),
                      );

                      if (selectedSalesId != null) {
                        nSelectedSalesId = selectedSalesId;
                        // Fetch the sales details for the selected invoice
                        final Sales sales =
                            await getSalesDetails(selectedSalesId);

                        selectedSalesNo = sales.docNo.toString();
                        selectedDebCode = sales.customerCode.toString();
                        selectedDebName = sales.customerName.toString();
                        selectedDebAdd1 = sales.deliverAddr1 ?? "";
                        selectedDebAdd2 = sales.deliverAddr2 ?? "";
                        selectedDebAdd3 = sales.deliverAddr3 ?? "";
                        selectedDebAdd4 = sales.deliverAddr4 ?? "";
                        selectedDebPhone = sales.phone.toString();
                        selectedDebAtten = sales.attention.toString();
                        //selectedPackingNo = sales.;

                        int nUserID = int.parse(userid);

                        // Create a Packing instance from the sales details
                        Packing newPacking = Packing(
                          docID: 0,
                          docNo: docNo,
                          docDate: getCurrentDateTime(),
                          customerID: sales.customerID,
                          customerCode: sales.customerCode,
                          customerName: sales.customerName,
                          address1: sales.address1,
                          address2: sales.address2,
                          address3: sales.address3,
                          address4: sales.address4,
                          deliverAddr1: sales.deliverAddr1,
                          deliverAddr2: sales.deliverAddr2,
                          deliverAddr3: sales.deliverAddr3,
                          deliverAddr4: sales.deliverAddr4,
                          phone: sales.phone,
                          fax: sales.fax,
                          email: sales.email,
                          attention: sales.attention,
                          description: sales.description,
                          remark: sales.remark,
                          isVoid: false,
                          lastModifiedDateTime: getCurrentDateTime(),
                          lastModifiedUserID: nUserID,
                          createdDateTime: getCurrentDateTime(),
                          createdUserID: nUserID,
                          shippingRefNo: null,
                          shippingMethodID: null,
                          shippingMethodDescription: null,
                          salesDocID: sales.docID,
                          salesDocNo: sales.docNo,
                          //pickingDocID: sales.pickingDocId,
                          //pickingDocNo: sales.pickingDocNo,
                          companyID: sales.companyID,
                          packingDetails: sales.salesDetails.map((detail) {
                            return PackingDetails(
                              dtlID: 0,
                              docID: 0,
                              //pickingItemID: sales.pickingDocId,
                              stockID: detail.stockID,
                              stockBatchID: null,
                              batchNo: detail.batchNo,
                              stockCode: detail.stockCode,
                              description: detail.description,
                              uom: detail.uom,
                              qty: detail.qty,
                            );
                          }).toList(),
                        );

                        // Update the state with the selected docNo and packing details
                        setState(() {
                          widget.packing = newPacking;
                          selectedInvoiceDocNo = selectedSalesNo;
                          packingDetails = newPacking.packingDetails ?? [];
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
          if (selectedInvoiceDocNo.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedSalesNo,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Debtor Code: ',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${selectedDebCode ?? ""}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Debtor Name: ',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${selectedDebName ?? ""}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Attention: ',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${selectedDebAtten ?? ""}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phone: ',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${selectedDebPhone ?? ""}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${selectedDebAdd1 ?? ""}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            Text(
                              '${selectedDebAdd2 ?? ""}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            Text(
                              '${selectedDebAdd3 ?? ""}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            Text(
                              '${selectedDebAdd4 ?? ""}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          if (widget.packing != null)
            ItemPacking(
              pakItems: packingDetails,
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
                    "Shipping Method",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<ShippingMethod>(
                  hint: Text(
                    "Select a method",
                    style: TextStyle(color: Colors.grey),
                  ),
                  value: selectedShippingMethod,
                  onChanged: (ShippingMethod? newValue) {
                    setState(() {
                      selectedShippingMethod = newValue;
                    });
                  },
                  items: shippingMethods.map((method) {
                    return DropdownMenuItem<ShippingMethod>(
                      value: method,
                      child: Text(method.description ?? ''),
                    );
                  }).toList(),
                  isExpanded: true,
                ),
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
                    "Shipping Ref No",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0), // Adjust padding as needed
            child: TextField(
              controller: shippingRefController,
              decoration: InputDecoration(
                hintText: 'Enter Shipping Ref No',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalColors.mainColor),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalColors.mainColor),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalColors.mainColor),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
          ),
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
            .get('/Packing/GetNewPackingDoc?companyId=' + companyid);

        setState(() {
          docNo = response.toString();
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }

  Future<Sales> getSalesDetails(int docID) async {
    try {
      final response =
          await BaseClient().get('/Sales/GetSales?docid=' + docID.toString());

      if (response != null) {
        final Map<String, dynamic> jsonData = jsonDecode(response);
        Sales sales = Sales.fromJson2(jsonData);

        //create picking object
        Packing picking = Packing(
          //docID: docID,
          //docNo: docNo,
          //docDate: ,
          description: null,
          remark: null,
          isVoid: false,
          //isTransactPending: true,
          //lastModifiedDateTime: ,
          //lastModifiedUserID: ,
          //createdDateTime: ,
          //createdUserID: ,
          //companyID: ,
          packingDetails: sales.salesDetails.map((detail) {
            return PackingDetails(
              //docID: ,
              stockID: detail.stockID,
              //stockBatchID: ,
              batchNo: detail.batchNo,
              //batchExpiryDate: ,
              stockCode: detail.stockCode,
              description: detail.description,
              uom: detail.uom,
              qty: detail.qty,
              //packingQty: ,
              //transactQty: ,
              //editTransactQty: ,
              //locationID: detail.locationID,
              //location: detail.location,
            );
          }).toList(),
        );

        return sales;
      } else {
        throw Exception('Failed to load sales details');
      }
    } catch (e) {
      print('Error fetching sales details for ID $docID: $e');
      throw e;
    }
  }

  updatePackingData() async {
    print('shipping refno: ${shippingRefController.text.toString()}');
    print('shipping method: ${selectedShippingMethod}');

    // Read the company ID and user ID from storage
    companyid = (await storage.read(key: "companyid"))!;
    userid = (await storage.read(key: "userid"))!;

    if (widget.packing != null) {
      // Create the JSON payload
      Map<String, dynamic> jsonData = {
        "docID": widget.packing!.docID,
        "docNo": docNo,
        "docDate": widget.packing!.docDate,
        "customerID": widget.packing.customerID ?? 0,
        "customerCode": widget.packing.customerCode ?? "",
        "customerName": widget.packing.customerName ?? "",
        "address1": widget.packing.address1 ?? "",
        "address2": widget.packing.address2 ?? "",
        "address3": widget.packing.address3 ?? "",
        "address4": widget.packing.address4 ?? "",
        "deliverAddr1": widget.packing.deliverAddr1 ?? "",
        "deliverAddr2": widget.packing.deliverAddr2 ?? "",
        "deliverAddr3": widget.packing.deliverAddr3 ?? "",
        "deliverAddr4": widget.packing.deliverAddr4 ?? "",
        "phone": widget.packing.phone ?? "",
        "fax": widget.packing.fax ?? "",
        "email": widget.packing.email ?? "",
        "attention": widget.packing.attention ?? "",
        "description": widget.packing.description ?? null,
        "remark": widget.packing.remark ?? null,
        "isVoid": false,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": widget.packing!.createdDateTime,
        "createdUserID": widget.packing!.createdUserID,
        "companyID": companyid,
        "shippingRefNo": shippingRefController.text.toString(),
        "shippingMethodID": selectedShippingMethod?.shippingMethodID ?? null,
        "shippingMethodDescription":
            selectedShippingMethod?.description ?? null,
        "salesDocID": widget.packing.salesDocID,
        "salesDocNo": widget.packing.salesDocNo,
        "pickingDocID": widget.packing.pickingDocID,
        "pickingDocNo": widget.packing.pickingDocNo,
        "packingDetails": packingDetails.map((packingItem) {
          return {
            "dtlID": packingItem.dtlID ?? 0,
            "docID": packingItem.docID ?? 0,
            "pickingItemID": packingItem.pickingItemID,
            "stockID": packingItem.stockID,
            "stockBatchID": packingItem.stockBatchID,
            "batchNo": packingItem.batchNo,
            "stockCode": packingItem.stockCode.toString(),
            "description": packingItem.description.toString(),
            "uom": packingItem.uom.toString(),
            "qty": packingItem.qty ?? 0,
          };
        }).toList(),
      };

      String jsonString = jsonEncode(jsonData);

      try {
        final response = await BaseClient().post(
          '/Packing/UpdatePacking?packingId=' + widget.packing.docID.toString(),
          jsonString,
        );

        if (response != null) {
          final responseBody = jsonDecode(response);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PackingListingScreen(
                docid: int.parse(widget.packing.docID.toString()),
              ),
            ),
          );

          // Clear stock take data from the provider if it exists
          PackingProviderData? providerData = PackingProviderData.of(context);
          if (providerData != null) {
            providerData.clearPacking();
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

  Future<void> fetchShippingMethods() async {
    companyid = (await storage.read(key: "companyid"))!;
    final response = await BaseClient()
        .get('/ShippingMethod/GetShippingMethodList?companyid=' + companyid);

    print('${response}');

    if (response != null) {
      try {
        final List<dynamic> data = json.decode(response) as List<dynamic>;

        final List<ShippingMethod> methods =
            data.map((item) => ShippingMethod.fromJson(item)).toList();

        // // Filter out disabled shipping methods
        // final List<ShippingMethod> enabledMethods =
        //     methods.where((method) => method.isDisabled == 'false').toList();

        setState(() {
          shippingMethods = methods;
        });
      } catch (e) {
        print('Error parsing shipping methods: $e');
        Fluttertoast.showToast(
          msg: "Failed to load shipping method",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      print('Failed to fetch shipping methods');
      Fluttertoast.showToast(
        msg: "Failed to load shipping method",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
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

  sendPackingData() async {
    print('Packing Data: ${widget.packing}');
    print('Packing Doc No: ${widget.packing.docNo}');
    print('Packing Doc Date: ${widget.packing.docDate}');
    print('Packing Details: ${widget.packing.packingDetails}');

    if (widget.packing.packingDetails != null) {
      Map<String, dynamic> jsonData = {
        "docID": 0,
        "docNo": docNo,
        "docDate": widget.packing.docDate ?? getCurrentDateTime(),
        "customerID": widget.packing.customerID ?? 0,
        "customerCode": widget.packing.customerCode ?? "",
        "customerName": widget.packing.customerName ?? "",
        "address1": widget.packing.address1 ?? "",
        "address2": widget.packing.address2 ?? "",
        "address3": widget.packing.address3 ?? "",
        "address4": widget.packing.address4 ?? "",
        "deliverAddr1": widget.packing.deliverAddr1 ?? "",
        "deliverAddr2": widget.packing.deliverAddr2 ?? "",
        "deliverAddr3": widget.packing.deliverAddr3 ?? "",
        "deliverAddr4": widget.packing.deliverAddr4 ?? "",
        "phone": widget.packing.phone ?? "",
        "fax": widget.packing.fax ?? "",
        "email": widget.packing.email ?? "",
        "attention": widget.packing.attention ?? "",
        "description": widget.packing.description ?? null,
        "remark": widget.packing.remark ?? null,
        "isVoid": false,
        "lastModifiedDateTime": getCurrentDateTime(),
        "lastModifiedUserID": userid,
        "createdDateTime": getCurrentDateTime(),
        "createdUserID": userid,
        "shippingRefNo": shippingRefController.text.toString(),
        "shippingMethodID": selectedShippingMethod?.shippingMethodID ?? null,
        "shippingMethodDescription":
            selectedShippingMethod?.description ?? null,
        "salesDocID": widget.packing.salesDocID ?? 0,
        "salesDocNo": widget.packing.salesDocNo ?? "",
        "pickingDocID": widget.packing.pickingDocID ?? 0,
        "pickingDocNo": widget.packing.pickingDocNo ?? "",
        "companyID": companyid,
        "packingDetails": widget.packing.packingDetails!.map((stItem) {
          return {
            "dtlID": stItem.dtlID ?? 0,
            "docID": stItem.docID ?? 0,
            "pickingItemID": stItem.pickingItemID ?? 0,
            "stockID": stItem.stockID,
            "stockBatchID": stItem.stockBatchID ?? 0,
            "batchNo": stItem.batchNo.toString(),
            "stockCode": stItem.stockCode.toString(),
            "description": stItem.description.toString(),
            "uom": stItem.uom.toString(),
            "qty": stItem.qty ?? 0,
          };
        }).toList(),
      };

      String jsonString = jsonEncode(jsonData);

      print('Request Payload: $jsonString');

      try {
        var response = await BaseClient().post(
          '/Packing/CreatePacking',
          jsonString,
        );
        print('API Response: $response');

        if (response != null) {
          Map<String, dynamic> responseBody = json.decode(response);
          String docID = responseBody['docID'].toString();

          print('API request successful');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PackingListingScreen(docid: int.parse(docID)),
            ),
          );

          PackingProviderData? providerData = PackingProviderData.of(context);
          if (providerData != null) {
            providerData.clearPacking();
          }
        } else {
          print('Data upload failed: ${response}');
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
        Fluttertoast.showToast(
          msg: "Exception: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      print('Packing item data is null');
      Fluttertoast.showToast(
        msg: "Packing item data is null",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  refreshMainPage() {
    setState(() {
      final packingProvider = PackingProvider.of(context);
      if (packingProvider != null) {
        packingDetails = packingProvider!.packing.packingDetails!;
      }
    });
  }
}

class ShippingMethod {
  int? shippingMethodID;
  String? description;
  int? companyID;
  bool? isDisabled;

  ShippingMethod({
    this.shippingMethodID,
    this.description,
    this.companyID,
    this.isDisabled,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      shippingMethodID: json['shippingMethodID'],
      description: json['description'],
      companyID: json['companyID'],
      isDisabled: json['isDisabled'],
    );
  }
}
