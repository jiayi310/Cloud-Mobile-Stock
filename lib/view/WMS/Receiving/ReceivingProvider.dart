import 'package:flutter/material.dart';
import 'package:mobilestock/models/Receiving.dart';

class ReceivingProviderData extends InheritedWidget {
  Receiving receiving;

  ReceivingProviderData({
    required this.receiving,
    required Widget child,
  }) : super(child: child);

  static ReceivingProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ReceivingProviderData>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true; // Always notify listeners when there's a change
  }

  void clearReceiving() {
    if (receiving.receivingDetails != null) {
      receiving.receivingDetails!.clear();
    }
  }

  void setReceiving(Receiving newReceiving) {
    receiving = newReceiving;
  }
}

class ReceivingProvider extends StatefulWidget {
  final Widget child;
  final Receiving receiving;

  ReceivingProvider({
    required this.receiving,
    required this.child,
  });

  static ReceivingProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ReceivingProviderData>();
  }

  @override
  _ReceivingProviderState createState() => _ReceivingProviderState();
}

class _ReceivingProviderState extends State<ReceivingProvider>
    with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return ReceivingProviderData(
      receiving: widget.receiving,
      child: widget.child,
    );
  }
}
