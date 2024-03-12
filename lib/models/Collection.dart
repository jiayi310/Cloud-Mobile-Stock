import 'package:mobilestock/models/Collection.dart';
import 'package:mobilestock/models/Customer.dart';
import 'package:mobilestock/models/Sales.dart';

class Collection {
  int? docID;
  String? docNo;
  String? docDate;
  int? customerID;
  Customer? customer;
  String? customerCode;
  String? customerName;
  String? salesAgent;
  String? paymentType;
  String? refNo;
  double paymentTotal = 0.00;
  String? image;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? companyID;
  List<CollectMappings>? collectMappings;

  Collection({
    this.docID,
    this.docNo,
    this.docDate,
    this.customerID,
    this.customer,
    this.customerCode,
    this.customerName,
    this.salesAgent,
    this.paymentType,
    this.refNo,
    required this.paymentTotal,
    this.image,
    this.lastModifiedDateTime,
    this.lastModifiedUserID,
    this.createdDateTime,
    this.createdUserID,
    this.companyID,
  });

  Collection.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    docNo = json['docNo'];
    docDate = json['docDate'];
    customerID = json['customerID'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    customerCode = json['customerCode'];
    customerName = json['customerName'];
    salesAgent = json['salesAgent'];
    paymentType = json['paymentType'];
    refNo = json['refNo'];
    paymentTotal = json['paymentTotal'];
    image = json['image'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    companyID = json['companyID'];
    if (json['collectMappings'] != null) {
      collectMappings = <CollectMappings>[];
      json['collectMappings'].forEach((v) {
        collectMappings!.add(new CollectMappings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docID'] = this.docID;
    data['docNo'] = this.docNo;
    data['docDate'] = this.docDate;
    data['customerID'] = this.customerID;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['customerCode'] = this.customerCode;
    data['customerName'] = this.customerName;
    data['salesAgent'] = this.salesAgent;
    data['paymentType'] = this.paymentType;
    data['refNo'] = this.refNo;
    data['paymentTotal'] = this.paymentTotal;
    data['image'] = this.image;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['companyID'] = this.companyID;
    if (this.collectMappings != null) {
      data['collectMappings'] =
          this.collectMappings!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void addItem({
    String? collect,
    double? paymentAmt,
    int? salesDocID,
    Sales? sales,
  }) {
    var newItem = CollectMappings(
      paymentAmt: paymentAmt,
      salesDocID: salesDocID,
      sales: sales,
    );

    // Ensure collectMappings is not null before accessing its add method
    collectMappings ??= []; // Initialize collectMappings if it is null
    collectMappings!.add(newItem);

    // Ensure collectMappings is not null before calling updateTotal
    if (collectMappings != null) {
      updateTotal(collectMappings!);
    }
  }

  void removeItem(int salesID) {
    collectMappings!.removeWhere((item) => item.salesDocID == salesID);
  }

  void updateTotal(List<CollectMappings> _collectionDetails) {
    // Calculate the total paymentAmt
    double totalPaymentAmt = 0;

    for (var detail in _collectionDetails) {
      if (detail.paymentAmt != null) {
        totalPaymentAmt += detail.paymentAmt!;
      }
    }

    // Update the paymentTotal field
    paymentTotal = totalPaymentAmt;
  }
}

class SalesAgent {
  int? salesAgentID;
  String? salesAgent;
  String? description;
  String? email;
  bool? isActive;
  String? lastModifiedDateTime;
  int? lastModifiedUserID;
  String? createdDateTime;
  int? createdUserID;
  int? companyID;

  SalesAgent(
      {this.salesAgentID,
      this.salesAgent,
      this.description,
      this.email,
      this.isActive,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID,
      this.companyID});

  SalesAgent.fromJson(Map<String, dynamic> json) {
    salesAgentID = json['salesAgentID'];
    salesAgent = json['salesAgent'];
    description = json['description'];
    email = json['email'];
    isActive = json['isActive'];
    lastModifiedDateTime = json['lastModifiedDateTime'];
    lastModifiedUserID = json['lastModifiedUserID'];
    createdDateTime = json['createdDateTime'];
    createdUserID = json['createdUserID'];
    companyID = json['companyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesAgentID'] = this.salesAgentID;
    data['salesAgent'] = this.salesAgent;
    data['description'] = this.description;
    data['email'] = this.email;
    data['isActive'] = this.isActive;
    data['lastModifiedDateTime'] = this.lastModifiedDateTime;
    data['lastModifiedUserID'] = this.lastModifiedUserID;
    data['createdDateTime'] = this.createdDateTime;
    data['createdUserID'] = this.createdUserID;
    data['companyID'] = this.companyID;
    return data;
  }
}

class CollectMappings {
  int? collectMappingID;
  int? collectDocID;
  double? paymentAmt;
  int? salesDocID;
  Sales? sales;
  double? editOutstanding;
  double? editPaymentAmt;

  CollectMappings(
      {this.collectMappingID,
      this.collectDocID,
      this.paymentAmt,
      this.salesDocID,
      this.sales,
      this.editOutstanding,
      this.editPaymentAmt});

  CollectMappings.fromJson(Map<String, dynamic> json) {
    collectMappingID = json['collectMappingID'];
    collectDocID = json['collectDocID'];
    paymentAmt = json['paymentAmt'];
    salesDocID = json['salesDocID'];
    sales = json['sales'] != null ? new Sales.fromJson(json['sales']) : null;
    editOutstanding = json['editOutstanding'];
    editPaymentAmt = json['editPaymentAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collectMappingID'] = this.collectMappingID;
    data['collectDocID'] = this.collectDocID;
    data['paymentAmt'] = this.paymentAmt;
    data['salesDocID'] = this.salesDocID;
    if (this.sales != null) {
      data['sales'] = this.sales!.toJson();
    }
    data['editOutstanding'] = this.editOutstanding;
    data['editPaymentAmt'] = this.editPaymentAmt;
    return data;
  }
}
