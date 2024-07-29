class StockTake {
  int? docID;
  String? docNo;
  String? docDate;
  String? description;
  String? remark;
  bool? isMerge;
  int? mergeDocID;
  String? mergeDocNo;
  String? mergeDate;
  bool? isAdjustment;
  int? adjustmentDocID;
  String? adjustmentDocNo;
  String? adjustmentDate;
  bool? isVoid;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? locationID;
  String? location;
  int? companyID;
  List<StockTakeDetails>? stockTakeDetails;

  void removeStockTakeDetail(StockTakeDetails detail) {
    stockTakeDetails?.remove(detail);
  }

  StockTake(
      {this.docID,
      this.docNo,
      this.docDate,
      this.description,
      this.remark,
      this.isMerge,
      this.mergeDocID,
      this.mergeDocNo,
      this.mergeDate,
      this.isAdjustment,
      this.adjustmentDocID,
      this.adjustmentDocNo,
      this.adjustmentDate,
      this.isVoid,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.locationID,
      this.location,
      this.companyID,
      this.stockTakeDetails});

  StockTake.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    docNo = json['docNo'];
    docDate = json['docDate'];
    description = json['description'];
    remark = json['remark'];
    isMerge = json['isMerge'];
    mergeDocID = json['mergeDocID'];
    mergeDocNo = json['mergeDocNo'];
    mergeDate = json['mergeDate'];
    isAdjustment = json['isAdjustment'];
    adjustmentDocID = json['adjustmentDocID'];
    adjustmentDocNo = json['adjustmentDocNo'];
    adjustmentDate = json['adjustmentDate'];
    isVoid = json['isVoid'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    locationID = json['locationID'];
    location = json['location'];
    companyID = json['companyID'];
    if (json['stockTakeDetails'] != null) {
      stockTakeDetails = <StockTakeDetails>[];
      json['stockTakeDetails'].forEach((v) {
        stockTakeDetails!.add(new StockTakeDetails.fromJson(v));
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
    data['isMerge'] = this.isMerge;
    data['mergeDocID'] = this.mergeDocID;
    data['mergeDocNo'] = this.mergeDocNo;
    data['mergeDate'] = this.mergeDate;
    data['isAdjustment'] = this.isAdjustment;
    data['adjustmentDocID'] = this.adjustmentDocID;
    data['adjustmentDocNo'] = this.adjustmentDocNo;
    data['adjustmentDate'] = this.adjustmentDate;
    data['isVoid'] = this.isVoid;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['locationID'] = this.locationID;
    data['location'] = this.location;
    data['companyID'] = this.companyID;
    if (this.stockTakeDetails != null) {
      data['stockTakeDetails'] =
          this.stockTakeDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockTakeDetails {
  int? dtlID;
  int? docID;
  int? stockID;
  int? stockBatchID;
  String? batchNo;
  String? stockCode;
  String? description;
  String? uom;
  double? qty;
  int? locationID;
  int? storageID;
  String? storageCode;

  StockTakeDetails(
      {this.dtlID,
      this.docID,
      this.stockID,
      this.stockBatchID,
      this.batchNo,
      this.stockCode,
      this.description,
      this.uom,
      this.qty,
      this.locationID,
      this.storageID,
      this.storageCode});

  StockTakeDetails.fromJson(Map<String, dynamic> json) {
    dtlID = json['dtlID'];
    docID = json['docID'];
    stockID = json['stockID'];
    stockBatchID = json['stockBatchID'];
    batchNo = json['batchNo'];
    stockCode = json['stockCode'];
    description = json['description'];
    uom = json['uom'];
    qty = json['qty'];
    locationID = json['locationID'];
    storageID = json['storageID'];
    storageCode = json['storageCode'];
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
    data['locationID'] = this.locationID;
    data['storageID'] = this.storageID;
    data['storageCode'] = this.storageCode;
    return data;
  }
}
