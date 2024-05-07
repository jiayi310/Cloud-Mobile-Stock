class Location {
  int? locationID;
  String? location;
  String? address1;
  String? address2;
  String? address3;
  String? address4;
  String? postCode;
  String? phone1;
  String? phone2;
  String? fax1;
  String? fax2;
  bool? isActive;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? companyID;

  Location(
      {this.locationID,
      this.location,
      this.address1,
      this.address2,
      this.address3,
      this.address4,
      this.postCode,
      this.phone1,
      this.phone2,
      this.fax1,
      this.fax2,
      this.isActive,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.companyID});

  Location.fromJson(Map<String, dynamic> json) {
    locationID = json['locationID'];
    location = json['location'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    address4 = json['address4'];
    postCode = json['postCode'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    fax1 = json['fax1'];
    fax2 = json['fax2'];
    isActive = json['isActive'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    companyID = json['companyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationID'] = this.locationID;
    data['location'] = this.location;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['address4'] = this.address4;
    data['postCode'] = this.postCode;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['fax1'] = this.fax1;
    data['fax2'] = this.fax2;
    data['isActive'] = this.isActive;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['companyID'] = this.companyID;
    return data;
  }
}

class LocationDropDown {
  int? locationID;
  String? location;
  bool? isDisabled;
  List<StorageDropdownDtoList>? storageDropdownDtoList;

  LocationDropDown(
      {this.locationID,
      this.location,
      this.isDisabled,
      this.storageDropdownDtoList});

  LocationDropDown.fromJson(Map<String, dynamic> json) {
    locationID = json['locationID'];
    location = json['location'];
    isDisabled = json['isDisabled'];
    if (json['storageDropdownDtoList'] != null) {
      storageDropdownDtoList = <StorageDropdownDtoList>[];
      json['storageDropdownDtoList'].forEach((v) {
        storageDropdownDtoList!.add(new StorageDropdownDtoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationID'] = this.locationID;
    data['location'] = this.location;
    data['isDisabled'] = this.isDisabled;
    if (this.storageDropdownDtoList != null) {
      data['storageDropdownDtoList'] =
          this.storageDropdownDtoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StorageDropdownDtoList {
  int? storageID;
  String? storageCode;
  String? location;
  bool? isDisabled;

  StorageDropdownDtoList(
      {this.storageID, this.storageCode, this.location, this.isDisabled});

  StorageDropdownDtoList.fromJson(Map<String, dynamic> json) {
    storageID = json['storageID'];
    storageCode = json['storageCode'];
    location = json['location'];
    isDisabled = json['isDisabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storageID'] = this.storageID;
    data['storageCode'] = this.storageCode;
    data['location'] = this.location;
    data['isDisabled'] = this.isDisabled;
    return data;
  }
}
