class Supplier {
  int? supplierID;
  String? supplierCode;
  String? name;
  String? name2;
  String? address1;
  String? address2;
  String? address3;
  String? address4;
  String? postCode;
  String? attention;
  String? phone1;
  String? phone2;
  String? fax1;
  String? fax2;
  String? email;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? supplierTypeID;
  SupplierType? supplierType;
  int? companyID;

  Supplier(
      {this.supplierID,
      this.supplierCode,
      this.name,
      this.name2,
      this.address1,
      this.address2,
      this.address3,
      this.address4,
      this.postCode,
      this.attention,
      this.phone1,
      this.phone2,
      this.fax1,
      this.fax2,
      this.email,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.supplierTypeID,
      this.supplierType,
      this.companyID});

  Supplier.fromJson(Map<String, dynamic> json) {
    supplierID = json['supplierID'];
    supplierCode = json['supplierCode'];
    name = json['name'];
    name2 = json['name2'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    address4 = json['address4'];
    postCode = json['postCode'];
    attention = json['attention'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    fax1 = json['fax1'];
    fax2 = json['fax2'];
    email = json['email'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    supplierTypeID = json['supplierTypeID'];
    supplierType = json['supplierType'] != null
        ? new SupplierType.fromJson(json['supplierType'])
        : null;
    companyID = json['companyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplierID'] = this.supplierID;
    data['supplierCode'] = this.supplierCode;
    data['name'] = this.name;
    data['name2'] = this.name2;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['address4'] = this.address4;
    data['postCode'] = this.postCode;
    data['attention'] = this.attention;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['fax1'] = this.fax1;
    data['fax2'] = this.fax2;
    data['email'] = this.email;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['supplierTypeID'] = this.supplierTypeID;
    if (this.supplierType != null) {
      data['supplierType'] = this.supplierType!.toJson();
    }
    data['companyID'] = this.companyID;
    return data;
  }
}

class SupplierType {
  int? supplierTypeID;
  String? description;
  String? desc2;
  bool? isActive;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? companyID;

  SupplierType(
      {this.supplierTypeID,
      this.description,
      this.desc2,
      this.isActive,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.companyID});

  SupplierType.fromJson(Map<String, dynamic> json) {
    supplierTypeID = json['supplierTypeID'];
    description = json['description'];
    desc2 = json['desc2'];
    isActive = json['isActive'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    companyID = json['companyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplierTypeID'] = this.supplierTypeID;
    data['description'] = this.description;
    data['desc2'] = this.desc2;
    data['isActive'] = this.isActive;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['companyID'] = this.companyID;
    return data;
  }
}
