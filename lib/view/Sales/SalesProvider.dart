import 'package:flutter/material.dart';

import '../../models/Sales.dart';

class SalesProviderData extends InheritedWidget {
  Sales sales;

  SalesProviderData({
    required this.sales,
    required Widget child,
  }) : super(child: child);

  static SalesProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SalesProviderData>();
  }

  void updateTotalPrice(double totalPrice) {
    sales.subtotal = totalPrice;
    sales.finalTotal = totalPrice;
  }

  void clearSales() {
    if (sales.salesDetails != null) {
      sales.salesDetails!.clear();
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true; // Always notify listeners when there's a change
  }

  void setSales(Sales newSales) {
    sales = newSales;
  }
}

class SalesProvider extends StatefulWidget {
  final Widget child;
  Sales sales;

  SalesProvider({
    required this.sales,
    required this.child,
  });

  static SalesProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SalesProviderData>();
  }

  @override
  _SalesProviderState createState() => _SalesProviderState();
}

class _SalesProviderState extends State<SalesProvider> with ChangeNotifier {
  // Callback function to update the total price in CartBottomBar
  void updateTotalPrice(double totalPrice) {
    SalesProviderData? salesProviderData = SalesProviderData.of(context);
    salesProviderData?.updateTotalPrice(totalPrice);
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return SalesProviderData(
      sales: widget.sales,
      child: widget.child,
    );
  }
}
