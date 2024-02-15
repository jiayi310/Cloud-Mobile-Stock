class Collection {
  String? docNo;
  String? docDate;
  String? customerCode;
  String? customerName;
  String? salesAgent;
  double? paymentTotal;
  String? refNo;

  Collection(this.docNo, this.docDate, this.customerCode, this.customerName,
      this.salesAgent, this.paymentTotal, this.refNo);

  Collection.fromJson(Map<String, dynamic> json) {
    docNo = json["docNo"];
    docDate = json["docDate"];
    customerCode = json["customerCode"];
    customerName = json["customerName"];
    salesAgent = json["salesAgent"];
    paymentTotal = json["paymentTotal"];
    refNo = json["refNo"];
  }
}
