class Collection {
  final String DocNo;
  final String DocDate;
  final String DebtorCode;
  final String DebtorName;
  final String Agent;
  final double Total;
  final String Remark;

  Collection(this.DocNo, this.DocDate, this.DebtorCode, this.DebtorName,
      this.Agent, this.Total, this.Remark);
}

final List<Collection> demo_collection = [
  Collection("AR-459621", "09/05/2000", "XER00001", "Sing Sdn Bhd", "Jason",
      500.00, "jason@gmail.com"),
  Collection("AR-784135", "09/05/2000", "XER00001", "Sing Sdn Bhd", "Jason",
      500.00, "jason@gmail.com"),
  Collection("AR-985698", "09/05/2000", "XER00001", "Sing Sdn Bhd", "Jason",
      500.00, "jason@gmail.com"),
];
