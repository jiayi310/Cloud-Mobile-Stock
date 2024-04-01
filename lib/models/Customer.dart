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
    salesAgentID = json["salesAgentID"];
    customerTypeID = json["customerTypeID"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerID'] = this.customerID;
    data['customerCode'] = this.customerCode;
    data['name'] = this.name;
    data['name2'] = this.name2;
    // data['salesAgent'] = this.salesAgent;
    data['phone1'] = this.phone1;
    data['email'] = this.email;
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
//
// final List<Customer> demo_customer = [
//   Customer(
//       "300-A0001",
//       "Sky Advanced Infinity (M) Sdn Bhd",
//       "Sing Inficanty Pro (Z) Malaysia Sdn Bhd",
//       "Jason",
//       "011-985423668",
//       "jason@gmail.com"),
//   Customer("300-A0002", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
//       "jason@gmail.com"),
//   Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
//       "jason@gmail.com"),
//   Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
//       "jason@gmail.com"),
//   Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
//       "jason@gmail.com"),
//   Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
//       "jason@gmail.com"),
//   Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
//       "jason@gmail.com"),
//   Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
//       "jason@gmail.com"),
//   Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
//       "jason@gmail.com"),
// ];
