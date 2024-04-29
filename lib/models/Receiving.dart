import 'dart:typed_data';

class Receiving {
  int? docID;
  String? docNo;
  String? docDate;
  int? supplierID;
  String? supplierCode;
  String? supplierName;
  String? address1;
  String? address2;
  String? address3;
  String? address4;
  String? phone;
  String? fax;
  String? email;
  String? attention;
  String? description;
  String? remark;
  bool? isPutAway;
  bool? isVoid;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? companyID;
  List<ReceivingDetails>? receivingDetails;

  Receiving(
      {this.docID,
      this.docNo,
      this.docDate,
      this.supplierID,
      this.supplierCode,
      this.supplierName,
      this.address1,
      this.address2,
      this.address3,
      this.address4,
      this.phone,
      this.fax,
      this.email,
      this.attention,
      this.description,
      this.remark,
      this.isPutAway,
      this.isVoid,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.companyID,
      this.receivingDetails});

  Receiving.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    docNo = json['docNo'];
    docDate = json['docDate'];
    supplierID = json['supplierID'];
    supplierCode = json['supplierCode'];
    supplierName = json['supplierName'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    address4 = json['address4'];
    phone = json['phone'];
    fax = json['fax'];
    email = json['email'];
    attention = json['attention'];
    description = json['description'];
    remark = json['remark'];
    isPutAway = json['isPutAway'];
    isVoid = json['isVoid'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    companyID = json['companyID'];
    if (json['receivingDetails'] != null) {
      receivingDetails = <ReceivingDetails>[];
      json['receivingDetails'].forEach((v) {
        receivingDetails!.add(new ReceivingDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docID'] = this.docID;
    data['docNo'] = this.docNo;
    data['docDate'] = this.docDate;
    data['supplierID'] = this.supplierID;
    data['supplierCode'] = this.supplierCode;
    data['supplierName'] = this.supplierName;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['address4'] = this.address4;
    data['phone'] = this.phone;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['attention'] = this.attention;
    data['description'] = this.description;
    data['remark'] = this.remark;
    data['isPutAway'] = this.isPutAway;
    data['isVoid'] = this.isVoid;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['companyID'] = this.companyID;
    if (this.receivingDetails != null) {
      data['receivingDetails'] =
          this.receivingDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReceivingDetails {
  int? dtlID;
  int? docID;
  int? stockID;
  int? stockBatchID;
  String? batchNo;
  String? stockCode;
  String? description;
  String? uom;
  double? qty;
  double? putAwayQty;
  Uint8List? image;

  ReceivingDetails(
      {this.dtlID,
      this.docID,
      this.stockID,
      this.stockBatchID,
      this.batchNo,
      this.stockCode,
      this.description,
      this.uom,
      this.qty,
      this.putAwayQty,
      this.image});

  ReceivingDetails.fromJson(Map<String, dynamic> json) {
    dtlID = json['dtlID'];
    docID = json['docID'];
    stockID = json['stockID'];
    stockBatchID = json['stockBatchID'];
    batchNo = json['batchNo'];
    stockCode = json['stockCode'];
    description = json['description'];
    uom = json['uom'];
    qty = json['qty'];
    putAwayQty = json['putAwayQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dtlID'] = this.dtlID;
    data['docID'] = this.docID;
    data['stockID'] = this.stockID;
    data['stockBatchID'] = this.stockBatchID;
    data['batchNo'] = this.batchNo;
    data['stockCode'] = this.stockCode;
    data['description'] = this.description;
    data['uom'] = this.uom;
    data['qty'] = this.qty;
    data['putAwayQty'] = this.putAwayQty;
    return data;
  }
}
