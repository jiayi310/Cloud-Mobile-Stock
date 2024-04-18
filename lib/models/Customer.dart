class Customer {
  int? customerID;
  String? customerCode;
  String? name;
  String? name2;
  SalesAgent salesAgent = SalesAgent(salesAgent: "");
  String? phone1, phone2;
  String? email, fax1, fax2;
  String? address1, address2, address3, address4, postCode;
  String? deliverAddr1,
      deliverAddr2,
      deliverAddr3,
      deliverAddr4,
      deliverPostCode;
  String? attention;
  int? priceCategory;
  int? salesAgentID;
  int? customerTypeID;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;

  Customer();

  Customer.fromJson(Map<String, dynamic> json) {
    customerID = json["customerID"];
    customerCode = json["customerCode"];
    name = json["name"];
    name2 = json["name2"];
    if (json["salesAgent"] != null)
      salesAgent = SalesAgent.fromJson(json["salesAgent"]);
    phone1 = json["phone1"];
    phone2 = json["phone2"];
    fax1 = json["fax1"];
    fax2 = json["fax2"];
    email = json["email"];
    address1 = json["address1"];
    address2 = json["address2"];
    address3 = json["address3"];
    address4 = json["address4"];
    postCode = json["postCode"];
    deliverAddr1 = json["deliverAddr1"];
    deliverAddr2 = json["deliverAddr2"];
    deliverAddr3 = json["deliverAddr3"];
    deliverAddr4 = json["deliverAddr4"];
    attention = json["attention"];
    deliverPostCode = json["deliverPostCode"];
    attention = json["attention"];
    priceCategory = json["priceCategory"];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    salesAgentID = json["salesAgentID"];
    customerTypeID = json["customerTypeID"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerID'] = this.customerID;
    data['customerCode'] = this.customerCode;
    data['name'] = this.name;
    data['name2'] = this.name2;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['address4'] = this.address4;
    data['postCode'] = this.postCode;
    data['deliverAddr1'] = this.deliverAddr1;
    data['deliverAddr2'] = this.deliverAddr2;
    data['deliverAddr3'] = this.deliverAddr3;
    data['deliverAddr4'] = this.deliverAddr4;
    data['deliverPostCode'] = this.deliverPostCode;
    data['attention'] = this.attention;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['fax1'] = this.fax1;
    data['fax2'] = this.fax2;
    data['email'] = this.email;
    data['priceCategory'] = this.priceCategory;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['customerTypeID'] = this.customerTypeID;
    data['salesAgentID'] = this.salesAgentID;

    return data;
  }
}

class SalesAgent {
  String salesAgent;

  SalesAgent({required this.salesAgent});

  factory SalesAgent.fromJson(dynamic json) {
    return SalesAgent(salesAgent: json['salesAgent'] ?? "");
  }
}
