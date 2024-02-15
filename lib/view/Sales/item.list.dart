import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobilestock/view/Sales/section.title.dart';
import 'package:mobilestock/api/base.client.dart';
import 'package:mobilestock/models/Stock.dart';
import 'package:mobilestock/view/Sales/product.card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../size.config.dart';
import 'SalesDetails/details.screen.dart';

class ItemsGridWidget extends StatefulWidget {
  const ItemsGridWidget({Key? key}) : super(key: key);

  @override
  _ItemsGridWidgetState createState() => _ItemsGridWidgetState();
}

class _ItemsGridWidgetState extends State<ItemsGridWidget> {
  List<Stock> productlist = [];
  String companyid = "";
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    myfuture = getStockData();
  }

  late final Future<List<Stock>> myfuture;

  List<Stock> productFromJson(String str) =>
      List<Stock>.from(json.decode(str).map((x) => Stock.fromJson(x)));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: SectionTitle(
            title: "Popular",
            pressSeeAll: () {},
          ),
        ),
        FutureBuilder<List<Stock>>(
          future: myfuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No data available.');
            } else {
              return StaggeredGrid.count(
                crossAxisCount:
                    MediaQuery.of(context).size.shortestSide < 600 ? 2 : 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: snapshot.data!.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stock = entry.value;

                  return ProductCard(
                    stockcode: stock.stockCode.toString(),
                    title: stock.description.toString(),
                    uom: stock.baseUOM.toString(),
                    image: Base64Decoder().convert(stock.image.toString()),
                    price: stock.baseUOMPrice1 ?? 0.00,
                    bgColor: Color(0xfff),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsScreen(stockid: stock.stockID!),
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            }
          },
        ),
      ],
    );
  }

  Future<List<Stock>> getStockData() async {
    companyid = (await storage.read(key: "companyid"))!;
    if (companyid != null) {
      String response = await BaseClient()
          .get('/Stock/GetStockListByCompanyId?companyid=' + companyid);
      List<Stock> _productlist = productFromJson(response);

      setState(() {
        productlist = _productlist;
      });
    }

    return productlist;
  }
}
