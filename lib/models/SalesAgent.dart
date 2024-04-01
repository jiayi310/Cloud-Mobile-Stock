class SalesAgent {
  String? salesAgent;
  String? salesAgentDescription;
  double? amt;
  String? profileImage;

  SalesAgent({this.salesAgent, this.salesAgentDescription, this.amt});

  SalesAgent.fromJson(Map<String, dynamic> json) {
    salesAgent = json['salesAgent'];
    salesAgentDescription = json['salesAgentDescription'];
    amt = json['amt'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesAgent'] = this.salesAgent;
    data['salesAgentDescription'] = this.salesAgentDescription;
    data['amt'] = this.amt;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
