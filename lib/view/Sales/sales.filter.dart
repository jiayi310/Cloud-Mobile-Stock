import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

import '../../models/Stock.dart';

class SalesFilters extends StatefulWidget {
  // Function(List<Stock> filteredProducts) onApplyFilters;
  // List<Stock> products; // Add this

  const SalesFilters({Key? key}) : super(key: key);

  @override
  State<SalesFilters> createState() => _SalesFiltersState();
}

class _SalesFiltersState extends State<SalesFilters> {
  RangeValues _priceRange = RangeValues(0, 100);
  Set<String> selectedCategories = Set();

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
            Text(
              'Type',
              style: TextStyle(color: GlobalColors.mainColor),
            ),
            Text(
              'Categories',
              style: TextStyle(color: GlobalColors.mainColor),
            ),
            CustomCategoryFilter(
              onCategoriesChanged: (categories) {
                setState(() {
                  selectedCategories = categories;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Get selected filters and apply them to the product list
                List<Stock> filteredProducts =
                    applyFilters(_priceRange, selectedCategories);
                // Pass the filtered products to the callback
                //   widget.onApplyFilters(filteredProducts);
                // Close the filter screen or perform other actions as needed
              },
              child: Text('Apply Filters'),
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
    List<Stock> filteredProducts = demo_product
        .where((stock) =>
            stock.baseUOMPrice1! >= priceRange.start &&
            stock.baseUOMPrice1! <= priceRange.end &&
            categories.contains(stock.stockGroupDescription))
        .toList();

    return filteredProducts;
  }
}

class CustomCategoryFilter extends StatefulWidget {
  final Function(Set<String> categories) onCategoriesChanged;

  const CustomCategoryFilter({Key? key, required this.onCategoriesChanged})
      : super(key: key);

  @override
  State<CustomCategoryFilter> createState() => _CustomCategoryFilterState();
}

class _CustomCategoryFilterState extends State<CustomCategoryFilter> {
  Set<String> selectedCategories = Set();
  Set<String> uniqueCategories = Set();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: uniqueCategories.length,
      itemBuilder: (context, index) {
        String category = uniqueCategories.elementAt(index);
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                        widget.onCategoriesChanged(selectedCategories);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
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
        ),
        SizedBox(height: 10),
        Text(
            'Price Range: RM${_priceRange.start.toStringAsFixed(2)} - RM${_priceRange.end.toStringAsFixed(2)}'),
      ],
    );
  }
}
