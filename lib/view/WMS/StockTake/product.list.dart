import 'dart:convert';
import 'dart:typed_data';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/models/Stock.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Collection/CollectionProvider.dart';
import 'package:mobilestock/view/Sales/SalesDetails/details.screen.dart';
import 'package:mobilestock/view/WMS/StockTake/uom.product.dart';

import '../../../api/base.client.dart';

class ProductList extends StatefulWidget {
  ProductList({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool _visible = false;
  List<Stock> stock = [];
  List<Stock> productlist_search = [];
  List<String> uom = [];
  String companyid = "";
  final storage = new FlutterSecureStorage();
  List<Stock> productFromJson(String str) =>
      List<Stock>.from(json.decode(str).map((x) => Stock.fromJson(x)));
  double totalSelected = 0.00;
  int _currentValue = 3;
  String? uomSelected, batchSelected;
  StockDetail productDetails = new StockDetail();
  @override
  void initState() {
    // TODO: implement initState
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Text("Product List"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                _toggle();
              },
              child: Icon(
                Icons.search,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Visibility(
                  visible: _visible,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: GlobalColors.mainColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            height: 50,
                            width: MediaQuery.of(context).size.width - 118,
                            child: TextFormField(
                              onChanged: searchQuery,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "Search"),
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 20),
                              child: Icon(Icons.camera_alt)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: stock.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StockTakeUOMList(
                                    stock: stock[index],
                                  ),
                                ));

                            // showDialog(
                            //   barrierDismissible: false,
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return StatefulBuilder(
                            //       builder: (context, setState) {
                            //         return FutureBuilder<bool>(
                            //           future: getData(stock[index].stockID!),
                            //           builder: (context, snapshot) {
                            //             if (snapshot.connectionState ==
                            //                 ConnectionState.waiting) {
                            //               // Return a loading indicator or placeholder widget
                            //               return Center(
                            //                 child:
                            //                     CircularProgressIndicator(), // Example loading indicator
                            //               );
                            //             } else if (snapshot.hasError) {
                            //               // Handle error state
                            //               return Text(
                            //                   'Error: ${snapshot.error}');
                            //             } else {
                            //               // Data loaded successfully, show the AlertDialog
                            //               return AlertDialog(
                            //                 title: Text(
                            //                   stock[index]
                            //                           .stockCode
                            //                           .toString() +
                            //                       " " +
                            //                       stock[index]
                            //                           .description
                            //                           .toString(),
                            //                 ),
                            //                 content: SingleChildScrollView(
                            //                   child: Column(
                            //                     mainAxisSize: MainAxisSize.min,
                            //                     children: <Widget>[
                            //                       Row(
                            //                         mainAxisAlignment:
                            //                             MainAxisAlignment
                            //                                 .spaceBetween,
                            //                         children: [
                            //                           Row(
                            //                             mainAxisAlignment:
                            //                                 MainAxisAlignment
                            //                                     .spaceBetween,
                            //                             children: [
                            //                               buildUOMDropdown(), // UOM dropdown
                            //                               buildBatchDropdown(), // Batch dropdown
                            //                             ],
                            //                           ),
                            //                           Row(
                            //                             mainAxisAlignment:
                            //                                 MainAxisAlignment
                            //                                     .center,
                            //                             children: [
                            //                               IconButton(
                            //                                 icon: Icon(
                            //                                     Icons.remove),
                            //                                 onPressed: () =>
                            //                                     setState(() {
                            //                                   _currentValue =
                            //                                       _currentValue -
                            //                                           1;
                            //                                 }),
                            //                               ),
                            //                               Text(
                            //                                   '$_currentValue'),
                            //                               IconButton(
                            //                                 icon:
                            //                                     Icon(Icons.add),
                            //                                 onPressed: () =>
                            //                                     setState(() {
                            //                                   _currentValue =
                            //                                       _currentValue +
                            //                                           1;
                            //                                 }),
                            //                               ),
                            //                             ],
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //                 actions: <Widget>[
                            //                   TextButton(
                            //                     onPressed: () {
                            //                       Navigator.of(context).pop();
                            //                     },
                            //                     child: Text("Close"),
                            //                   ),
                            //                   TextButton(
                            //                     onPressed: () {
                            //                       // Handle confirm action here
                            //                       Navigator.of(context).pop();
                            //                     },
                            //                     child: Text("Confirm"),
                            //                   ),
                            //                 ],
                            //               );
                            //             }
                            //           },
                            //         );
                            //       },
                            //     );
                            //   },
                            // );
                          },
                          child: StockItem(
                              stock[index].image != null
                                  ? base64.decode(stock[index].image!)
                                  : Uint8List(0),
                              stock[index].stockCode.toString(),
                              stock[index].description.toString(),
                              stock[index].baseUOM.toString(),
                              stock[index].baseUOMPrice1!),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget StockItem(
    Uint8List stockImage,
    String stockCode,
    String description,
    String uom,
    double price,
  ) {
    return ListTile(
      leading: stockImage != null && stockImage.isNotEmpty
          ? ClipOval(
              child: Image.memory(
                stockImage,
                width: 50,
                height: 50,
              ),
            )
          : ClipOval(
              child: Image.asset(
                "assets/images/no-image.png",
                width: 50,
                height: 50,
              ),
            ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            stockCode,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(uom),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(description),
            ],
          ),
        ],
      ),
    );
  }

  void getProductList() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      if (companyid != null) {
        String response = await BaseClient()
            .get('/Stock/GetStockListByCompanyId?companyid=' + companyid);
        List<Stock> _productlist = productFromJson(response);

        setState(() {
          stock = _productlist;
          productlist_search = _productlist;
        });
      }
    }
  }

  Future<bool> getData(int stockid) async {
    if (stockid != null) {
      final response = await BaseClient()
          .get('/Stock/GetStock?stockId=' + stockid.toString());

      StockDetail _productlist = StockDetail.fromJson(jsonDecode(response));

      setState(() {
        productDetails = _productlist;
        // uom = [];
        // for (var item in _productlist.stockUOMDtoList!) {
        //   if (item.uom != null && item.price != null) {
        //     uom.add(item.uom!);
        //   }
        // }
      });
    }
    return true;
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  void searchQuery(String query) {
    final suggestions = productlist_search.where((element) {
      final code = element.stockCode?.toString().toLowerCase() ?? "";
      final desc = element.description!.toString().toLowerCase() ?? "";
      final desc2 = element.desc2.toString().toLowerCase();
      final group = element.stockGroupDescription.toString().toLowerCase();
      final type = element.stockTypeDescription.toString().toLowerCase();
      final category =
          element.stockCategoryDescription.toString().toLowerCase();
      final input = query.toLowerCase();

      return code.contains(input) ||
          desc.contains(input) ||
          desc2.contains(input) ||
          group.toString().contains(input) ||
          type.toString().contains(input) ||
          category.toString().contains(input);
    }).toList();

    setState(() {
      stock = suggestions;
    });
  }
}
