import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

import '../../models/Stock.dart';

class SalesFilters extends StatefulWidget {
  const SalesFilters({Key? key}) : super(key: key);

  @override
  State<SalesFilters> createState() => _SalesFiltersState();
}

class _SalesFiltersState extends State<SalesFilters> {
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
            CustomCategoryFilter()
          ],
        ),
      ),
    );
  }
}

class CustomCategoryFilter extends StatefulWidget {
  const CustomCategoryFilter({Key? key}) : super(key: key);

  @override
  State<CustomCategoryFilter> createState() => _CustomCategoryFilterState();
}

class _CustomCategoryFilterState extends State<CustomCategoryFilter> {
  Set<String> uniqueCategories = Set();

  @override
  void initState() {
    super.initState();
    // Populate uniqueCategories set with distinct categories
    demo_product.forEach((stock) {
      uniqueCategories.add(stock.stockGroupDescription.toString());
    });
  }

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
                  value: false, // Set your checkbox value based on your logic
                  onChanged: (bool? newValue) {
                    setState(() {});
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
  const CustomPriceFilter({
    Key? key,
    required this.stock,
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
          },
        ),
        SizedBox(height: 10),
        Text(
            'Price Range: RM${_priceRange.start.toStringAsFixed(2)} - RM${_priceRange.end.toStringAsFixed(2)}'),
      ],
    );
  }
}
