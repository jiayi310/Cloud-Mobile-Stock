class StockBalance {
  int? stockBalanceID;
  int? stockID;
  String? stockCode;
  String? stockDescription;
  String? uom;
  double? qty;
  int? stockBatchID;
  String? batchNo;
  String? batchExpiryDate;
  int? locationID;
  String? location;

  StockBalance(
      {this.stockBalanceID,
      this.stockID,
      this.stockCode,
      this.stockDescription,
      this.uom,
      this.qty,
      this.stockBatchID,
      this.batchNo,
      this.batchExpiryDate,
      this.locationID,
      this.location});
  StockBalance.fromJson(Map<String, dynamic> json) {
    stockBalanceID = json['stockBalanceID'];
    stockID = json['stockID'];
    stockCode = json['stockCode'];
    stockDescription = json['stockDescription'];
    uom = json['uom'];
    qty = json['qty'];
    stockBatchID = json['stockBatchID'];
    batchNo = json['batchNo'];
    batchExpiryDate = json['batchExpiryDate'];
    locationID = json['locationID'];
    location = json['location'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockBalanceID'] = this.stockBalanceID;
    data['stockID'] = this.stockID;
    data['stockCode'] = this.stockCode;
    data['stockDescription'] = this.stockDescription;
    data['uom'] = this.uom;
    data['qty'] = this.qty;
    data['stockBatchID'] = this.stockBatchID;
    data['batchNo'] = this.batchNo;
    data['batchExpiryDate'] = this.batchExpiryDate;
    data['locationID'] = this.locationID;
    data['location'] = this.location;
    return data;
  }
}
