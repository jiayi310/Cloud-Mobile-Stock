import 'package:flutter/material.dart';
import 'package:mobilestock/models/Packing.dart';

class PackingProviderData extends InheritedWidget {
  Packing packing;

  PackingProviderData({
    required this.packing,
    required Widget child,
  }) : super(child: child);

  static PackingProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PackingProviderData>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true; // Always notify listeners when there's a change
  }

  void clearPacking() {
    if (packing.packingDetails != null) {
      packing.packingDetails!.clear();
    }
    packing = Packing();
  }

  void setPacking(Packing newPacking) {
    packing = newPacking;
  }

  void addPackingDetail(PackingDetails detail) {
    if (packing.packingDetails == null) {
      packing.packingDetails = [];
    }
    packing.packingDetails!.add(detail);
  }
}

class PackingProvider extends StatefulWidget {
  final Widget child;
  final Packing packing;

  PackingProvider({
    required this.packing,
    required this.child,
  });

  static PackingProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PackingProviderData>();
  }

  @override
  _PackingProviderState createState() => _PackingProviderState();
}

class _PackingProviderState extends State<PackingProvider> with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return PackingProviderData(
      packing: widget.packing,
      child: widget.child,
    );
  }
}
