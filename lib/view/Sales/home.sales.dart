import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mobilestock/view/Sales/product.card.dart';
import 'package:mobilestock/view/Sales/sales.filter.dart';
import 'package:mobilestock/view/Sales/search.sales.dart';
import 'package:mobilestock/view/Sales/section.title.dart';

import '../../api/base.client.dart';
import '../../models/Sales.dart';
import '../../models/Stock.dart';
import '../../size.config.dart';
import '../../utils/global.colors.dart';
import 'Cart/cart.view.dart';
import 'OrderHistory/history.view.dart';
import 'SalesDetails/details.screen.dart';
import 'SalesProvider.dart';

class HomeSalesScreen extends StatefulWidget {
  HomeSalesScreen({Key? key, required this.isEdit, required this.sales})
      : super(key: key);
  bool isEdit;
  Sales sales;

  @override
  _HomeSalesScreenState createState() => _HomeSalesScreenState();
}

class _HomeSalesScreenState extends State<HomeSalesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  int numOfitem = 0;
  List<Stock> productlist = [];
  String companyid = "";
  final storage = new FlutterSecureStorage();
  Sales new_sales = new Sales();
  RangeValues _priceRange = RangeValues(0, 100);
  List<Stock> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    myfuture = getStockData();
  }

  late final Future<List<Stock>> myfuture;

  List<Stock> productFromJson(String str) =>
      List<Stock>.from(json.decode(str).map((x) => Stock.fromJson(x)));

  List<Stock> filterProductsBySearch(List<Stock> products, String query) {
    if (query.isEmpty && filteredProducts.isEmpty) {
      return products;
    } else {
      return filteredProducts.where((product) {
        return (product.stockCode != null &&
                product.stockCode!
                    .toLowerCase()
                    .contains(query.toLowerCase())) ||
            (product.description != null &&
                product.description!
                    .toLowerCase()
                    .contains(query.toLowerCase())) ||
            (product.baseUOM != null &&
                product.baseUOM!.toLowerCase().contains(query.toLowerCase()));
      }).toList();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final salesProvider = SalesProvider.of(context);
    numOfitem = salesProvider!.sales.salesDetails.length;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      final salesProvider = SalesProvider.of(context);
      if (salesProvider != null) {
        salesProvider.setSales(widget.sales);
        numOfitem = salesProvider!.sales.salesDetails!.length;
      }
    }
    widget.sales = SalesProvider.of(context)!.sales;

    RangeValues _priceRange = RangeValues(0, 100);
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 30,
                                  color: GlobalColors.mainColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Sales',
                                  style: TextStyle(
                                    fontSize: GlobalSize.headerSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderHistoryScreen()),
                            );
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.history,
                                  color: GlobalColors.mainColor,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      GlobalColors.mainColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final result =
                                await Get.to<List<Stock>>(() => SalesFilters(
                                      initialPriceRange: _priceRange,
                                      productlist: productlist,
                                      onApplyFilters: (priceRange,
                                          groups,
                                          types,
                                          categories,
                                          filteredProducts) {},
                                    ));

                            if (result != null) {
                              setState(() {
                                filteredProducts = result;
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.filter_list_alt,
                                  color: GlobalColors.mainColor,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      GlobalColors.mainColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartList()),
                            );
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: GlobalColors.mainColor,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      GlobalColors.mainColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              if (numOfitem != 0)
                                Positioned(
                                  top: -3,
                                  right: 0,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF4848),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.5, color: Colors.white),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "$numOfitem",
                                        style: TextStyle(
                                          fontSize: 10,
                                          height: 1,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SearchWidget(
                      searchController: _searchController,
                      onSearchChanged: (query) {
                        setState(() {
                          _searchQuery = query;
                        });
                      },
                    ),
                    Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: defaultPadding),
                          child: SectionTitle(
                            title: "Popular",
                            pressSeeAll: () {},
                          ),
                        ),
                        FutureBuilder<List<Stock>>(
                          future: myfuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Text('No products available.');
                            } else {
                              filteredProducts = filterProductsBySearch(
                                  snapshot.data!, _searchQuery);

                              if (filteredProducts.isEmpty) {
                                return Text('No matching products found.');
                              }

                              return StaggeredGrid.count(
                                crossAxisCount:
                                    MediaQuery.of(context).size.shortestSide <
                                            600
                                        ? 2
                                        : 4,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                children: filteredProducts
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final index = entry.key;
                                  final stock = entry.value;

                                  return ProductCard(
                                    stockid: stock.stockID!,
                                    stockcode: stock.stockCode.toString(),
                                    title: stock.description.toString(),
                                    uom: stock.baseUOM.toString(),
                                    image: Base64Decoder()
                                        .convert(stock.image.toString()),
                                    price: stock.baseUOMPrice1 ?? 0.00,
                                    bgColor: Color(0xfff),
                                    sales: new_sales,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                              stockid: stock.stockID!),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Stock>> getStockData() async {
    try {
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
    } catch (error) {
      print('Error fetching data: $error');
      throw error; // Rethrow the error to be caught by the FutureBuilder
    }
  }
}
