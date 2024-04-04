class Quotation {
  int? docID;
  String? docNo;
  String? docDate;
  int? customerID;
  String? customerCode;
  String? customerName;
  String? salesAgent;
  double? subtotal;
  double? taxableAmt;
  double? taxAmt;
  double? finalTotal;
  String? description;
  String? remark;
  int? shippingMethodID;
  String? shippingMethodDescription;
  String? location;
  bool? isVoid;
  int? lastModifiedUserID;
  String? lastModifiedDateTime;
  int? createdUserID;
  String? createdDateTime;

  Quotation(
      {this.docID,
      this.docNo,
      this.docDate,
      this.customerID,
      this.customerCode,
      this.customerName,
      this.salesAgent,
      this.subtotal,
      this.taxableAmt,
      this.taxAmt,
      this.finalTotal,
      this.description,
      this.remark,
      this.shippingMethodID,
      this.shippingMethodDescription,
      this.location,
      this.isVoid,
      this.lastModifiedUserID,
      this.lastModifiedDateTime,
      this.createdUserID,
      this.createdDateTime});

  Quotation.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    docNo = json['docNo'];
    docDate = json['docDate'];
    customerID = json['customerID'];
    customerCode = json['customerCode'];
    customerName = json['customerName'];
    salesAgent = json['salesAgent'];
    subtotal = json['subtotal'];
    taxableAmt = json['taxableAmt'];
    taxAmt = json['taxAmt'];
    finalTotal = json['finalTotal'];
    description = json['description'];
    remark = json['remark'];
    shippingMethodID = json['shippingMethodID'];
    shippingMethodDescription = json['shippingMethodDescription'];
    location = json['location'];
    isVoid = json['isVoid'];
    lastModifiedUserID = json['lastModifiedUserID'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    createdUserID = json['createdUserID'];
    createdDateTime = json['createdDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docID'] = this.docID;
    data['docNo'] = this.docNo;
    data['docDate'] = this.docDate;
    data['customerID'] = this.customerID;
    data['customerCode'] = this.customerCode;
    data['customerName'] = this.customerName;
    data['salesAgent'] = this.salesAgent;
    data['subtotal'] = this.subtotal;
    data['taxableAmt'] = this.taxableAmt;
    data['taxAmt'] = this.taxAmt;
    data['finalTotal'] = this.finalTotal;
    data['description'] = this.description;
    data['remark'] = this.remark;
    data['shippingMethodID'] = this.shippingMethodID;
    data['shippingMethodDescription'] = this.shippingMethodDescription;
    data['location'] = this.location;
    data['isVoid'] = this.isVoid;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['createdUserID'] = this.createdUserID;
    data['createdDateTime'] = this.createdDateTime;
    return data;
  }
}
