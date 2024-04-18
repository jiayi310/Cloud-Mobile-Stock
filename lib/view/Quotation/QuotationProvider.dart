import 'package:flutter/material.dart';
import 'package:mobilestock/models/Quotation.dart';

class QuotationProviderData extends InheritedWidget {
  Quotation quotation;

  QuotationProviderData({
    required this.quotation,
    required Widget child,
  }) : super(child: child);

  static QuotationProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<QuotationProviderData>();
  }

  void updateTotalPrice(double totalPrice) {
    quotation.finalTotal = totalPrice;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true; // Always notify listeners when there's a change
  }

  void clearQuotation() {
    if (quotation.quotationDetails != null) {
      quotation.quotationDetails!.clear();
    }
  }

  void setQuotation(Quotation newQuotation) {
    quotation = newQuotation;
  }
}

class QuotationProvider extends StatefulWidget {
  final Widget child;
  final Quotation quotation;

  QuotationProvider({
    required this.quotation,
    required this.child,
  });

  static QuotationProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<QuotationProviderData>();
  }

  @override
  _QuotationProviderState createState() => _QuotationProviderState();
}

class _QuotationProviderState extends State<QuotationProvider>
    with ChangeNotifier {
  // Callback function to update the total price in CartBottomBar
  void updateTotalPrice(double totalPrice) {
    QuotationProviderData? quotationProviderData =
        QuotationProviderData.of(context);
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return QuotationProviderData(
      quotation: widget.quotation,
      child: widget.child,
    );
  }
}
