import 'package:flutter/material.dart';
import 'package:mobilestock/models/Collection.dart';

class CollectionProviderData extends InheritedWidget {
  final Collection collection;

  CollectionProviderData({
    required this.collection,
    required Widget child,
  }) : super(child: child);

  static CollectionProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CollectionProviderData>();
  }

  void updateTotalPrice(double totalPrice) {
    collection.paymentTotal = totalPrice;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true; // Always notify listeners when there's a change
  }
}

class CollectionProvider extends StatefulWidget {
  final Widget child;
  final Collection collection;

  CollectionProvider({
    required this.collection,
    required this.child,
  });

  static CollectionProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CollectionProviderData>();
  }

  @override
  _CollectionProviderState createState() => _CollectionProviderState();
}

class _CollectionProviderState extends State<CollectionProvider>
    with ChangeNotifier {
  // Callback function to update the total price in CartBottomBar
  void updateTotalPrice(double totalPrice) {
    CollectionProviderData? collectionProviderData =
        CollectionProviderData.of(context);
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return CollectionProviderData(
      collection: widget.collection,
      child: widget.child,
    );
  }
}
