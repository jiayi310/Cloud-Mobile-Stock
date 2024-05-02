import 'package:flutter/material.dart';
import 'package:mobilestock/models/PutAway.dart';

class PutAwayProviderData extends InheritedWidget {
  PutAway putAway;

  PutAwayProviderData({
    required this.putAway,
    required Widget child,
  }) : super(child: child);

  static PutAwayProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PutAwayProviderData>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true; // Always notify listeners when there's a change
  }

  void clearPutAway() {
    if (putAway != null) {
      putAway = new PutAway();
    }
  }

  void setPutAway(PutAway newPutAway) {
    putAway = newPutAway;
  }
}

class PutAwayProvider extends StatefulWidget {
  final Widget child;
  final PutAway putAway;

  PutAwayProvider({
    required this.putAway,
    required this.child,
  });

  static PutAwayProviderData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PutAwayProviderData>();
  }

  @override
  _PutAwayProviderState createState() => _PutAwayProviderState();
}

class _PutAwayProviderState extends State<PutAwayProvider> with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return PutAwayProviderData(
      putAway: widget.putAway,
      child: widget.child,
    );
  }
}
