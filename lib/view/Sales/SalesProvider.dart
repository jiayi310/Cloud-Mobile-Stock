import 'package:flutter/material.dart';

import '../../models/Sales.dart';

class SalesProvider extends InheritedWidget {
  final Sales sales;
  final Widget child;

  SalesProvider({
    required this.sales,
    required this.child,
  }) : super(child: child);

  static SalesProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SalesProvider>();
  }

  @override
  bool updateShouldNotify(covariant SalesProvider oldWidget) {
    return sales != oldWidget.sales;
  }
}
