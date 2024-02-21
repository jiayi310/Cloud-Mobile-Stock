import 'dart:typed_data';

import 'package:collection/collection.dart';

class Sales {
  String? docNo;
  String? docDate;
  String? customerCode;
  String? customerName;
  String? salesAgent;
  double? finalTotal;
  String? remark;
  List<SalesItem> items = []; // Assume Sales has a list of items

  Sales();

  Sales.fromJson(Map<String, dynamic> json) {
    docNo = json["docNo"];
    docDate = json["docDate"];
    customerCode = json["customerCode"];
    customerName = json["customerName"];
    salesAgent = json["salesAgent"];
    finalTotal = json["finalTotal"];
    remark = json["remark"];
  }

  void addItem({
    required String stockCode,
    required String description,
    required String uom,
    required int quantity,
    required double price,
    required Uint8List image,
  }) {
    // Check if an item with the same code already exists in the list
    var existingItem =
        items.firstWhereOrNull((item) => item.stockCode == stockCode);

    if (existingItem != null) {
      // If the item exists, update its quantity
      existingItem.quantity += 1;
    } else {
      // If the item doesn't exist, add a new item to the list
      items.add(SalesItem(
        stockCode: stockCode,
        description: description,
        uom: uom ?? "",
        quantity: quantity,
        price: price,
        image: image,
      ));
    }
  }
}

class SalesItem {
  String stockCode;
  String description;
  String uom;
  int quantity;
  double price;
  Uint8List? image;

  SalesItem({
    required this.stockCode,
    required this.description,
    required this.uom,
    required this.quantity,
    required this.price,
    this.image,
  });
}
