import 'package:flutter/material.dart';

class Customer {
  final String AccNo;
  final String Name;
  final String Name2;
  final String Agent;
  final String Phone;
  final String Email;

  Customer(
      this.AccNo, this.Name, this.Name2, this.Agent, this.Phone, this.Email);
}

final List<Customer> demo_customer = [
  Customer(
      "300-A0001",
      "Sky Advanced Infinity (M) Sdn Bhd",
      "Sing Inficanty Pro (Z) Malaysia Sdn Bhd",
      "Jason",
      "011-985423668",
      "jason@gmail.com"),
  Customer("300-A0002", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
      "jason@gmail.com"),
  Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
      "jason@gmail.com"),
  Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
      "jason@gmail.com"),
  Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
      "jason@gmail.com"),
  Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
      "jason@gmail.com"),
  Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
      "jason@gmail.com"),
  Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
      "jason@gmail.com"),
  Customer("300-A001", "Sky Sdn Bhd", "Sing Sdn Bhd", "Jason", "011-985423668",
      "jason@gmail.com"),
];
