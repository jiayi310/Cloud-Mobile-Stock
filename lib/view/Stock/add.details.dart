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
                      return _buildListItem(context, index);
                    },
                  ),
                ),
              ],
            ),
          ),
          // Content for Batch tab
          Center(
            child: Text('Batch Tab Content'),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    // Replace this with your actual data
    String uom = "UOM $index";
    String rate = "Rate $index";
    String shelf = "Shelf $index";
    String price1 = "Price 1 $index";

    return ListTile(
      title: DataTable(
        columns: [
          DataColumn(label: Text('UOM')),
          DataColumn(label: Text('Rate')),
          DataColumn(label: Text('Shelf')),
          DataColumn(label: Text('Price 1')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(uom)),
            DataCell(Text(rate)),
            DataCell(Text(shelf)),
            DataCell(Text(price1)),
          ]),
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
                  ],
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Add the entered data to the uomList
                uomList.add(StockUOMDtoList(
                  uom: descriptionController.text,
                  rate: double.parse(rateController.text),
                  shelf: shelfController.text,
                  price: double.parse(price1Controller.text),
                ));
                // Clear the controllers
                descriptionController.clear();
                shelfController.clear();
                costController.clear();
                rateController.clear();
                price1Controller.clear();
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
