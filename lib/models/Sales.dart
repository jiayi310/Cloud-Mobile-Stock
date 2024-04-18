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
  bool isSelected = false;
  List<SalesDetails> salesDetails = [];

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

  Sales.fromJson2(Map<String, dynamic> json) {
    docID = json['docID'];
    docNo = json['docNo'];
    docDate = json['docDate'] != null ? DateTime.parse(json["docDate"]) : null;
    customerID = json['customerID'];
    customerCode = json['customerCode'];
    customerName = json['customerName'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    address4 = json['address4'];
    deliverAddr1 = json['deliverAddr1'];
    deliverAddr2 = json['deliverAddr2'];
    deliverAddr3 = json['deliverAddr3'];
    deliverAddr4 = json['deliverAddr4'];
    salesAgent = json['salesAgent'];
    phone = json['phone'];
    fax = json['fax'];
    email = json['email'];
    attention = json['attention'];
    subtotal = json['subtotal'];
    taxableAmt = json['taxableAmt'];
    taxAmt = json['taxAmt'];
    finalTotal = json['finalTotal'];
    paymentTotal = json['paymentTotal'];
    outstanding = json['outstanding'];
    description = json['description'];
    remark = json['remark'];
    shippingMethodID = json['shippingMethodID'];
    isVoid = json['isVoid'];
    lastModifiedUserID = json['lastModifiedUserID'];
    lastModifiedDateTime = json['lastModifiedDateTime'] != null
        ? DateTime.parse(json["lastModifiedDateTime"])
        : null;
    createdUserID = json['createdUserID'];
    createdDateTime = json['createdDateTime'] != null
        ? DateTime.parse(json["createdDateTime"])
        : null;
    companyID = json['companyID'];
    if (json['salesDetails'] != null) {
      salesDetails = <SalesDetails>[];
      json['salesDetails'].forEach((v) {
        salesDetails!.add(new SalesDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docID'] = this.docID;
    data['docNo'] = this.docNo;
    data['docDate'] = this.docDate;
    data['customerID'] = this.customerID;
    data['customerCode'] = this.customerCode;
    data['customerName'] = this.customerName;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['address4'] = this.address4;
    data['deliverAddr1'] = this.deliverAddr1;
    data['deliverAddr2'] = this.deliverAddr2;
    data['deliverAddr3'] = this.deliverAddr3;
    data['deliverAddr4'] = this.deliverAddr4;
    data['salesAgent'] = this.salesAgent;
    data['phone'] = this.phone;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['attention'] = this.attention;
    data['subtotal'] = this.subtotal;
    data['taxableAmt'] = this.taxableAmt;
    data['taxAmt'] = this.taxAmt;
    data['finalTotal'] = this.finalTotal;
    data['paymentTotal'] = this.paymentTotal;
    data['outstanding'] = this.outstanding;
    data['description'] = this.description;
    data['remark'] = this.remark;
    data['shippingMethodID'] = this.shippingMethodID;
    data['isVoid'] = this.isVoid;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['createdUserID'] = this.createdUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['companyID'] = this.companyID;
    if (this.salesDetails != null) {
      data['salesDetails'] = this.salesDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void addItem({
    required int stockID,
    required String stockCode,
    required String description,
    required String uom,
    required double quantity,
    required double price,
    required double discount,
    required double total,
    required double taxAmt,
    required double taxableAmount,
    required double taxrate,
    required Uint8List image,
  }) {
    // Check if an item with the same code already exists in the list
    var existingItem = salesDetails.firstWhereOrNull(
        (item) => item.stockCode == stockCode && item.uom == uom);

    if (existingItem != null) {
      existingItem.qty = (existingItem.qty ?? 0) + quantity;
    } else {
      salesDetails.add(SalesDetails(
        stockID: stockID,
        stockCode: stockCode,
        description: description,
        uom: uom ?? "",
        qty: quantity,
        unitPrice: price,
        total: total,
        discount: discount,
        taxableAmt: taxableAmount,
        taxAmt: taxAmt,
        taxRate: taxrate,
        image: image,
      ));
    }
  }

  double calculateTotalPrice() {
    double totalPrice = 0, tax = 0;
    for (var item in salesDetails) {
      double subtotal = (item.unitPrice ?? 0) * (item.qty ?? 0);

      item.total = subtotal;

      totalPrice += subtotal;

      tax += item.taxAmt ?? 0;
    }

    subtotal = totalPrice;
    finalTotal = totalPrice;
    taxAmt = tax;
    return totalPrice;
  }

  void updateItemQuantity(String stockCode, double newQuantity) {
    var existingItem =
        salesDetails.firstWhereOrNull((item) => item.stockCode == stockCode);

    if (existingItem != null) {
      existingItem.qty = newQuantity;
    }
  }

  void removeItem(String stockCode) {
    salesDetails.removeWhere((item) => item.stockCode == stockCode);
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
    required this.stockID,
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

class SalesDetails {
  int? dtlID;
  int? docID;
  int? stockID;
  String? stockCode;
  int? stockBatchID;
  String? batchNo;
  String? description;
  String? uom;
  double? qty;
  double? unitPrice;
  double? discount;
  double? total;
  int? taxTypeID;
  double? taxableAmt;
  double? taxRate;
  double? taxAmt;
  int? locationID;
  String? location;
  Uint8List? image;

  SalesDetails(
      {this.dtlID,
      this.docID,
      this.stockID,
      this.stockCode,
      this.stockBatchID,
      this.batchNo,
      this.description,
      this.uom,
      this.qty,
      this.unitPrice,
      this.discount,
      this.total,
      this.taxTypeID,
      this.taxableAmt,
      this.taxRate,
      this.taxAmt,
      this.locationID,
      this.location,
      this.image});

  SalesDetails.fromJson(Map<String, dynamic> json) {
    dtlID = json['dtlID'];
    docID = json['docID'];
    stockID = json['stockID'];
    stockCode = json['stockCode'];
    stockBatchID = json['stockBatchID'];
    batchNo = json['batchNo'];
    description = json['description'];
    uom = json['uom'];
    qty = json['qty'];
    unitPrice = json['unitPrice'];
    discount = json['discount'];
    total = json['total'];
    taxTypeID = json['taxTypeID'];
    taxableAmt = json['taxableAmt'];
    taxRate = json['taxRate'];
    taxAmt = json['taxAmt'];
    locationID = json['locationID'];
    location = json['location'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dtlID'] = this.dtlID;
    data['docID'] = this.docID;
    data['stockID'] = this.stockID;
    data['stockCode'] = this.stockCode;
    data['stockBatchID'] = this.stockBatchID;
    data['batchNo'] = this.batchNo;
    data['description'] = this.description;
    data['uom'] = this.uom;
    data['qty'] = this.qty;
    data['unitPrice'] = this.unitPrice;
    data['discount'] = this.discount;
    data['total'] = this.total;
    data['taxTypeID'] = this.taxTypeID;
    data['taxableAmt'] = this.taxableAmt;
    data['taxRate'] = this.taxRate;
    data['taxAmt'] = this.taxAmt;
    data['locationID'] = this.locationID;
    data['location'] = this.location;
    data['image'] = this.image;
    return data;
  }
}
