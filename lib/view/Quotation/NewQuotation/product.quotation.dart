import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/models/stock.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Collection/CollectionProvider.dart';

import '../../../api/base.client.dart';

class QuotationProductList extends StatefulWidget {
  QuotationProductList({
    Key? key,
  }) : super(key: key);

  @override
  State<QuotationProductList> createState() => _QuotationProductListState();
}

class _QuotationProductListState extends State<QuotationProductList> {
  List<Stock> stock = [];
  String companyid = "";
  final storage = new FlutterSecureStorage();
  List<Stock> productFromJson(String str) =>
      List<Stock>.from(json.decode(str).map((x) => Stock.fromJson(x)));
  double totalSelected = 0.00;

  @override
  void initState() {
    // TODO: implement initState
    getCollectionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Text("Collection List"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: stock.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StockItem(
                          stock[index].stockCode.toString(),
                          stock[index].description.toString(),
                          stock[index].baseUOM.toString(),
                          stock[index].baseUOMPrice1!);
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: ',
                          style: TextStyle(
                              fontSize: 22,
                              color: GlobalColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          totalSelected.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 22,
                              color: GlobalColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            print("CONFIRMED");
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                GlobalColors.mainColor, // Change the color here
                          ),
                          child: Text("Confirm"),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget StockItem(
    String stockCode,
    String description,
    String uom,
    double price,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: GlobalColors.mainColor,
        child: Icon(
          Icons.book_rounded,
          color: Colors.white,
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
              Text(
                price.toString(),
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getCollectionList() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      if (companyid != null) {
        String response = await BaseClient()
            .get('/Stock/GetStockListByCompanyId?companyid=' + companyid);
        List<Stock> _productlist = productFromJson(response);

        setState(() {
          stock = _productlist;
        });
      }
    }
  }
}
