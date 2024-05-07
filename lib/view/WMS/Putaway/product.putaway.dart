import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/models/stock.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Collection/CollectionProvider.dart';
import 'package:mobilestock/view/Sales/SalesDetails/details.screen.dart';

import '../../../api/base.client.dart';

class PutAwayProductList extends StatefulWidget {
  PutAwayProductList({
    Key? key,
  }) : super(key: key);

  @override
  State<PutAwayProductList> createState() => _PutAwayProductListState();
}

class _PutAwayProductListState extends State<PutAwayProductList> {
  List<Stock> stock = [];
  String companyid = "";
  final storage = new FlutterSecureStorage();
  List<Stock> productFromJson(String str) =>
      List<Stock>.from(json.decode(str).map((x) => Stock.fromJson(x)));
  double totalSelected = 0.00;
  bool _visible = false;
  List<Stock> productlist_search = [];
  List<String> uom = [];

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
                        return StockItem(
                            stock[index].stockID!,
                            stock[index].image != null
                                ? base64.decode(stock[index].image!)
                                : Uint8List(0),
                            stock[index].stockCode.toString(),
                            stock[index].description.toString(),
                            stock[index].baseUOM.toString(),
                            stock[index].baseUOMPrice1!);
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
    int stockid,
    Uint8List stockImage,
    String stockCode,
    String description,
    String uom,
    double price,
  ) {
    return Column(
      children: [
        ListTile(
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
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(description),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select UOM'),
                            content: FutureBuilder<List<String>>(
                              future: getStockUOM(stockid),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  List<String> uomList = snapshot.data ?? [];
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (String uom in uomList)
                                          ListTile(
                                            title: Text(uom),
                                            onTap: () {
                                              _selectProductAndUOM(stockid,
                                                  stockCode, description, uom);
                                            },
                                          ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          GlobalColors.mainColor, // Set button background color
                    ),
                    child: Text(
                      'Select UOM',
                      style: TextStyle(
                        color: Colors.white, // Set button text color
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(), // Add a Divider below the ListTile
      ],
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

  Future<List<String>> getStockUOM(int stockid) async {
    final response =
        await BaseClient().get('/Stock/GetStock?stockId=' + stockid.toString());
    StockDetail _productlist = StockDetail.fromJson(jsonDecode(response));

    List<String> uom = [];

    for (var item in _productlist.stockUOMDtoList!) {
      if (item.uom != null && item.price != null) {
        uom.add(item.uom!);
      }
    }

    return uom;
  }

  void _selectProductAndUOM(
      int stockid, String stockCode, String description, String selectedUOM) {
    Navigator.pop(context, {
      'stockId': stockid,
      "description": description,
      'stockCode': stockCode,
      'selectedUOM': selectedUOM,
    });
    Navigator.pop(context, {
      'stockId': stockid,
      "description": description,
      'stockCode': stockCode,
      'selectedUOM': selectedUOM,
    });
  }
}
