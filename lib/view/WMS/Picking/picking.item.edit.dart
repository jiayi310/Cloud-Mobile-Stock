import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mobilestock/models/Picking.dart';
import '../../../api/base.client.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import 'dart:convert'; // for json.decode
import 'package:http/http.dart' as http;

class EditPickingItems extends StatefulWidget {
  final PickingItems pickingItem;
  final Function refreshMainPage;

  EditPickingItems(
      {Key? key, required this.pickingItem, required this.refreshMainPage})
      : super(key: key);

  @override
  _EditPickingItemsState createState() => _EditPickingItemsState();
}

class _EditPickingItemsState extends State<EditPickingItems> {
  List<Storage> storageOptions = [];
  Storage? selectedStorage;
  int pickedQuantity = 0;
  String companyid = "";
  final storage = new FlutterSecureStorage();
  //String? selectedStorageCode;

  int stockID = 0;
  String stockUom = "";
  String stockLocation = "";

  @override
  void initState() {
    super.initState();
    stockID = widget.pickingItem.stockID?.toInt() ?? 0;
    stockUom = widget.pickingItem.uom?.toString() ?? "";
    stockLocation = widget.pickingItem.locationID?.toString() ?? "";

    // Fetch storage options based on item code, UOM, and location
    fetchStorageOptions();
    // Set initial picked quantity
    pickedQuantity = widget.pickingItem.qty?.toInt() ?? 0;
  }

  Future<List<Storage>> fetchStorageData() async {
    try {
      // Read company ID from storage
      String stockCompanyId = await storage.read(key: "companyid") ?? '';

      // Construct the URL with proper query parameters
      final String url =
          '/Stock/GetSpecificStockBalance?stockId=$stockID&stockUom=$stockUom&locationId=$stockLocation&companyid=$stockCompanyId';

      // Make the GET request
      String response = await BaseClient().get(url);

      // Check if response is successful
      if (response.isNotEmpty) {
        print('response ${response}');
        // Parse the response body
        List<dynamic> data = json.decode(response);
        return data.map((json) => Storage.fromJson(json)).toList();
      } else {
        throw Exception('Empty response from server');
      }
    } catch (e) {
      // Handle any exceptions
      throw Exception('Error fetching storage data: $e');
    }
  }

  void fetchStorageOptions() async {
    try {
      List<Storage> storages = await fetchStorageData();
      setState(() {
        storageOptions = storages;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load storage data'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 100,
          padding: EdgeInsets.only(
              left: defaultPadding, right: defaultPadding, bottom: 30, top: 20),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  saveChanges();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 110,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  decoration: BoxDecoration(
                      color: GlobalColors.mainColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          foregroundColor: GlobalColors.mainColor,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Pick Stock',
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Item Code: ${widget.pickingItem.stockCode ?? 'Unkown'}",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "UOM: ${widget.pickingItem.uom ?? 'Unknown'}",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Quantity: ${widget.pickingItem.qty ?? 'Unknown'}",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Storage",
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
                height: 300, // Adjust height as needed or remove if not fixed
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: storageOptions.length,
                  itemBuilder: (context, index) {
                    final storage = storageOptions[index];
                    return ListTile(
                      title: Text(storage.storageCode ?? 'Unknown'),
                      subtitle: Text(storage.location ?? 'Unknown'),
                      trailing: Radio<Storage>(
                        value: storage,
                        groupValue: selectedStorage,
                        onChanged: (Storage? value) {
                          setState(() {
                            selectedStorage = value;
                          });
                        },
                      ),
                    );
                  },
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
                        "Picked Quantity",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, color: GlobalColors.mainColor),
                      onPressed: () {
                        setState(() {
                          if (pickedQuantity > 0) {
                            pickedQuantity--;
                          }
                        });
                      },
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Picked Quantity',
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: GlobalColors.mainColor),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: GlobalColors.mainColor),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: GlobalColors.mainColor),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            pickedQuantity = int.tryParse(value) ?? 0;
                          });
                        },
                        controller: TextEditingController(
                            text: pickedQuantity.toString()),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: GlobalColors.mainColor),
                      onPressed: () {
                        setState(() {
                          pickedQuantity++;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void saveChanges() {
    // Ensure a storage is selected
    if (selectedStorage != null && pickedQuantity != 0) {
      print('location: ${selectedStorage!.location}');
      print('storageCode: ${selectedStorage!.storageCode}');

      Navigator.pop(
        context,
        {
          'stockID': selectedStorage!.stockID,
          'stockCode': selectedStorage!.stockCode,
          'stockDescription': selectedStorage!.stockDescription,
          'uom': selectedStorage!.uom,
          'wmsQty': selectedStorage!.wmsQty,
          'stockBatchID': selectedStorage!.stockBatchID,
          'batchNo': selectedStorage!.batchNo,
          'batchExpiryDate': selectedStorage!.batchExpiryDate,
          'locationID': selectedStorage!.locationID,
          'location': selectedStorage!.location,
          'storageID': selectedStorage!.storageID,
          'storageCode': selectedStorage!.storageCode,
          'pickedQuantity': pickedQuantity,
        },
      );
      print('Choosed storage: ${context}');
    } else {
      if (selectedStorage == null) {
        // Show an error message if no storage is selected
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please select a storage'),
          backgroundColor: Colors.red,
        ));
      } else if (pickedQuantity == 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter picked quantity'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}

class Storage {
  int? stockID;
  String? stockCode;
  String? stockDescription;
  String? uom;
  double? wmsQty;
  int? stockBatchID;
  String? batchNo;
  String? batchExpiryDate;
  int? locationID;
  String? location;
  int? storageID;
  String? storageCode;

  Storage(
      {this.stockID,
      this.stockCode,
      this.stockDescription,
      this.uom,
      this.wmsQty,
      this.stockBatchID,
      this.batchNo,
      this.batchExpiryDate,
      this.locationID,
      this.location,
      this.storageID,
      this.storageCode});

  factory Storage.fromJson(Map<String, dynamic> json) {
    return Storage(
      stockID: json['stockID'],
      stockCode: json['stockCode'],
      stockDescription: json['stockDescription'],
      uom: json['uom'],
      wmsQty: json['wmsQty'],
      stockBatchID: json['stockBatchID'],
      batchNo: json['batchNo'],
      batchExpiryDate: json['batchExpiryDate'],
      locationID: json['locationID'],
      location: json['location'],
      storageID: json['storageID'],
      storageCode: json['storageCode'],
    );
  }
}
