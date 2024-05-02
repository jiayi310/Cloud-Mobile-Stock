class PutAway {
  int? putAwayID;
  String? docNo;
  int? stockID;
  int? stockBatchID;
  String? batchNo;
  String? stockCode;
  String? description;
  String? uom;
  double? qty;
  String? receivingDocNo;
  int? receivingDtlID;
  int? locationID;
  String? location;
  int? storageID;
  String? storageCode;
  String? createdDateTime;
  int? createdUserID;
  int? companyID;

  PutAway(
      {this.putAwayID,
      this.docNo,
      this.stockID,
      this.stockBatchID,
      this.batchNo,
      this.stockCode,
      this.description,
      this.uom,
      this.qty,
      this.receivingDocNo,
      this.receivingDtlID,
      this.locationID,
      this.location,
      this.storageID,
      this.storageCode,
      this.createdDateTime,
      this.createdUserID,
      this.companyID});

  PutAway.fromJson(Map<String, dynamic> json) {
    putAwayID = json['putAwayID'];
    docNo = json['docNo'];
    stockID = json['stockID'];
    stockBatchID = json['stockBatchID'];
    batchNo = json['batchNo'];
    stockCode = json['stockCode'];
    description = json['description'];
    uom = json['uom'];
    qty = json['qty'];
    receivingDocNo = json['receivingDocNo'];
    receivingDtlID = json['receivingDtlID'];
    locationID = json['locationID'];
    location = json['location'];
    storageID = json['storageID'];
    storageCode = json['storageCode'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    companyID = json['companyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['putAwayID'] = this.putAwayID;
    data['docNo'] = this.docNo;
    data['stockID'] = this.stockID;
    data['stockBatchID'] = this.stockBatchID;
    data['batchNo'] = this.batchNo;
    data['stockCode'] = this.stockCode;
    data['description'] = this.description;
    data['uom'] = this.uom;
    data['qty'] = this.qty;
    data['receivingDocNo'] = this.receivingDocNo;
    data['receivingDtlID'] = this.receivingDtlID;
    data['locationID'] = this.locationID;
    data['location'] = this.location;
    data['storageID'] = this.storageID;
    data['storageCode'] = this.storageCode;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['companyID'] = this.companyID;
    return data;
  }
}
