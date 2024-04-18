import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/models/stock.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Collection/CollectionProvider.dart';
import 'package:mobilestock/view/Sales/SalesDetails/details.screen.dart';

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
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Text("Product List"),
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    stockid: stock[index].stockID!,
                                    source: "Quotation"),
                              ));
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

  void getProductList() async {
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
