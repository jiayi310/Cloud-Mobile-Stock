import 'package:flutter/material.dart';

class Product {
  String? stockCode;
  String? description;
  String? desc2;
  String? baseUOM;
  String? image, title;
  double? price;
  Color bgColor = Color(0xFFFEFBF9);

  Product(this.image, this.title, this.price, this.bgColor);

  Product.fromJson(Map<String, dynamic> json) {
    stockCode = json["stockCode"];
    description = json["description"];
    desc2 = json["desc2"];
    baseUOM = json["baseUOM"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockCode'] = this.stockCode;
    data['description'] = this.description;
    data['desc2'] = this.desc2;
    data['baseUOM'] = this.baseUOM;
    return data;
  }
}

List<Product> demo_product = [
  Product(
    "/Users/agilec/StudioProjects/MobileStock/AgilitiCloudMobileStock/assets/images/product_0.png",
    "Long Sleeve Shirts Long Sleeve Shirts Long Sleeve Shirts Long Sleeve Shirts Long Sleeve Shirts Long Sleeve Shirts",
    165.00,
    const Color(0xFFFEFBF9),
  ),
];
