import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobilestock/models/Stock.dart';

import '../../../api/base.client.dart';
import '../../../models/StockBalance.dart';

class StockDetails extends StatefulWidget {
  StockDetails({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  State<StockDetails> createState() => _StockDetails(id: id);
}

class _StockDetails extends State<StockDetails> with TickerProviderStateMixin {
  _StockDetails({required this.id});
  int id;
  Uint8List? bytes;
  String? uomSelected;
  List<StockBalance> stockbalancelist = [];
  List<StockBalance> stockBalanceFromJson(String str) =>
      List<StockBalance>.from(
          json.decode(str).map((x) => StockBalance.fromJson(x)));

  StockDetail productDetails = new StockDetail();
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(id);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.green,
        backgroundColor: Colors.green.withOpacity(0.1),
        elevation: 0,
        centerTitle: true,
        title: Text(
          productDetails.stockCode.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // Padding(
          //   padding: EdgeInsets.only(right: 20),
          //   child: InkWell(
          //     onTap: () {},
          //     child: Icon(
          //       Icons.edit,
          //       size: 25,
          //       color: Colors.green,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), // Show CircularProgressIndicator while loading
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Stack(children: [
                              if (productDetails.image != null &&
                                  productDetails.image.toString() != "")
                                ClipOval(
                                  child: Image.memory(
                                    bytes!,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              if (productDetails.image == null ||
                                  productDetails.image.toString() == "")
                                ClipOval(
                                  child: Image.asset(
                                    "assets/images/no-image.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              Positioned(
                                  bottom: 0,
                                  right: 4,
                                  child: buildEditIcon(Colors.blue)),
                            ]),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              productDetails.description ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildDropdown(),
                          ],
                        ),
                        //SizedBox(
                        //   width: 20,
                        // ),
                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.end,
                        //     children: [
                        //       Text(
                        //         productDetails.stockCode.toString(),
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.bold, fontSize: 16),
                        //       ),
                        //       Text(
                        //         productDetails.description.toString(),
                        //       ),
                        //       SizedBox(
                        //         height: 5,
                        //       ),
                        //       Text(
                        //         "Balance",
                        //         style: TextStyle(fontSize: 16),
                        //       ),
                        //       SizedBox(
                        //         height: 5,
                        //       ),
                        //       Text(
                        //         "UOM Balance",
                        //         style: TextStyle(fontSize: 16),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.green.withOpacity(0.1),
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.grey,
                      indicator:
                          CircleTabIndicator(color: Colors.green, radius: 4),
                      tabs: [
                        Tab(
                          text: "General",
                        ),
                        Tab(
                          text: "Stock",
                        ),
                        // Tab(
                        //   text: "Batch",
                        // ),
                        // Tab(
                        //   text: "History Price",
                        // )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 600,
                      width: double.maxFinite,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Table(
                                    columnWidths: {
                                      0: FlexColumnWidth(1),
                                      1: FlexColumnWidth(0.2),
                                      2: FlexColumnWidth(1)
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          _buildPriceCell(
                                              "Price 1",
                                              productDetails.stockUOMDtoList
                                                  ?.firstWhere((uomDto) =>
                                                      uomDto.uom == uomSelected)
                                                  ?.price),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _buildPriceCell(
                                              "Price 2",
                                              productDetails.stockUOMDtoList
                                                  ?.firstWhere((uomDto) =>
                                                      uomDto.uom == uomSelected)
                                                  ?.price2),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _buildPriceCell(
                                              "Price 3",
                                              productDetails.stockUOMDtoList
                                                  ?.firstWhere((uomDto) =>
                                                      uomDto.uom == uomSelected)
                                                  ?.price3),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _buildPriceCell(
                                              "Price 4",
                                              productDetails.stockUOMDtoList
                                                  ?.firstWhere((uomDto) =>
                                                      uomDto.uom == uomSelected)
                                                  ?.price4),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _buildPriceCell(
                                              "Price 5",
                                              productDetails.stockUOMDtoList
                                                  ?.firstWhere((uomDto) =>
                                                      uomDto.uom == uomSelected)
                                                  ?.price5),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _buildPriceCell(
                                              "Price 6",
                                              productDetails.stockUOMDtoList
                                                  ?.firstWhere((uomDto) =>
                                                      uomDto.uom == uomSelected)
                                                  ?.price6),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _buildPriceCell(
                                              "Min Price",
                                              productDetails.stockUOMDtoList
                                                  ?.firstWhere((uomDto) =>
                                                      uomDto.uom == uomSelected)
                                                  ?.minSalePrice),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _buildPriceCell(
                                              "Max Price",
                                              productDetails.stockUOMDtoList
                                                  ?.firstWhere((uomDto) =>
                                                      uomDto.uom == uomSelected)
                                                  ?.maxSalePrice),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _buildPriceCell(
                                              "Min Qty",
                                              productDetails.stockUOMDtoList
                                                  ?.firstWhere((uomDto) =>
                                                      uomDto.uom == uomSelected)
                                                  ?.minQty),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _buildPriceCell(
                                              "Max Qty",
                                              productDetails.stockUOMDtoList
                                                  ?.firstWhere((uomDto) =>
                                                      uomDto.uom == uomSelected)
                                                  ?.maxQty), // Empty cell to maintain alignment with other rows
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _buildPriceCell(
                                              "Cost",
                                              productDetails.stockUOMDtoList
                                                  ?.firstWhere((uomDto) =>
                                                      uomDto.uom == uomSelected)
                                                  ?.cost),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _buildPriceCell(
                                              "Rate",
                                              productDetails.stockUOMDtoList
                                                  ?.firstWhere((uomDto) =>
                                                      uomDto.uom == uomSelected)
                                                  ?.rate),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Info",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Description 2",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          productDetails.desc2.toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Group",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          productDetails.stockGroup?.description
                                                  .toString() ??
                                              "",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Type",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          productDetails.stockType?.description
                                                  .toString() ??
                                              "",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Category",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          productDetails
                                                  .stockCategory?.description
                                                  .toString() ??
                                              "",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Barcode",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          (() {
                                            var uom = uomSelected;
                                            var selectedUOM = productDetails
                                                .stockUOMDtoList
                                                ?.firstWhere(
                                              (uomDto) => uomDto.uom == uom,
                                            );

                                            String barcode =
                                                ""; // Default value

                                            if (selectedUOM != null &&
                                                selectedUOM
                                                        .stockBarcodeDtoList !=
                                                    null &&
                                                selectedUOM.stockBarcodeDtoList!
                                                    .isNotEmpty) {
                                              barcode = selectedUOM
                                                  .stockBarcodeDtoList!
                                                  .first
                                                  .barcode
                                                  .toString();
                                            }

                                            return barcode;
                                          })(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Shelf",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          (() {
                                            var uom = uomSelected;
                                            var selectedUOM = productDetails
                                                .stockUOMDtoList
                                                ?.firstWhere(
                                              (uomDto) => uomDto.uom == uom,
                                            );

                                            return selectedUOM != null
                                                ? selectedUOM.shelf
                                                        ?.toString() ??
                                                    ""
                                                : "";
                                          })(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     Expanded(
                                  //       flex: 1,
                                  //       child: Text(
                                  //         "Barcode",
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           fontSize: 14,
                                  //           color: Colors.black,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       flex: 2,
                                  //       child: Text(
                                  //         "102457894612233",
                                  //         style: TextStyle(
                                  //           fontSize: 14,
                                  //           color: Colors.black,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 300,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Location",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Batch No",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Balance",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height:
                                        400, // Set a fixed height or adjust as needed
                                    child: ListView.builder(
                                      itemCount: stockbalancelist.length,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          height:
                                              30, // Set the desired space between rows
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  stockbalancelist[index]
                                                      .location
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  stockbalancelist[index]
                                                          .batchNo ??
                                                      "",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  stockbalancelist[index]
                                                      .qty
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   height: 300,
                          //   margin:
                          //       EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          //   padding: EdgeInsets.all(5),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(20),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(20),
                          //     child: Column(
                          //       children: [],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> getData() async {
    if (id != null) {
      final response =
          await BaseClient().get('/Stock/GetStock?stockId=' + id.toString());

      StockDetail _productlist = StockDetail.fromJson(jsonDecode(response));

      //Product _productlist = productFromJson(response[0]);

      setState(() {
        productDetails = _productlist;
        bytes = Base64Decoder().convert(productDetails.image.toString());
        uomSelected = productDetails.baseUOM;
        _isLoading = false;
        getStockBalance();
      });
    }
  }

  Future<void> getStockBalance() async {
    if (id != null) {
      final response = await BaseClient().get(
          '/Stock/GetStockBalance?stockId=' +
              id.toString() +
              "&stockUom=" +
              uomSelected.toString());

      List<StockBalance> _stlist = stockBalanceFromJson(response);

      setState(() {
        stockbalancelist = _stlist;
      });
    }
  }

  Widget buildDropdown() {
    return DropdownButton<String>(
      value: uomSelected ?? productDetails.baseUOM,
      items: productDetails.stockUOMDtoList?.map((StockUOMDtoList uom) {
        return DropdownMenuItem<String>(
          value: uom.uom,
          child: Text(
            uom.uom.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          ),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          uomSelected = value;
        });
        getStockBalance();
      },
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            size: 15,
            color: Colors.white,
          ),
        ),
      );
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;

    final Offset circleOffset = offset +
        Offset(
            configuration.size!.width / 2, configuration.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        child: child,
        color: color,
        padding: EdgeInsets.all(all),
      ),
    );

Widget _buildPriceCell(String label, double? price) {
  return TableCell(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Text(
            price?.toStringAsFixed(2) ?? "0.00",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    ),
  );
}
