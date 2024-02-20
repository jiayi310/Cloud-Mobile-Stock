import 'package:flutter/material.dart';
import 'package:mobilestock/view/Sales/item.list.dart';
import 'package:mobilestock/view/Sales/item.list.featured.dart';
import 'package:mobilestock/view/Sales/sales.header.dart';
import 'package:mobilestock/view/Sales/search.sales.dart';

class HomeSalesScreen extends StatefulWidget {
  HomeSalesScreen({Key? key}) : super(key: key);

  @override
  _HomeSalesScreenState createState() => _HomeSalesScreenState();
}

class _HomeSalesScreenState extends State<HomeSalesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
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
                    SalesAppBar(),
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
                    ItemsGridWidget(searchQuery: _searchQuery),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
