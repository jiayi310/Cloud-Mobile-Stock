import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

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
          ],
        ),
      ),
    );
  }
}
