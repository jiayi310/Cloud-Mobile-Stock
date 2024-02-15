class Sales {
  String? docNo;
  String? docDate;
  String? customerCode;
  String? customerName;
  String? salesAgent;
  double? finalTotal;
  String? remark;

  Sales(this.docNo, this.docDate, this.customerCode, this.customerName,
      this.salesAgent, this.finalTotal, this.remark);

  Sales.fromJson(Map<String, dynamic> json) {
    docNo = json["docNo"];
    docDate = json["docDate"];
    customerCode = json["customerCode"];
    customerName = json["customerName"];
    salesAgent = json["salesAgent"];
    finalTotal = json["finalTotal"];
    remark = json["remark"];
  }
}
