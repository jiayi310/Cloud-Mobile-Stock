import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobilestock/view/Sales/section.title.dart';
import 'package:mobilestock/api/base.client.dart';
import 'package:mobilestock/models/Stock.dart';
import 'package:mobilestock/view/Sales/product.card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../models/Sales.dart';
import '../../size.config.dart';
import 'SalesDetails/details.screen.dart';

class ItemsGridWidget extends StatefulWidget {
  final String searchQuery;

  const ItemsGridWidget({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  _ItemsGridWidgetState createState() => _ItemsGridWidgetState();
}

class _ItemsGridWidgetState extends State<ItemsGridWidget> {
  List<Stock> productlist = [];
  String companyid = "";
  final storage = new FlutterSecureStorage();
  Sales new_sales = new Sales();

  @override
  void initState() {
    super.initState();
    myfuture = getStockData();
  }

  late final Future<List<Stock>> myfuture;

  List<Stock> productFromJson(String str) =>
      List<Stock>.from(json.decode(str).map((x) => Stock.fromJson(x)));

  List<Stock> filterProductsBySearch(List<Stock> products, String query) {
    if (query.isEmpty) {
      return products;
    }

    return products.where((product) {
      // Customize your filtering logic based on your data model
      return product.stockCode!.toLowerCase().contains(query.toLowerCase()) ||
          product.description!.toLowerCase().contains(query.toLowerCase()) ||
          product.baseUOM!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

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
              final filteredProducts =
                  filterProductsBySearch(snapshot.data!, widget.searchQuery);

              return StaggeredGrid.count(
                crossAxisCount:
                    MediaQuery.of(context).size.shortestSide < 600 ? 2 : 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: filteredProducts.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stock = entry.value;

                  return ProductCard(
                    stockcode: stock.stockCode.toString(),
                    title: stock.description.toString(),
                    uom: stock.baseUOM.toString(),
                    image: Base64Decoder().convert(stock.image.toString()),
                    price: stock.baseUOMPrice1 ?? 0.00,
                    bgColor: Color(0xfff),
                    sales: new_sales,
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
