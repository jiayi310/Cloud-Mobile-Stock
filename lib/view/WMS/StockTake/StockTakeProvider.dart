import 'package:flutter/material.dart';
import 'package:mobilestock/models/StockTake.dart';

import '../../../models/StockTake.dart';

class StockTakeProviderData extends InheritedWidget {
  StockTake stockTake;

  StockTakeProviderData({
    required this.stockTake,
    required Widget child,
  }) : super(child: child);

  static StockTakeProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StockTakeProviderData>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true; // Always notify listeners when there's a change
  }

  void clearStockTake() {
    if (stockTake.stockTakeDetails != null) {
      stockTake.stockTakeDetails!.clear();
    }
    stockTake = StockTake();
  }

  void setStockTake(StockTake newStockTake) {
    stockTake = newStockTake;
  }
}

class StockTakeProvider extends StatefulWidget {
  final Widget child;
  final StockTake stockTake;

  StockTakeProvider({
    required this.stockTake,
    required this.child,
  });

  static StockTakeProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StockTakeProviderData>();
  }

  @override
  _StockTakeProviderState createState() => _StockTakeProviderState();
}

class _StockTakeProviderState extends State<StockTakeProvider>
    with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return StockTakeProviderData(
      stockTake: widget.stockTake,
      child: widget.child,
    );
  }
}
