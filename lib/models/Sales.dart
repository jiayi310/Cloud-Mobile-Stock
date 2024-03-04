import 'dart:typed_data';

import 'package:collection/collection.dart';

class Sales {
  int? docID;
  String? docNo;
  DateTime? docDate;
  int? customerID;
  String? customerCode;
  String? customerName;
  String? address1;
  String? address2;
  String? address3;
  String? address4;
  String? deliverAddr1;
  String? deliverAddr2;
  String? deliverAddr3;
  String? deliverAddr4;
  String? salesAgent;
  String? phone;
  String? fax;
  String? email;
  String? attention;
  double? subtotal;
  double? taxableAmt;
  double? taxAmt;
  double? finalTotal;
  double? paymentTotal;
  double? outstanding;
  String? description;
  String? remark;
  int? shippingMethodID;
  int? qTDocID;
  String? qTDocNo;
  bool? isVoid;
  int? lastModifiedUserID;
  DateTime? lastModifiedDateTime;
  int? createdUserID;
  DateTime? createdDateTime;
  int? companyID;
  List<SalesItem> items = [];

  Sales();

  Sales.fromJson(Map<String, dynamic> json) {
    docID = json["docID"];
    docNo = json["docNo"];
    docDate = json["docDate"] != null ? DateTime.parse(json["docDate"]) : null;
    customerID = json["customerID"];
    customerCode = json["customerCode"];
    customerName = json["customerName"];
    address1 = json["address1"];
    address2 = json["address2"];
    address3 = json["address3"];
    address4 = json["address4"];
    deliverAddr1 = json["deliverAddr1"];
    deliverAddr2 = json["deliverAddr2"];
    deliverAddr3 = json["deliverAddr3"];
    deliverAddr4 = json["deliverAddr4"];
    salesAgent = json["salesAgent"];
    phone = json["phone"];
    fax = json["fax"];
    email = json["email"];
    attention = json["attention"];
    subtotal = json["subtotal"]?.toDouble();
    taxableAmt = json["taxableAmt"]?.toDouble();
    taxAmt = json["taxAmt"]?.toDouble();
    finalTotal = json["finalTotal"]?.toDouble();
    paymentTotal = json["paymentTotal"]?.toDouble();
    outstanding = json["outstanding"]?.toDouble();
    description = json["description"];
    remark = json["remark"];
    shippingMethodID = json["shippingMethodID"];
    qTDocID = json["qTDocID"];
    qTDocNo = json["qTDocNo"];
    isVoid = json["isVoid"];
    lastModifiedUserID = json["lastModifiedUserID"];
    lastModifiedDateTime = json["lastModifiedDateTime"] != null
        ? DateTime.parse(json["lastModifiedDateTime"])
        : null;
    createdUserID = json["createdUserID"];
    createdDateTime = json["createdDateTime"] != null
        ? DateTime.parse(json["createdDateTime"])
        : null;
    companyID = json["companyID"];
  }

  void addItem({
    required String stockCode,
    required String description,
    required String uom,
    required int quantity,
    required double price,
    required double discount,
    required double total,
    required double taxAmt,
    required double taxableAmount,
    required double taxrate,
    required Uint8List image,
  }) {
    // Check if an item with the same code already exists in the list
    var existingItem =
        items.firstWhereOrNull((item) => item.stockCode == stockCode);

    if (existingItem != null) {
      // If the item exists, update its quantity
      existingItem.quantity += quantity;
    } else {
      // If the item doesn't exist, add a new item to the list
      items.add(SalesItem(
        stockCode: stockCode,
        description: description,
        uom: uom ?? "",
        quantity: quantity,
        unitprice: price,
        total: total,
        discount: discount,
        taxableAmt: taxableAmount,
        taxAmt: taxAmt,
        taxrate: taxrate,
        image: image,
      ));
    }
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in items) {
      totalPrice += item.unitprice * item.quantity;
    }

    finalTotal = totalPrice;
    return totalPrice;
  }

  void updateItemQuantity(String stockCode, int newQuantity) {
    var existingItem =
        items.firstWhereOrNull((item) => item.stockCode == stockCode);

    if (existingItem != null) {
      existingItem.quantity = newQuantity;
    }
  }

  void removeItem(String stockCode) {
    items.removeWhere((item) => item.stockCode == stockCode);
  }
}

class SalesItem {
  String? stockID;
  String stockCode;
  String description;
  String uom;
  int quantity;
  double unitprice;
  double total;
  double discount;
  double taxableAmt;
  double taxrate;
  double taxAmt;
  int? LocationID;
  Uint8List? image;

  SalesItem({
    required this.stockCode,
    required this.description,
    required this.uom,
    required this.quantity,
    required this.unitprice,
    required this.total,
    required this.discount,
    required this.taxableAmt,
    required this.taxAmt,
    required this.taxrate,
    this.image,
  });
}
