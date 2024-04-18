class StockTransfer {
  int? docID;
  String? docNo;
  String? docDate;
  String? description;
  String? remark;
  bool? isVoid;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? companyID;
  List<StockTransferDetails>? stockTransferDetails;

  StockTransfer(
      {this.docID,
      this.docNo,
      this.docDate,
      this.description,
      this.remark,
      this.isVoid,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.companyID,
      this.stockTransferDetails});

  StockTransfer.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    docNo = json['docNo'];
    docDate = json['docDate'];
    description = json['description'];
    remark = json['remark'];
    isVoid = json['isVoid'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    companyID = json['companyID'];
    if (json['stockTransferDetails'] != null) {
      stockTransferDetails = <StockTransferDetails>[];
      json['stockTransferDetails'].forEach((v) {
        stockTransferDetails!.add(new StockTransferDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docID'] = this.docID;
    data['docNo'] = this.docNo;
    data['docDate'] = this.docDate;
    data['description'] = this.description;
    data['remark'] = this.remark;
    data['isVoid'] = this.isVoid;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['companyID'] = this.companyID;
    if (this.stockTransferDetails != null) {
      data['stockTransferDetails'] =
          this.stockTransferDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockTransferDetails {
  int? dtlID;
  int? docID;
  int? stockID;
  int? stockBatchID;
  String? batchNo;
  String? stockCode;
  String? description;
  String? uom;
  int? qty;
  int? fromLocationID;
  String? fromLocation;
  int? fromStorageID;
  String? fromStorageCode;
  int? toLocationID;
  String? toLocation;
  int? toStorageID;
  String? toStorageCode;

  StockTransferDetails(
      {this.dtlID,
      this.docID,
      this.stockID,
      this.stockBatchID,
      this.batchNo,
      this.stockCode,
      this.description,
      this.uom,
      this.qty,
      this.fromLocationID,
      this.fromLocation,
      this.fromStorageID,
      this.fromStorageCode,
      this.toLocationID,
      this.toLocation,
      this.toStorageID,
      this.toStorageCode});

  StockTransferDetails.fromJson(Map<String, dynamic> json) {
    dtlID = json['dtlID'];
    docID = json['docID'];
    stockID = json['stockID'];
    stockBatchID = json['stockBatchID'];
    batchNo = json['batchNo'];
    stockCode = json['stockCode'];
    description = json['description'];
    uom = json['uom'];
    qty = json['qty'];
    fromLocationID = json['fromLocationID'];
    fromLocation = json['fromLocation'];
    fromStorageID = json['fromStorageID'];
    fromStorageCode = json['fromStorageCode'];
    toLocationID = json['toLocationID'];
    toLocation = json['toLocation'];
    toStorageID = json['toStorageID'];
    toStorageCode = json['toStorageCode'];
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
    data['fromLocationID'] = this.fromLocationID;
    data['fromLocation'] = this.fromLocation;
    data['fromStorageID'] = this.fromStorageID;
    data['fromStorageCode'] = this.fromStorageCode;
    data['toLocationID'] = this.toLocationID;
    data['toLocation'] = this.toLocation;
    data['toStorageID'] = this.toStorageID;
    data['toStorageCode'] = this.toStorageCode;
    return data;
  }
}
