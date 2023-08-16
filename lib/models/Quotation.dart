import 'package:flutter/material.dart';

class Quotation {
  final String DocNo;
  final String DocDate;
  final String DebtorCode;
  final String DebtorName;
  final String Agent;
  final double Total;
  final String Remark;

  Quotation(this.DocNo, this.DocDate, this.DebtorCode, this.DebtorName,
      this.Agent, this.Total, this.Remark);
}

final List<Quotation> demo_quotation = [
  Quotation("QT-123896", "09/05/2000", "XER00001", "Sing Sdn Bhd", "Jason",
      500.00, "jason@gmail.com"),
  Quotation("QT-123896", "09/05/2000", "XER00001", "Sing Sdn Bhd", "Jason",
      500.00, "jason@gmail.com"),
  Quotation("QT-123896", "09/05/2000", "XER00001", "Sing Sdn Bhd", "Jason",
      500.00, "jason@gmail.com"),
];
