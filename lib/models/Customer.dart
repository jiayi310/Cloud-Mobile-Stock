class Customer {
  String? customerCode;
  String? name;
  String? name2;
  String? salesAgent;
  String? phone1;
  String? email;

  Customer(this.customerCode, this.name, this.name2, this.salesAgent,
      this.phone1, this.email);

  Customer.fromJson(Map<String, dynamic> json) {
    customerCode = json["customerCode"];
    name = json["name"];
    name2 = json["name2"];
    salesAgent = json["salesAgent"]["salesAgent"];
    phone1 = json["phone1"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerCode'] = this.customerCode;
    data['name'] = this.name;
    data['name2'] = this.name2;
    data['salesAgent'] = this.salesAgent;
    data['phone1'] = this.phone1;
    data['email'] = this.email;
    return data;
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
