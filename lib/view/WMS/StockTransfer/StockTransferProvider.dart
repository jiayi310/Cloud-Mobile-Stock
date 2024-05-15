import 'package:flutter/material.dart';
import 'package:mobilestock/models/StockTransfer.dart';

import '../../../models/StockTransfer.dart';

class StockTransferProviderData extends InheritedWidget {
  StockTransfer stockTransfer;

  StockTransferProviderData({
    required this.stockTransfer,
    required Widget child,
  }) : super(child: child);

  static StockTransferProviderData? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StockTransferProviderData>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true; // Always notify listeners when there's a change
  }

  void clearStockTransfer() {
    if (stockTransfer.stockTransferDetails != null) {
      stockTransfer.stockTransferDetails!.clear();
    }
    stockTransfer = StockTransfer();
  }

  void setStockTransfer(StockTransfer newStockTransfer) {
    stockTransfer = newStockTransfer;
  }

  void addstockTransferDetail(StockTransferDetails detail) {
    if (stockTransfer.stockTransferDetails == null) {
      stockTransfer.stockTransferDetails = [];
    }
    stockTransfer.stockTransferDetails!.add(detail);
  }
}

class StockTransferProvider extends StatefulWidget {
  final Widget child;
  final StockTransfer stockTransfer;

  StockTransferProvider({
    required this.stockTransfer,
    required this.child,
  });

  static StockTransferProviderData? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StockTransferProviderData>();
  }

  @override
  _StockTransferProviderState createState() => _StockTransferProviderState();
}

class _StockTransferProviderState extends State<StockTransferProvider>
    with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return StockTransferProviderData(
      stockTransfer: widget.stockTransfer,
      child: widget.child,
    );
  }
}
