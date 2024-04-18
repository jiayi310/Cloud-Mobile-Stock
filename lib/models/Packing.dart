class Packing {
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
  String? phone;
  String? fax;
  String? email;
  String? attention;
  String? description;
  String? remark;
  bool? isVoid;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  String? shippingRefNo;
  int? shippingMethodID;
  String? shippingMethodDescription;
  int? salesDocID;
  String? salesDocNo;
  int? pickingDocID;
  String? pickingDocNo;
  int? companyID;
  List<PackingDetails>? packingDetails;

  Packing(
      {this.docID,
      this.docNo,
      this.docDate,
      this.customerID,
      this.customerCode,
      this.customerName,
      this.address1,
      this.address2,
      this.address3,
      this.address4,
      this.deliverAddr1,
      this.deliverAddr2,
      this.deliverAddr3,
      this.deliverAddr4,
      this.phone,
      this.fax,
      this.email,
      this.attention,
      this.description,
      this.remark,
      this.isVoid,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.shippingRefNo,
      this.shippingMethodID,
      this.shippingMethodDescription,
      this.salesDocID,
      this.salesDocNo,
      this.pickingDocID,
      this.pickingDocNo,
      this.companyID,
      this.packingDetails});

  Packing.fromJson(Map<String, dynamic> json) {
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
    phone = json['phone'];
    fax = json['fax'];
    email = json['email'];
    attention = json['attention'];
    description = json['description'];
    remark = json['remark'];
    isVoid = json['isVoid'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    shippingRefNo = json['shippingRefNo'];
    shippingMethodID = json['shippingMethodID'];
    shippingMethodDescription = json['shippingMethodDescription'];
    salesDocID = json['salesDocID'];
    salesDocNo = json['salesDocNo'];
    pickingDocID = json['pickingDocID'];
    pickingDocNo = json['pickingDocNo'];
    companyID = json['companyID'];
    if (json['packingDetails'] != null) {
      packingDetails = <PackingDetails>[];
      json['packingDetails'].forEach((v) {
        packingDetails!.add(new PackingDetails.fromJson(v));
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
    data['phone'] = this.phone;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['attention'] = this.attention;
    data['description'] = this.description;
    data['remark'] = this.remark;
    data['isVoid'] = this.isVoid;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['shippingRefNo'] = this.shippingRefNo;
    data['shippingMethodID'] = this.shippingMethodID;
    data['shippingMethodDescription'] = this.shippingMethodDescription;
    data['salesDocID'] = this.salesDocID;
    data['salesDocNo'] = this.salesDocNo;
    data['pickingDocID'] = this.pickingDocID;
    data['pickingDocNo'] = this.pickingDocNo;
    data['companyID'] = this.companyID;
    if (this.packingDetails != null) {
      data['packingDetails'] =
          this.packingDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackingDetails {
  int? dtlID;
  int? docID;
  int? pickingItemID;
  int? stockID;
  int? stockBatchID;
  String? batchNo;
  String? stockCode;
  String? description;
  String? uom;
  int? qty;

  PackingDetails(
      {this.dtlID,
      this.docID,
      this.pickingItemID,
      this.stockID,
      this.stockBatchID,
      this.batchNo,
      this.stockCode,
      this.description,
      this.uom,
      this.qty});

  PackingDetails.fromJson(Map<String, dynamic> json) {
    dtlID = json['dtlID'];
    docID = json['docID'];
    pickingItemID = json['pickingItemID'];
    stockID = json['stockID'];
    stockBatchID = json['stockBatchID'];
    batchNo = json['batchNo'];
    stockCode = json['stockCode'];
    description = json['description'];
    uom = json['uom'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dtlID'] = this.dtlID;
    data['docID'] = this.docID;
    data['pickingItemID'] = this.pickingItemID;
    data['stockID'] = this.stockID;
    data['stockBatchID'] = this.stockBatchID;
    data['batchNo'] = this.batchNo;
    data['stockCode'] = this.stockCode;
    data['description'] = this.description;
    data['uom'] = this.uom;
    data['qty'] = this.qty;
    return data;
  }
}
