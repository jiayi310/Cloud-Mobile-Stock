import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

import '../../models/Stock.dart';

class SalesFilters extends StatefulWidget {
  final RangeValues initialPriceRange;
  final Function(RangeValues, Set<String>, List<Stock>) onApplyFilters;
  final List<Stock> productlist;

  const SalesFilters({
    Key? key,
    required this.initialPriceRange,
    required this.productlist,
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  State<SalesFilters> createState() => _SalesFiltersState();
}

class _SalesFiltersState extends State<SalesFilters> {
  RangeValues _priceRange = RangeValues(0, 100);
  Set<String> selectedCategories = Set();
  List<Stock> filteredProducts = [];
  Set<String> allCategories = Set();
  Set<String> allType = Set();
  Set<String> allGroup = Set();

  @override
  void initState() {
    super.initState();
    _priceRange = widget.initialPriceRange;
    filteredProducts = applyFilters(_priceRange, selectedCategories);

    // Calculate unique categories from the product list
    allCategories = widget.productlist
        .map((stock) => stock.stockCategoryDescription ?? "")
        .toSet();

    // Remove empty categories if necessary
    allCategories.removeWhere((category) => category.isEmpty);

    allType = widget.productlist
        .map((stock) => stock.stockTypeDescription ?? "")
        .toSet();

    allType.removeWhere((type) => type.isEmpty);

    allGroup = widget.productlist
        .map((stock) => stock.stockGroupDescription ?? "")
        .toSet();

    allGroup.removeWhere((group) => group.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        backgroundColor: GlobalColors.mainColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price',
              style: TextStyle(color: GlobalColors.mainColor),
            ),
            CustomPriceFilter(
              stock: demo_product,
              onPriceChanged: (values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
            Text(
              'Group',
              style: TextStyle(color: GlobalColors.mainColor),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: allGroup.length,
              itemBuilder: (context, index) {
                String category = allGroup.elementAt(index);
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25,
                        child: Checkbox(
                          value: selectedCategories.contains(category),
                          onChanged: (bool? newValue) {
                            setState(() {
                              if (newValue != null) {
                                if (newValue) {
                                  selectedCategories.add(category);
                                } else {
                                  selectedCategories.remove(category);
                                }
                              }
                            });
                          },
                          activeColor: GlobalColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Text(
              'Type',
              style: TextStyle(color: GlobalColors.mainColor),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: allType.length,
              itemBuilder: (context, index) {
                String category = allType.elementAt(index);
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25,
                        child: Checkbox(
                          value: selectedCategories.contains(category),
                          onChanged: (bool? newValue) {
                            setState(() {
                              if (newValue != null) {
                                if (newValue) {
                                  selectedCategories.add(category);
                                } else {
                                  selectedCategories.remove(category);
                                }
                              }
                            });
                          },
                          activeColor: GlobalColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Text(
              'Categories',
              style: TextStyle(color: GlobalColors.mainColor),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: allCategories.length,
              itemBuilder: (context, index) {
                String category = allCategories.elementAt(index);
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25,
                        child: Checkbox(
                          value: selectedCategories.contains(category),
                          onChanged: (bool? newValue) {
                            setState(() {
                              if (newValue != null) {
                                if (newValue) {
                                  selectedCategories.add(category);
                                } else {
                                  selectedCategories.remove(category);
                                }
                              }
                            });
                          },
                          activeColor: GlobalColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      filteredProducts =
                          applyFilters(_priceRange, selectedCategories);
                      widget.onApplyFilters(
                        _priceRange,
                        selectedCategories,
                        filteredProducts,
                      );
                      Navigator.pop(
                          context, filteredProducts); // Close the filter screen
                    },
                    style: ElevatedButton.styleFrom(
                        primary: GlobalColors
                            .mainColor // Change this color to your desired color
                        ),
                    child: Text('Apply Filters'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Stock> applyFilters(RangeValues priceRange, Set<String> categories) {
    // Apply your filters and return the filtered product list
    // You can use the selected filters to filter the 'demo_product' list
    // For example, filter by price and category
    List<Stock> filteredProducts = widget.productlist
        .where((stock) =>
            stock.baseUOMPrice1! >= priceRange.start &&
            stock.baseUOMPrice1! <= priceRange.end)
        .toList();

    return filteredProducts;
  }
}

class CustomPriceFilter extends StatefulWidget {
  final List<Stock> stock;
  final Function(RangeValues) onPriceChanged;

  const CustomPriceFilter({
    Key? key,
    required this.stock,
    required this.onPriceChanged,
  }) : super(key: key);

  @override
  State<CustomPriceFilter> createState() =>
      _CustomPriceFilterState(stock: stock);
}

class _CustomPriceFilterState extends State<CustomPriceFilter> {
  final List<Stock> stock;
  RangeValues _priceRange = RangeValues(0, 100); // Set initial range values

  _CustomPriceFilterState({
    Key? key,
    required this.stock,
  });

  RangeValues get priceRange => _priceRange; // Add this getter

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 100,
          onChanged: (RangeValues values) {
            setState(() {
              _priceRange = values;
            });
            widget.onPriceChanged(
                _priceRange); // Notify the parent about the change
          },
          activeColor: GlobalColors.mainColor,
        ),
        SizedBox(height: 10),
        Text(
            'Price Range: RM${_priceRange.start.toStringAsFixed(2)} - RM${_priceRange.end.toStringAsFixed(2)}'),
      ],
    );
  }
}
