import 'package:flutter/material.dart';
import 'package:mobilestock/models/Picking.dart';

class PickingProviderData extends InheritedWidget {
  Picking picking;

  PickingProviderData({
    required this.picking,
    required Widget child,
  }) : super(child: child);

  static PickingProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PickingProviderData>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true; // Always notify listeners when there's a change
  }

  void clearPicking() {
    if (picking.pickingDetails != null) {
      picking.pickingDetails!.clear();
    }
  }

  void setPicking(Picking newPicking) {
    picking = newPicking;
  }
}

class PickingProvider extends StatefulWidget {
  final Widget child;
  final Picking picking;

  PickingProvider({
    required this.picking,
    required this.child,
  });

  static PickingProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PickingProviderData>();
  }

  @override
  _PickingProviderState createState() => _PickingProviderState();
}

class _PickingProviderState extends State<PickingProvider> with ChangeNotifier {
  // Callback function to update the total price in CartBottomBar
  void updateTotalPrice(double totalPrice) {
    PickingProviderData? pickingProviderData = PickingProviderData.of(context);
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return PickingProviderData(
      picking: widget.picking,
      child: widget.child,
    );
  }
}
