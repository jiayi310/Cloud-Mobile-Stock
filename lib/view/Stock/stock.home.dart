import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Stock/stock.add.dart';

import '../../api/base.client.dart';
import '../../models/Stock.dart';
import '../../utils/loading.dart';
import 'StockDetails/details.view.dart';

class StockHomeScreen extends StatefulWidget {
  const StockHomeScreen({Key? key}) : super(key: key);

  @override
  State<StockHomeScreen> createState() => _StockHomeScreen();
}

class _StockHomeScreen extends State<StockHomeScreen> {
  bool _visible = false;
  List<Stock> productlist = [];
  List<Stock> productlist_search = [];
  String companyid = "";
  final storage = new FlutterSecureStorage();
  List<Stock> productFromJson(String str) =>
      List<Stock>.from(json.decode(str).map((x) => Stock.fromJson(x)));
  late final Future myfuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myfuture = getStockData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddStock(),
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Stock",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
                color: GlobalColors.mainColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Visibility(
              visible: _visible,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
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
            Column(
              children: [
                FutureBuilder(
                    future: myfuture,
                    builder: (context, snapshort) {
                      if (snapshort.hasData) {
                        return Column(
                          children: [
                            for (int i = 0; i < productlist.length; i++)
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StockDetails(
                                          id: productlist[i].stockID!,
                                        ),
                                      ));
                                },
                                child: Container(
                                  height: 110,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Text(
                                                  productlist[i]
                                                      .stockCode
                                                      .toString(),
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Text(
                                              productlist[i].baseUOM.toString(),
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 15,
                                                color: Colors.black
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Text(
                                                productlist[i]
                                                    .description
                                                    .toString(),
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: Text(
                                                productlist[i]
                                                        .stockGroupDescription ??
                                                    "",
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            (productlist[i].desc2 ?? "").isEmpty
                                                ? Flexible(
                                                    flex: 1,
                                                    child: Text(
                                                      "",
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                : Flexible(
                                                    flex: 1,
                                                    child: Text(
                                                      productlist[i]
                                                          .desc2
                                                          .toString(),
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(width: 20),
                                            Text(
                                              productlist[i].baseUOMPrice1 !=
                                                      null
                                                  ? productlist[i]
                                                      .baseUOMPrice1!
                                                      .toStringAsFixed(2)
                                                  : "0.00",
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        );
                      } else
                        return const LoadingPage();
                    }),
              ],
            ),
          ],
        )),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  Future<List<Stock>> getStockData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/Stock/GetStockListByCompanyId?companyid=' + companyid);
      List<Stock> _productlist = productFromJson(response);

      setState(() {
        productlist = _productlist;
        productlist_search = _productlist;
      });
    }

    return productlist;
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
      productlist = suggestions;
    });
  }
}
