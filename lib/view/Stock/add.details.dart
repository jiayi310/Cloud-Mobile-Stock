import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/Stock.dart';
import '../../utils/global.colors.dart';
import '../Customer/textfield.widget.dart';
import '../home.view.dart';

class AddStockDetails extends StatefulWidget {
  AddStockDetails({Key? key, required this.stock}) : super(key: key);
  final Stock stock;

  @override
  State<AddStockDetails> createState() => _AddStockDetailsState();
}

class _AddStockDetailsState extends State<AddStockDetails>
    with TickerProviderStateMixin {
  List<StockUOMDtoList> uomList = [];
  List<StockBatchDtoList> batchList = [];
  late TabController _tabController;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController shelfController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController price1Controller = TextEditingController();
  TextEditingController price2Controller = TextEditingController();
  TextEditingController price3Controller = TextEditingController();
  TextEditingController price4Controller = TextEditingController();
  TextEditingController price5Controller = TextEditingController();
  TextEditingController price6Controller = TextEditingController();
  TextEditingController minSalePriceController = TextEditingController();
  TextEditingController maxSalePriceController = TextEditingController();
  TextEditingController minQuantityController = TextEditingController();
  TextEditingController maxQuantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Add Stock Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicator:
                CircleTabIndicator(color: GlobalColors.mainColor, radius: 4),
            tabs: [
              Tab(
                text: "UOM",
              ),
              Tab(
                text: "Batch",
              ),
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'UOM List',
                      style: TextStyle(
                          fontSize: 18,
                          color: GlobalColors.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showDialog();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: GlobalColors.mainColor),
                      child: Text('+ NEW'),
                    ),
                  ],
                ),
                SizedBox(
                    height: 20), // Add some space between the Row and ListView
                Expanded(
                  child: ListView.builder(
                    itemCount: uomList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('UOM')),
                              DataColumn(label: Text('Rate')),
                              DataColumn(label: Text('Shelf')),
                              DataColumn(label: Text('Price 1')),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text(uomList[index].uom!)),
                                DataCell(Text(uomList[index].rate.toString())),
                                DataCell(Text(uomList[index].shelf.toString())),
                                DataCell(Text(uomList[index].price.toString())),
                              ]),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Content for Batch tab
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Batch List',
                      style: TextStyle(
                          fontSize: 18,
                          color: GlobalColors.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showBatchDialog();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: GlobalColors.mainColor),
                      child: Text('+ NEW'),
                    ),
                  ],
                ),
                SizedBox(
                    height: 20), // Add some space between the Row and ListView
                Expanded(
                  child: ListView.builder(
                    itemCount: batchList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Batch No')),
                              DataColumn(label: Text('Expiry Date')),
                              DataColumn(label: Text('Manufactured Date')),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text(batchList[index].batchNo!)),
                                DataCell(Text(
                                    batchList[index].expiryDate.toString())),
                                DataCell(Text(batchList[index]
                                    .manufacturedDate
                                    .toString())),
                              ]),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _showDialog() async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter UOM Details"),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFieldWidget(
                      label: 'UOM Description',
                      controller: descriptionController,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Shelf',
                      controller: shelfController,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Cost',
                      controller: costController,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d*\.?\d{0,2}')), // Allow only decimal input
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Rate',
                      controller: rateController,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d*\.?\d{0,2}')), // Allow only decimal input
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Price 1',
                      controller: price1Controller,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d*\.?\d{0,2}')), // Allow only decimal input
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Price 2',
                      controller: price2Controller,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d*\.?\d{0,2}')), // Allow only decimal input
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Price 3',
                      controller: price3Controller,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d*\.?\d{0,2}')), // Allow only decimal input
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Price 4',
                      controller: price4Controller,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d*\.?\d{0,2}')), // Allow only decimal input
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Price 5',
                      controller: price5Controller,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d*\.?\d{0,2}')), // Allow only decimal input
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Price 6',
                      controller: price6Controller,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d*\.?\d{0,2}')), // Allow only decimal input
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Min Sale Price',
                      controller: minSalePriceController,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d*\.?\d{0,2}')), // Allow only decimal input
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Max Sale Price',
                      controller: maxSalePriceController,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d*\.?\d{0,2}')), // Allow only decimal input
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Min Quantity',
                      controller: minQuantityController,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d*\.?\d{0,2}')), // Allow only decimal input
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Max Quantity',
                      controller: maxQuantityController,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'^\d*\.?\d{0,2}')), // Allow only decimal input// Allow only decimal input
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                // Add the entered data to the uomList
                uomList.add(StockUOMDtoList(
                  uom: descriptionController.text,
                  shelf: shelfController.text,
                  cost: parseDoubleValue(costController.text),
                  rate: parseDoubleValue(rateController.text),
                  price: parseDoubleValue(price1Controller.text),
                  price2: parseDoubleValue(price2Controller.text),
                  price3: parseDoubleValue(price3Controller.text),
                  price4: parseDoubleValue(price4Controller.text),
                  price5: parseDoubleValue(price5Controller.text),
                  price6: parseDoubleValue(price6Controller.text),
                  minSalePrice: parseDoubleValue(minSalePriceController.text),
                  maxSalePrice: parseDoubleValue(maxQuantityController.text),
                  minQty: parseDoubleValue(minQuantityController.text),
                  maxQty: parseDoubleValue(maxQuantityController.text),
                ));
                // Clear the controllers
                descriptionController.clear();
                shelfController.clear();
                costController.clear();
                rateController.clear();
                price1Controller.clear();
                price2Controller.clear();
                price3Controller.clear();
                price4Controller.clear();
                price5Controller.clear();
                price6Controller.clear();
                minSalePriceController.clear();
                maxSalePriceController.clear();
                minQuantityController.clear();
                maxQuantityController.clear();
                // Close the dialog
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(primary: GlobalColors.mainColor),
              child: Text('Save'),
            ),
          ],
          elevation: 0,
        );
      },
    );
    // If the dialog is closed with Save, rebuild the ListView
    if (result != null && result) {
      setState(() {});
    }
  }

  double parseDoubleValue(String text) {
    try {
      return double.parse(text);
    } catch (e) {
      return 0.0; // Default value or handle the error as per your requirement
    }
  }

  Future<void> _showBatchDialog() async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Batch Details"),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFieldWidget(
                      label: 'UOM Description',
                      controller: descriptionController,
                      icon: Icon(
                        Icons.code,
                        color: GlobalColors.mainColor,
                      ),
                      onChanged: (name) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                // Add the entered data to the uomList
                uomList.add(StockUOMDtoList(
                  uom: descriptionController.text,
                  shelf: shelfController.text,
                  cost: parseDoubleValue(costController.text),
                  rate: parseDoubleValue(rateController.text),
                  price: parseDoubleValue(price1Controller.text),
                  price2: parseDoubleValue(price2Controller.text),
                  price3: parseDoubleValue(price3Controller.text),
                  price4: parseDoubleValue(price4Controller.text),
                  price5: parseDoubleValue(price5Controller.text),
                  price6: parseDoubleValue(price6Controller.text),
                  minSalePrice: parseDoubleValue(minSalePriceController.text),
                  maxSalePrice: parseDoubleValue(maxQuantityController.text),
                  minQty: parseDoubleValue(minQuantityController.text),
                  maxQty: parseDoubleValue(maxQuantityController.text),
                ));
                // Clear the controllers
                descriptionController.clear();
                shelfController.clear();
                costController.clear();
                rateController.clear();
                price1Controller.clear();
                price2Controller.clear();
                price3Controller.clear();
                price4Controller.clear();
                price5Controller.clear();
                price6Controller.clear();
                minSalePriceController.clear();
                maxSalePriceController.clear();
                minQuantityController.clear();
                maxQuantityController.clear();
                // Close the dialog
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(primary: GlobalColors.mainColor),
              child: Text('Save'),
            ),
          ],
          elevation: 0,
        );
      },
    );
    // If the dialog is closed with Save, rebuild the ListView
    if (result != null && result) {
      setState(() {});
    }
  }
}
