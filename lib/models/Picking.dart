class Picking {
  int? docID;
  String? docNo;
  String? docDate;
  String? description;
  String? remark;
  bool? isVoid;
  bool? isTransactPending;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? companyID;
  List<PickingDetails>? pickingDetails;
  List<PickingItems>? pickingItems;
  List<int>? salesDocIDList;

  Picking(
      {this.docID,
      this.docNo,
      this.docDate,
      this.description,
      this.remark,
      this.isVoid,
      this.isTransactPending,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.companyID,
      this.pickingDetails,
      this.pickingItems,
      this.salesDocIDList});

  Picking.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    docNo = json['docNo'];
    docDate = json['docDate'];
    description = json['description'];
    remark = json['remark'];
    isVoid = json['isVoid'];
    isTransactPending = json['isTransactPending'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    companyID = json['companyID'];
    if (json['pickingDetails'] != null) {
      pickingDetails = <PickingDetails>[];
      json['pickingDetails'].forEach((v) {
        pickingDetails!.add(new PickingDetails.fromJson(v));
      });
    }
    if (json['pickingItems'] != null) {
      pickingItems = <PickingItems>[];
      json['pickingItems'].forEach((v) {
        pickingItems!.add(new PickingItems.fromJson(v));
      });
    }
    if (json.containsKey('salesDocIDList')) {
      // Proceed with accessing and casting the value
      salesDocIDList = json['salesDocIDList'].cast<int>();
    } else {
      // Handle the case where the key does not exist
      // Assign a default value or take appropriate action
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
    data['isTransactPending'] = this.isTransactPending;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['companyID'] = this.companyID;
    if (this.pickingDetails != null) {
      data['pickingDetails'] =
          this.pickingDetails!.map((v) => v.toJson()).toList();
    }
    if (this.pickingItems != null) {
      data['pickingItems'] = this.pickingItems!.map((v) => v.toJson()).toList();
    }
    data['salesDocIDList'] = this.salesDocIDList;
    return data;
  }
}

class PickingDetails {
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
  String? location;
  int? storageID;
  String? storageCode;

  PickingDetails(
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
      this.location,
      this.storageID,
      this.storageCode});

  PickingDetails.fromJson(Map<String, dynamic> json) {
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
    location = json['location'];
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
    data['location'] = this.location;
    data['storageID'] = this.storageID;
    data['storageCode'] = this.storageCode;
    return data;
  }
}

class PickingItems {
  int? pickingItemID;
  int? docID;
  int? stockID;
  int? stockBatchID;
  String? batchNo;
  String? batchExpiryDate;
  String? stockCode;
  String? description;
  String? uom;
  double? qty;
  double? packingQty;
  double? transactQty;
  double? editTransactQty;
  int? locationID;
  String? location;

  PickingItems(
      {this.pickingItemID,
      this.docID,
      this.stockID,
      this.stockBatchID,
      this.batchNo,
      this.batchExpiryDate,
      this.stockCode,
      this.description,
      this.uom,
      this.qty,
      this.packingQty,
      this.transactQty,
      this.editTransactQty,
      this.locationID,
      this.location});

  PickingItems.fromJson(Map<String, dynamic> json) {
    pickingItemID = json['pickingItemID'];
    docID = json['docID'];
    stockID = json['stockID'];
    stockBatchID = json['stockBatchID'];
    batchNo = json['batchNo'];
    batchExpiryDate = json['batchExpiryDate'];
    stockCode = json['stockCode'];
    description = json['description'];
    uom = json['uom'];
    qty = json['qty'];
    packingQty = json['packingQty'];
    transactQty = json['transactQty'];
    editTransactQty = json['editTransactQty'];
    locationID = json['locationID'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickingItemID'] = this.pickingItemID;
    data['docID'] = this.docID;
    data['stockID'] = this.stockID;
    data['stockBatchID'] = this.stockBatchID;
    data['batchNo'] = this.batchNo;
    data['batchExpiryDate'] = this.batchExpiryDate;
    data['stockCode'] = this.stockCode;
    data['description'] = this.description;
    data['uom'] = this.uom;
    data['qty'] = this.qty;
    data['packingQty'] = this.packingQty;
    data['transactQty'] = this.transactQty;
    data['editTransactQty'] = this.editTransactQty;
    data['locationID'] = this.locationID;
    data['location'] = this.location;
    return data;
  }
}
