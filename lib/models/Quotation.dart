import 'dart:typed_data';

import 'package:get/get.dart';

class Quotation {
  int? docID;
  String? docNo;
  String? docDate;
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
  String? description;
  String? remark;
  int? shippingMethodID;
  String? shippingMethodDescription;
  bool? isVoid;
  int? lastModifiedUserID;
  String? lastModifiedDateTime;
  int? createdUserID;
  String? createdDateTime;
  int? companyID;
  List<QuotationDetails> quotationDetails = [];

  Quotation();

  Quotation.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    docNo = json['docNo'];
    docDate = json['docDate'];
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
    description = json['description'];
    remark = json['remark'];
    shippingMethodID = json['shippingMethodID'];
    shippingMethodDescription = json['shippingMethodDescription'];
    isVoid = json['isVoid'];
    lastModifiedUserID = json['lastModifiedUserID'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    createdUserID = json['createdUserID'];
    createdDateTime = json['createdDateTime'];
    companyID = json['companyID'];
    if (json['quotationDetails'] != null) {
      quotationDetails = <QuotationDetails>[];
      json['quotationDetails'].forEach((v) {
        quotationDetails!.add(new QuotationDetails.fromJson(v));
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
    data['description'] = this.description;
    data['remark'] = this.remark;
    data['shippingMethodID'] = this.shippingMethodID;
    data['shippingMethodDescription'] = this.shippingMethodDescription;
    data['isVoid'] = this.isVoid;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['createdUserID'] = this.createdUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['companyID'] = this.companyID;
    if (this.quotationDetails != null) {
      data['quotationDetails'] =
          this.quotationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void removeItem(String stockcode) {
    quotationDetails!.removeWhere((item) => item.stockCode == stockcode);
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
    var existingItem = quotationDetails.firstWhereOrNull(
      (item) => item.stockCode == stockCode && item.uom == uom,
    );

    if (existingItem != null) {
      // If the item exists, update its quantity
      existingItem.qty = (existingItem.qty ?? 0) + quantity;
    } else {
      // If the item doesn't exist, add a new item to the list
      quotationDetails.add(QuotationDetails(
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
    for (var item in quotationDetails) {
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
}

class QuotationDetails {
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

  QuotationDetails(
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

  QuotationDetails.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
