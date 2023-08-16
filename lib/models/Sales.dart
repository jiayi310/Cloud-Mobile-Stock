import 'package:flutter/material.dart';

class Sales {
  final String DocNo;
  final String DocDate;
  final String DebtorCode;
  final String DebtorName;
  final String Agent;
  final double Total;
  final String Remark;

  Sales(this.DocNo, this.DocDate, this.DebtorCode, this.DebtorName, this.Agent,
      this.Total, this.Remark);
}

final List<Sales> demo_Sales = [
  Sales("IV-123896", "09/05/2000", "XER00001", "Sing Sdn Bhd", "Jason", 500.00,
      "jason@gmail.com"),
  Sales("IV-123896", "09/05/2000", "XER00001", "Sing Sdn Bhd", "Jason", 500.00,
      "jason@gmail.com"),
  Sales("IV-123896", "09/05/2000", "XER00001", "Sing Sdn Bhd", "Jason", 500.00,
      "jason@gmail.com"),
];
