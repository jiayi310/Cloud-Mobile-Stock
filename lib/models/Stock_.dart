class Stock_ {
  int? stockID;
  String? stockCode;
  String? description;
  String? desc2;
  String? image;
  String? baseUOM;
  String? salesUOM;
  bool? hasBatch;
  bool? isActive;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? stockGroupID;
  StockGroup? stockGroup;
  int? stockTypeID;
  StockType? stockType;
  int? stockCategoryID;
  StockCategory? stockCategory;
  int? taxTypeID;
  TaxType? taxType;
  int? companyID;
  List<StockUOMDtoList>? stockUOMDtoList;
  List<StockBatchDtoList>? stockBatchDtoList;
  double? baseUOMPrice1;

  Stock_(
      {this.stockID,
      this.stockCode,
      this.description,
      this.desc2,
      this.image,
      this.baseUOM,
      this.salesUOM,
      this.hasBatch,
      this.isActive,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.stockGroupID,
      this.stockGroup,
      this.stockTypeID,
      this.stockType,
      this.stockCategoryID,
      this.stockCategory,
      this.taxTypeID,
      this.taxType,
      this.companyID,
      this.stockUOMDtoList,
      this.stockBatchDtoList,
      this.baseUOMPrice1});

  Stock_.fromJson(Map<String, dynamic> json) {
    stockID = json['stockID'];
    stockCode = json['stockCode'];
    description = json['description'];
    desc2 = json['desc2'];
    image = json['image'];
    baseUOM = json['baseUOM'];
    salesUOM = json['salesUOM'];
    hasBatch = json['hasBatch'];
    isActive = json['isActive'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    stockGroupID = json['stockGroupID'];
    stockGroup = json['stockGroup'] != null
        ? new StockGroup.fromJson(json['stockGroup'])
        : null;
    stockTypeID = json['stockTypeID'];
    stockType = json['stockType'] != null
        ? new StockType.fromJson(json['stockType'])
        : null;
    stockCategoryID = json['stockCategoryID'];
    stockCategory = json['stockCategory'] != null
        ? new StockCategory.fromJson(json['stockCategory'])
        : null;
    taxTypeID = json['taxTypeID'];
    taxType =
        json['taxType'] != null ? new TaxType.fromJson(json['taxType']) : null;
    companyID = json['companyID'];
    if (json['stockUOMDtoList'] != null) {
      stockUOMDtoList = <StockUOMDtoList>[];
      json['stockUOMDtoList'].forEach((v) {
        stockUOMDtoList!.add(new StockUOMDtoList.fromJson(v));
      });
    }
    if (json['stockBatchDtoList'] != null) {
      stockBatchDtoList = <StockBatchDtoList>[];
      json['stockBatchDtoList'].forEach((v) {
        stockBatchDtoList!.add(new StockBatchDtoList.fromJson(v));
      });
    }
    baseUOMPrice1 = json['baseUOMPrice1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockID'] = this.stockID;
    data['stockCode'] = this.stockCode;
    data['description'] = this.description;
    data['desc2'] = this.desc2;
    data['image'] = this.image;
    data['baseUOM'] = this.baseUOM;
    data['salesUOM'] = this.salesUOM;
    data['hasBatch'] = this.hasBatch;
    data['isActive'] = this.isActive;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['stockGroupID'] = this.stockGroupID;
    if (this.stockGroup != null) {
      data['stockGroup'] = this.stockGroup!.toJson();
    }
    data['stockTypeID'] = this.stockTypeID;
    if (this.stockType != null) {
      data['stockType'] = this.stockType!.toJson();
    }
    data['stockCategoryID'] = this.stockCategoryID;
    if (this.stockCategory != null) {
      data['stockCategory'] = this.stockCategory!.toJson();
    }
    data['taxTypeID'] = this.taxTypeID;
    if (this.taxType != null) {
      data['taxType'] = this.taxType!.toJson();
    }
    data['companyID'] = this.companyID;
    if (this.stockUOMDtoList != null) {
      data['stockUOMDtoList'] =
          this.stockUOMDtoList!.map((v) => v.toJson()).toList();
    }
    if (this.stockBatchDtoList != null) {
      data['stockBatchDtoList'] =
          this.stockBatchDtoList!.map((v) => v.toJson()).toList();
    }
    data['baseUOMPrice1'] = this.baseUOMPrice1;
    return data;
  }
}

class StockGroup {
  int? stockGroupID;
  String? description;
  String? desc2;
  String? shortCode;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? companyID;

  StockGroup(
      {this.stockGroupID,
      this.description,
      this.desc2,
      this.shortCode,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.companyID});

  StockGroup.fromJson(Map<String, dynamic> json) {
    stockGroupID = json['stockGroupID'];
    description = json['description'];
    desc2 = json['desc2'];
    shortCode = json['shortCode'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    companyID = json['companyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockGroupID'] = this.stockGroupID;
    data['description'] = this.description;
    data['desc2'] = this.desc2;
    data['shortCode'] = this.shortCode;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['companyID'] = this.companyID;
    return data;
  }
}

class StockType {
  int? stockTypeID;
  String? description;
  String? desc2;
  String? shortCode;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? companyID;

  StockType(
      {this.stockTypeID,
      this.description,
      this.desc2,
      this.shortCode,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.companyID});

  StockType.fromJson(Map<String, dynamic> json) {
    stockTypeID = json['stockTypeID'];
    description = json['description'];
    desc2 = json['desc2'];
    shortCode = json['shortCode'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    companyID = json['companyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockTypeID'] = this.stockTypeID;
    data['description'] = this.description;
    data['desc2'] = this.desc2;
    data['shortCode'] = this.shortCode;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['companyID'] = this.companyID;
    return data;
  }
}

class StockCategory {
  int? stockCategoryID;
  String? description;
  String? desc2;
  String? shortCode;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? companyID;

  StockCategory(
      {this.stockCategoryID,
      this.description,
      this.desc2,
      this.shortCode,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.companyID});

  StockCategory.fromJson(Map<String, dynamic> json) {
    stockCategoryID = json['stockCategoryID'];
    description = json['description'];
    desc2 = json['desc2'];
    shortCode = json['shortCode'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    companyID = json['companyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockCategoryID'] = this.stockCategoryID;
    data['description'] = this.description;
    data['desc2'] = this.desc2;
    data['shortCode'] = this.shortCode;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['companyID'] = this.companyID;
    return data;
  }
}

class TaxType {
  int? taxTypeID;
  String? taxCode;
  String? description;
  double? taxRate;
  bool? isActive;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? companyID;

  TaxType(
      {this.taxTypeID,
      this.taxCode,
      this.description,
      this.taxRate,
      this.isActive,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.companyID});

  TaxType.fromJson(Map<String, dynamic> json) {
    taxTypeID = json['taxTypeID'];
    taxCode = json['taxCode'];
    description = json['description'];
    taxRate = json['taxRate'];
    isActive = json['isActive'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    companyID = json['companyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taxTypeID'] = this.taxTypeID;
    data['taxCode'] = this.taxCode;
    data['description'] = this.description;
    data['taxRate'] = this.taxRate;
    data['isActive'] = this.isActive;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['companyID'] = this.companyID;
    return data;
  }
}

class StockUOMDtoList {
  int? stockUOMID;
  String? uom;
  String? shelf;
  double? rate;
  double? price;
  double? cost;
  double? minSalePrice;
  double? maxSalePrice;
  double? minQty;
  double? maxQty;
  double? price2;
  double? price3;
  double? price4;
  double? price5;
  double? price6;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? stockID;
  int? companyID;
  List<StockBarcodeDtoList>? stockBarcodeDtoList;
  int? barcodeCount;
  Null? stockBarcodeDtoDeletedList;

  StockUOMDtoList(
      {this.stockUOMID,
      this.uom,
      this.shelf,
      this.rate,
      this.price,
      this.cost,
      this.minSalePrice,
      this.maxSalePrice,
      this.minQty,
      this.maxQty,
      this.price2,
      this.price3,
      this.price4,
      this.price5,
      this.price6,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.stockID,
      this.companyID,
      this.stockBarcodeDtoList,
      this.barcodeCount,
      this.stockBarcodeDtoDeletedList});

  StockUOMDtoList.fromJson(Map<String, dynamic> json) {
    stockUOMID = json['stockUOMID'];
    uom = json['uom'];
    shelf = json['shelf'];
    rate = json['rate'];
    price = json['price'];
    cost = json['cost'];
    minSalePrice = json['minSalePrice'];
    maxSalePrice = json['maxSalePrice'];
    minQty = json['minQty'];
    maxQty = json['maxQty'];
    price2 = json['price2'];
    price3 = json['price3'];
    price4 = json['price4'];
    price5 = json['price5'];
    price6 = json['price6'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    stockID = json['stockID'];
    companyID = json['companyID'];
    if (json['stockBarcodeDtoList'] != null) {
      stockBarcodeDtoList = <StockBarcodeDtoList>[];
      json['stockBarcodeDtoList'].forEach((v) {
        stockBarcodeDtoList!.add(new StockBarcodeDtoList.fromJson(v));
      });
    }
    barcodeCount = json['barcodeCount'];
    stockBarcodeDtoDeletedList = json['stockBarcodeDtoDeletedList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockUOMID'] = this.stockUOMID;
    data['uom'] = this.uom;
    data['shelf'] = this.shelf;
    data['rate'] = this.rate;
    data['price'] = this.price;
    data['cost'] = this.cost;
    data['minSalePrice'] = this.minSalePrice;
    data['maxSalePrice'] = this.maxSalePrice;
    data['minQty'] = this.minQty;
    data['maxQty'] = this.maxQty;
    data['price2'] = this.price2;
    data['price3'] = this.price3;
    data['price4'] = this.price4;
    data['price5'] = this.price5;
    data['price6'] = this.price6;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['stockID'] = this.stockID;
    data['companyID'] = this.companyID;
    if (this.stockBarcodeDtoList != null) {
      data['stockBarcodeDtoList'] =
          this.stockBarcodeDtoList!.map((v) => v.toJson()).toList();
    }
    data['barcodeCount'] = this.barcodeCount;
    data['stockBarcodeDtoDeletedList'] = this.stockBarcodeDtoDeletedList;
    return data;
  }
}

class StockBarcodeDtoList {
  int? stockBarcodeID;
  String? barcode;
  String? description;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? stockUOMID;
  Null? stockUOM;
  int? companyID;

  StockBarcodeDtoList(
      {this.stockBarcodeID,
      this.barcode,
      this.description,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.stockUOMID,
      this.stockUOM,
      this.companyID});

  StockBarcodeDtoList.fromJson(Map<String, dynamic> json) {
    stockBarcodeID = json['stockBarcodeID'];
    barcode = json['barcode'];
    description = json['description'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    stockUOMID = json['stockUOMID'];
    stockUOM = json['stockUOM'];
    companyID = json['companyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockBarcodeID'] = this.stockBarcodeID;
    data['barcode'] = this.barcode;
    data['description'] = this.description;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['stockUOMID'] = this.stockUOMID;
    data['stockUOM'] = this.stockUOM;
    data['companyID'] = this.companyID;
    return data;
  }
}

class StockBatchDtoList {
  int? stockBatchID;
  String? batchNo;
  String? manufacturedDate;
  String? expiryDate;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? stockID;
  int? companyID;
  String? manufacturedDateOnly;
  String? expiryDateOnly;

  StockBatchDtoList(
      {this.stockBatchID,
      this.batchNo,
      this.manufacturedDate,
      this.expiryDate,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.stockID,
      this.companyID,
      this.manufacturedDateOnly,
      this.expiryDateOnly});

  StockBatchDtoList.fromJson(Map<String, dynamic> json) {
    stockBatchID = json['stockBatchID'];
    batchNo = json['batchNo'];
    manufacturedDate = json['manufacturedDate'];
    expiryDate = json['expiryDate'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    stockID = json['stockID'];
    companyID = json['companyID'];
    manufacturedDateOnly = json['manufacturedDateOnly'];
    expiryDateOnly = json['expiryDateOnly'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockBatchID'] = this.stockBatchID;
    data['batchNo'] = this.batchNo;
    data['manufacturedDate'] = this.manufacturedDate;
    data['expiryDate'] = this.expiryDate;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['stockID'] = this.stockID;
    data['companyID'] = this.companyID;
    data['manufacturedDateOnly'] = this.manufacturedDateOnly;
    data['expiryDateOnly'] = this.expiryDateOnly;
    return data;
  }
}
