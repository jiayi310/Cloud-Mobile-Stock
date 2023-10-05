import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../api/base.client.dart';
import '../../models/Product.dart';
import 'StockDetails/details.view.dart';

class StockCard extends StatefulWidget {
  const StockCard({Key? key}) : super(key: key);

  @override
  State<StockCard> createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> {
  _StockCardState({Key? key});

  List<Product> productlist = [];
  String companyid = "";
  final storage = new FlutterSecureStorage();
  List<Product> productFromJson(String str) =>
      List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStockData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < productlist.length; i++)
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StockDetails(
                      product: productlist[i].title!,
                    ),
                  ));
            },
            child: Container(
              height: 110,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              productlist[i].stockCode.toString(),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
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
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            productlist[i].description.toString(),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            "31.0",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "RM" + productlist[i].price.toString(),
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
  }

  Future<void> getStockData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient().get(
          '/Stock/GetStockListWithForeignTablesByCompanyId?companyid=' +
              companyid);
      List<Product> _productlist = productFromJson(response);

      setState(() {
        productlist = _productlist;
      });
    }
  }
}
