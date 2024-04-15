class Company {
  int? companyID;
  String? companyName;
  int? salesDecimalPoint;
  int? purchaseDecimalPoint;
  int? quantityDecimalPoint;
  int? costDecimalPoint;
  String? address1;
  String? address2;
  String? address3;
  String? address4;
  String? postCode;
  int? superadminUserID;
  String? phone;
  bool? isDeletedTemporarily;
  bool? isDeletedPermanently;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? licenseID;
  String? license;

  Company({
    this.companyID,
    this.companyName,
    this.salesDecimalPoint,
    this.purchaseDecimalPoint,
    this.quantityDecimalPoint,
    this.costDecimalPoint,
    this.address1,
    this.address2,
    this.address3,
    this.address4,
    this.postCode,
    this.superadminUserID,
    this.phone,
    this.isDeletedTemporarily,
    this.isDeletedPermanently,
    this.lastModifiedDateTime,
    this.lastModifiedUserID,
    this.createdDateTime,
    this.createdUserID,
    this.licenseID,
    this.license,
  });

  Company.fromJson(Map<String, dynamic> json) {
    companyID = json['companyID'];
    companyName = json['companyName'];
    salesDecimalPoint = json['salesDecimalPoint'];
    purchaseDecimalPoint = json['purchaseDecimalPoint'];
    quantityDecimalPoint = json['quantityDecimalPoint'];
    costDecimalPoint = json['costDecimalPoint'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    address4 = json['address4'];
    postCode = json['postCode'];
    superadminUserID = json['superadminUserID'];
    phone = json['phone'];
    isDeletedTemporarily = json['isDeletedTemporarily'];
    isDeletedPermanently = json['isDeletedPermanently'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    licenseID = json['licenseID'];
    license = json['license'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyID'] = this.companyID;
    data['companyName'] = this.companyName;
    data['salesDecimalPoint'] = this.salesDecimalPoint;
    data['purchaseDecimalPoint'] = this.purchaseDecimalPoint;
    data['quantityDecimalPoint'] = this.quantityDecimalPoint;
    data['costDecimalPoint'] = this.costDecimalPoint;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['address4'] = this.address4;
    data['postCode'] = this.postCode;
    data['superadminUserID'] = this.superadminUserID;
    data['phone'] = this.phone;
    data['isDeletedTemporarily'] = this.isDeletedTemporarily;
    data['isDeletedPermanently'] = this.isDeletedPermanently;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['licenseID'] = this.licenseID;
    data['license'] = this.license;

    return data;
  }
}
